package com.formskorea.console.controller

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.*
import com.formskorea.console.service.ApplicationService
import com.formskorea.console.service.MailService
import com.formskorea.console.util.Etc
import com.formskorea.console.util.Token
import org.json.JSONObject
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.transaction.annotation.Transactional
import org.springframework.web.bind.annotation.*
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import kotlin.math.ceil

@RestController
@RequestMapping(value = ["/api"])
class APIController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var applicationService: ApplicationService

    @Autowired
    lateinit var mailService: MailService

    /**
     * Application Management
     * */

    @RequestMapping(value = ["/login"], produces = ["application/json"], method = [RequestMethod.POST])
    @ResponseBody
    @Throws(Exception::class)
    fun login(@RequestBody data: User, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        log.debug(data.toString())

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strMemberType.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_MEMBERTYPE
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strEmail.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_EMPTY_EMAIL
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && !Etc.checkEMail(data.strEmail.toString())) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_CHECK_EMAIL
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strPassword.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_MEMBERTYPE
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS) {
            try {
                data.isLogin = true
                val result = applicationService.info(data)

                if (result == null) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else if (result.strPassword2 != result.strPassword) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else if (result.intStatus == DefaultConfig.MEMBER_REJECT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_REJECT
                } else if (result.intStatus == DefaultConfig.MEMBER_CUT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
                } else {
                    result.strMemberType = data.strMemberType
                    Etc.setCookie(
                        DefaultConfig.TOKEN_ISSUER, Token.make(result), response, if (data.isSave) {
                            15
                        } else {
                            -1
                        }
                    )
                }

            } catch (e: Exception) {
                log.error(e.message)
                rtnValue.error = DefaultConfig.ERROR_DBERROR
                rtnValue.status = DefaultConfig.SERVER_DBERROR
                rtnValue.message = DefaultConfig.MESSAGE_DBERROR
            }
        }

        return rtnValue
    }

    @RequestMapping(value = ["/info"])
    @ResponseBody
    @Throws(Exception::class)
    fun info(response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)

        try {
            val info = Token.get(token.toString(), DefaultConfig.TOKEN_EXPDAY)

            log.error(info.toString())

            if (info == null) {
                rtnValue.error = DefaultConfig.ERROR_NOTFOUND
                rtnValue.status = DefaultConfig.SERVER_NOTUSER
                rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
            } else {
                val result = applicationService.info(info)

                if (result == null) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else if (result.strPassword2 != result.strPassword) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else if (result.intStatus == DefaultConfig.MEMBER_REJECT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_REJECT
                } else if (result.intStatus == DefaultConfig.MEMBER_CUT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
                } else {
                    result.intSeq = null
                    result.strPassword = null
                    result.strPassword2 = null
                    result.intCompanySeq = null
                    result.dateReg = null
                    result.dateEdit = null
                    result.intCompanySeq = null

                    rtnValue.result = result
                }
            }
        } catch (e: Exception) {
            rtnValue.error = DefaultConfig.ERROR_NOTFOUND
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
        }

        return rtnValue
    }

    @RequestMapping(value = ["/join"])
    @ResponseBody
    @Transactional
    @Throws(Exception::class)
    fun join(@RequestBody data: User, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        log.error(data.toString())

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strName.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_EMPTY_NAME
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strEmail.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_EMPTY_EMAIL
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && !Etc.checkEMail(data.strEmail.toString())) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_CHECK_EMAIL
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && (data.strPassword.isNullOrEmpty() || data.strPassword2.isNullOrEmpty())) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_EMPTY_PASSWORD
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && (data.strPassword != data.strPassword2)) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_PASSNOTMATCH
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strMemberType.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_MEMBERTYPE
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS) {
            try {
                var cresult: Boolean? = true
                log.error(data.toString())

                if (data.intLevel == null) {
                    data.intLevel = 1
                }
                if (data.intStatus == null) {
                    data.intStatus = 0
                }

                if (data.company != null && !data.company?.strCompanyname.isNullOrEmpty()) {
                    data.company!!.strAddress += "|" + data.company!!.strAddress2
                    data.company!!.intStatus = 1
                    cresult = applicationService.setCompany(data.company!!)
                    if (cresult != null && cresult == true) {
                        data.intCompanySeq = data.company?.intSeq
                    }
                }

                var result = applicationService.setUser(data)

                if (result == null) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else {
                    if (data.media != null) {
                        for (field in data.media!!) {
                            if (!field.strURL.isNullOrEmpty()) {
                                field.intUserSeq = data.intSeq
                                field.intUserType = when (data.strMemberType) {
                                    DefaultConfig.MEMBER_CLIENT -> {
                                        1
                                    }
                                    DefaultConfig.MEMBER_INFLUENCER -> {
                                        2
                                    }
                                    else -> {
                                        9
                                    }
                                }
                                applicationService.setMedia(field)
                            }
                        }
                    }

                    rtnValue.result = data.intSeq
                }

            } catch (e: Exception) {
                log.error(e.message)
                rtnValue.error = DefaultConfig.ERROR_DBERROR
                rtnValue.status = DefaultConfig.SERVER_DBERROR
                rtnValue.message = DefaultConfig.MESSAGE_DBERROR
            }

        }

        return rtnValue
    }

    @RequestMapping(value = ["/useredit"])
    @ResponseBody
    @Transactional
    @Throws(Exception::class)
    fun useredit(@RequestBody data: User, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)

        try {
            val info = Token.get(token, DefaultConfig.TOKEN_EXPDAY)
            if (info == null) {
                rtnValue.error = DefaultConfig.ERROR_NOTFOUND
                rtnValue.status = DefaultConfig.SERVER_NOTUSER
                rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
            } else {
                val result = applicationService.info(info)
                if (result == null) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else if (result.intStatus == DefaultConfig.MEMBER_REJECT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_REJECT
                } else if (result.intStatus == DefaultConfig.MEMBER_CUT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
                } else {
                    data.intSeq = info.intSeq
                    data.isSave = info.isSave
                    data.intCompanySeq = result.intCompanySeq
                    data.company?.intSeq = result.intCompanySeq
                }
            }
        } catch (e: Exception) {
            log.error(e.message)

            rtnValue.error = DefaultConfig.ERROR_NOTFOUND
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strEmail.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_EMPTY_EMAIL
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && !Etc.checkEMail(data.strEmail.toString())) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_CHECK_EMAIL
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strMemberType.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_MEMBERTYPE
        }

        log.error(data.toString())

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS) {
            try {
                applicationService.editUser(data)
                Etc.setCookie(
                    DefaultConfig.TOKEN_ISSUER, Token.make(data), response, if (data.isSave) {
                        15
                    } else {
                        -1
                    }
                )
            } catch (e: Exception) {
                log.error(e.message)
                rtnValue.error = DefaultConfig.ERROR_NOTFOUND
                rtnValue.status = DefaultConfig.SERVER_NOTUSER
                rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
            }
        }

        return rtnValue
    }

    @RequestMapping(value = ["/find"], produces = ["application/json"], method = [RequestMethod.POST])
    @ResponseBody
    @Throws(Exception::class)
    fun find(@RequestBody data: User, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        log.debug(data.toString())

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strMemberType.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_MEMBERTYPE
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strEmail.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_EMPTY_EMAIL
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && !Etc.checkEMail(data.strEmail.toString())) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_CHECK_EMAIL
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS) {
            try {
                val result = applicationService.info(data)

                if (result == null) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else if (result.intStatus == DefaultConfig.MEMBER_REJECT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_REJECT
                } else if (result.intStatus == DefaultConfig.MEMBER_CUT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
                } else {
                    data.strPassword = Etc.random(111111, 999999).toString()
                    applicationService.editUser(data)
                    try {
                        mailService.sendMail(
                            DefaultConfig.MAIL_SEND_PASSWORD_TITLE,
                            DefaultConfig.MAIL_SEND_PASSWORD_INFO.replace(
                                "{new_password}",
                                data.strPassword.toString()
                            ),
                            data.strEmail.toString()
                        )
                    } catch (e: Exception) {
                        log.error(e.message)
                        rtnValue.error = DefaultConfig.ERROR_PROCESS
                        rtnValue.status = DefaultConfig.SERVER_PARAMERROR
                        rtnValue.message = DefaultConfig.MESSAGE_PROCESS
                    }
                }

            } catch (e: Exception) {
                rtnValue.error = DefaultConfig.ERROR_DBERROR
                rtnValue.status = DefaultConfig.SERVER_DBERROR
                rtnValue.message = DefaultConfig.MESSAGE_DBERROR
            }
        }

        return rtnValue
    }


    @RequestMapping(value = ["/repass"], produces = ["application/json"], method = [RequestMethod.POST])
    @ResponseBody
    @Throws(Exception::class)
    fun repass(@RequestBody data: User, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        log.debug(data.toString())

        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)

        try {
            val info = Token.get(token, DefaultConfig.TOKEN_EXPDAY)
            if (info == null) {
                rtnValue.error = DefaultConfig.ERROR_NOTFOUND
                rtnValue.status = DefaultConfig.SERVER_NOTUSER
                rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
            } else {
                val result = applicationService.info(info)
                if (result == null) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else if (result.intStatus == DefaultConfig.MEMBER_REJECT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_REJECT
                } else if (result.intStatus == DefaultConfig.MEMBER_CUT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
                } else {
                    data.intSeq = info.intSeq
                    data.isSave = info.isSave
                    data.intCompanySeq = result.intCompanySeq
                    data.company?.intSeq = result.intCompanySeq
                }
            }
        } catch (e: Exception) {
            log.error(e.message)

            rtnValue.error = DefaultConfig.ERROR_NOTFOUND
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strPassword.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_EMPTY_PASSWORD
        }
        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS) {
            try {
                val result = applicationService.info(data)

                if (result == null) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else if (result.intStatus == DefaultConfig.MEMBER_REJECT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_REJECT
                } else if (result.intStatus == DefaultConfig.MEMBER_CUT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
                } else if (result.strPassword != result.strPassword2) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_PASSNOTMATCH
                } else {
                    data.strPassword = data.strPassword2
                    data.intCompanySeq = null
                    applicationService.editPass(data)
                }
            } catch (e: Exception) {
                rtnValue.error = DefaultConfig.ERROR_DBERROR
                rtnValue.status = DefaultConfig.SERVER_DBERROR
                rtnValue.message = DefaultConfig.MESSAGE_DBERROR
            }
        }

        return rtnValue
    }

    /**
     * Influencer Management
     * */

    @RequestMapping(value = ["/influencer/list"], produces = ["application/json"], method = [RequestMethod.POST])
    @ResponseBody
    @Throws(Exception::class)
    fun getInfluencer(@RequestBody data: Search, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        log.debug(data.toString())

        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isInfluencer = false

        try {
            val info = Token.get(token, DefaultConfig.TOKEN_EXPDAY)
            if (info == null) {
                rtnValue.error = DefaultConfig.ERROR_NOTFOUND
                rtnValue.status = DefaultConfig.SERVER_NOTUSER
                rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
            } else {
                val result = applicationService.info(info)
                if (result == null) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else if (result.intStatus == DefaultConfig.MEMBER_REJECT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_REJECT
                } else if (result.intStatus == DefaultConfig.MEMBER_CUT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
                } else {
                    if (!result.txtPermission.isNullOrEmpty()) {
                        val permJson = JSONObject(result.txtPermission)
                        if(!permJson.isNull(DefaultConfig.PERM_INFLUENCER_READ) && permJson.getBoolean(DefaultConfig.PERM_INFLUENCER_READ)) {
                            isInfluencer = true
                        }
                    }
                    if(result.intSuper == 1) {
                        isInfluencer = true
                    }

                }
            }
        } catch (e: Exception) {
            log.error(e.message)
            rtnValue.error = DefaultConfig.ERROR_NOTFOUND
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
        }

        if (!isInfluencer) {
            rtnValue.error = DefaultConfig.ERROR_NOTUSER
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS) {
            try {
                val list = ListPage<User>()
                list.total = applicationService.getMInfluncerCount(data)
                if (list.total != null && list.total!! > 0) {
                    val page = list.total!!.toDouble() / data.length!!
                    list.max_page = ceil(page).toInt()
                    list.list = applicationService.getMInfluncerInfo(data)
                    for(field in list.list!!) {
                        if(field.intCompanySeq != null && field.intCompanySeq!! > 0) {
                            val company = Company()
                            company.intSeq = field.intCompanySeq
                            field.company = applicationService.getCompany(company)
                        }

                        val media = Media()
                        media.intUserType = 2
                        media.intUserSeq = field.intSeq
                        field.media = applicationService.getMedia(media)
                    }
                }
                rtnValue.result = list
            } catch (e: Exception) {
                rtnValue.error = DefaultConfig.ERROR_DBERROR
                rtnValue.status = DefaultConfig.SERVER_DBERROR
                rtnValue.message = DefaultConfig.MESSAGE_DBERROR
            }
        }

        return rtnValue
    }

    /**
     * Client Management
     * */

    @RequestMapping(value = ["/client/list"], produces = ["application/json"], method = [RequestMethod.POST])
    @ResponseBody
    @Throws(Exception::class)
    fun getClient(@RequestBody data: Search, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        log.debug(data.toString())

        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isClient = false

        try {
            val info = Token.get(token, DefaultConfig.TOKEN_EXPDAY)
            if (info == null) {
                rtnValue.error = DefaultConfig.ERROR_NOTFOUND
                rtnValue.status = DefaultConfig.SERVER_NOTUSER
                rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
            } else {
                val result = applicationService.info(info)
                if (result == null) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else if (result.intStatus == DefaultConfig.MEMBER_REJECT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_REJECT
                } else if (result.intStatus == DefaultConfig.MEMBER_CUT) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
                } else {
                    if (!result.txtPermission.isNullOrEmpty()) {
                        val permJson = JSONObject(result.txtPermission)
                        if(!permJson.isNull(DefaultConfig.PERM_CLIENT_READ) && permJson.getBoolean(DefaultConfig.PERM_CLIENT_READ)) {
                                isClient = true
                        }
                    }
                    if(result.intSuper == 1) {
                        isClient = true
                    }
                }
            }
        } catch (e: Exception) {
            log.error(e.message)
            rtnValue.error = DefaultConfig.ERROR_NOTFOUND
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
        }

        if (!isClient) {
            rtnValue.error = DefaultConfig.ERROR_NOTUSER
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS) {
            try {
                val list = ListPage<User>()
                list.total = applicationService.getMClientCount(data)
                if (list.total != null && list.total!! > 0) {
                    val page = list.total!!.toDouble() / data.length!!
                    list.max_page = ceil(page).toInt()
                    list.list = applicationService.getMClientInfo(data)
                    for(field in list.list!!) {
                        val company = Company()
                        company.intSeq = field.intCompanySeq
                        field.company = applicationService.getCompany(company)
                    }
                }
                rtnValue.result = list
            } catch (e: Exception) {
                rtnValue.error = DefaultConfig.ERROR_DBERROR
                rtnValue.status = DefaultConfig.SERVER_DBERROR
                rtnValue.message = DefaultConfig.MESSAGE_DBERROR
            }
        }

        return rtnValue
    }
}
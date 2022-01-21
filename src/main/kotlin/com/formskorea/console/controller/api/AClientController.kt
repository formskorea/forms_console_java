package com.formskorea.console.controller.api

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.*
import com.formskorea.console.service.AdminService
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
@RequestMapping(value = ["/api/client"])
class AClientController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var applicationService: ApplicationService

    @Autowired
    lateinit var adminService: AdminService

    @Autowired
    lateinit var mailService: MailService

    /**
     * Client Management
     * */

    @RequestMapping(value = ["/list"], produces = ["application/json"], method = [RequestMethod.POST])
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
                list.total = adminService.getMClientCount(data)
                if (list.total != null && list.total!! > 0) {
                    val page = list.total!!.toDouble() / data.length!!
                    list.max_page = ceil(page).toInt()
                    list.list = adminService.getMClientInfo(data)
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

    @RequestMapping(value = ["/edit"], produces = ["application/json"], method = [RequestMethod.POST])
    @ResponseBody
    @Throws(Exception::class)
    fun editInfluencer(@RequestBody data: User, response: HttpServletResponse, request: HttpServletRequest): Any {
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
                        if(!permJson.isNull(DefaultConfig.PERM_INFLUENCER_READ) && permJson.getBoolean(DefaultConfig.PERM_INFLUENCER_EDIT)) {
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
                var cresult: Boolean? = true
                log.error(data.toString())

                if (data.intLevel == null) {
                    data.intLevel = 1
                }
                if (data.intStatus == null) {
                    data.intStatus = 0
                }

                if(!data.strMobile.isNullOrEmpty()) {
                    data.strMobile = Etc.setTelnum(data.strMobile!!)
                }

                data.strMemberType = DefaultConfig.MEMBER_CLIENT
                var result = applicationService.editUser(data)

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

    @RequestMapping(value = ["/add"], produces = ["application/json"], method = [RequestMethod.POST])
    @ResponseBody
    @Transactional(value = "db1transactionManager")
    @Throws(Exception::class)
    fun setInfluencer(@RequestBody data: User, response: HttpServletResponse, request: HttpServletRequest): Any {
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

                data.strMemberType = DefaultConfig.MEMBER_CLIENT

                if(!data.strMobile.isNullOrEmpty()) {
                    data.strMobile = Etc.setTelnum(data.strMobile!!)
                }

                if (data.company != null && !data.company?.strCompanyname.isNullOrEmpty()) {
                    data.company!!.strAddress += "|" + data.company!!.strAddress2
                    data.company!!.intStatus = 1

                    if(!data.company?.strTelnum.isNullOrEmpty()) {
                        data.company?.strTelnum = Etc.setTelnum(data.company?.strTelnum!!)
                    }

                    cresult = if (data.company?.intSeq != null && data.company?.intSeq!! > 0) {
                        applicationService.editCompany(data.company!!)
                    } else {
                        applicationService.setCompany(data.company!!)
                    }
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

}
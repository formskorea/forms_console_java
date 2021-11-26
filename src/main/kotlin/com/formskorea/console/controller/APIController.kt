package com.formskorea.console.controller

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.ReturnValue
import com.formskorea.console.data.model.User
import com.formskorea.console.service.ApplicationService
import com.formskorea.console.util.Etc
import com.formskorea.console.util.Token
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@RestController
@RequestMapping(value = ["/api"])
class APIController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var applicationService: ApplicationService


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
                    rtnValue.result = Token.make(result)
                }

            } catch (e: Exception) {
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
    fun info(
        @RequestHeader(value = DefaultConfig.TOKEN_NAME) token: String?,
        response: HttpServletResponse,
        request: HttpServletRequest
    ): Any {
        val rtnValue = ReturnValue()

        try {
            val info = Token.get(token.toString(), DefaultConfig.TOKEN_EXPDAY)

            log.error(info.toString())

            if (info == null) {
                rtnValue.error = DefaultConfig.ERROR_NOTFOUND
                rtnValue.status = DefaultConfig.SERVER_NOTUSER
                rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
            } else {
                val result = applicationService.info(info)
                result?.intSeq = null
                result?.strPassword = null
                result?.strPassword2 = null
                result?.intCompanySeq = null
                result?.dateReg = null
                result?.dateEdit = null

                rtnValue.result = result
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
    @Throws(Exception::class)
    fun join(@RequestBody data: User, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        log.error(data.toString())

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

                if(data.intLevel == null) {
                    data.intLevel = 1
                }
                if(data.intStatus == null) {
                    data.intStatus = 0
                }

                if (data.company != null && !data.company?.strCompanyname.isNullOrEmpty()) {
                    val ccresult = applicationService.getCompany(data.company!!)

                    if(ccresult == null) {
                        data.company!!.strAddress += "|" + data.company!!.strAddress2
                        cresult = applicationService.setCompany(data.company!!)
                        if (cresult != null && cresult == true) {
                            data.intCompanySeq = data.company?.intSeq
                        }
                    } else {
                        data.intCompanySeq = ccresult.intSeq
                    }
                }

                var result = applicationService.setUser(data)

                if (result == null) {
                    rtnValue.error = DefaultConfig.ERROR_NOTUSER
                    rtnValue.status = DefaultConfig.SERVER_NOTUSER
                    rtnValue.message = DefaultConfig.MESSAGE_INFONULL
                } else {
                    if(data.media != null) {
                        for(field in data.media!!) {
                            if(!field.strURL.isNullOrEmpty()) {
                                field.intUserSeq = data.intSeq
                                field.intUserType = when(data.strMemberType) {
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


    @RequestMapping(value = ["/find"])
    @ResponseBody
    @Throws(Exception::class)
    fun find(response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()



        return rtnValue
    }


}
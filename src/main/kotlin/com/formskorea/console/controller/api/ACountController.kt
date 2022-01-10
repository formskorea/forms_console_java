package com.formskorea.console.controller.api

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.*
import com.formskorea.console.service.ApplicationService
import com.formskorea.console.service.CountService
import com.formskorea.console.util.Etc
import com.formskorea.console.util.Token
import org.json.JSONObject
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import kotlin.math.ceil


@RestController
@RequestMapping(value = ["/api/count"])
class ACountController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var countService: CountService

    @Autowired
    lateinit var applicationService: ApplicationService

    @RequestMapping(value = ["/work"], produces = ["application/json"], method = [RequestMethod.POST])
    @ResponseBody
    @Throws(Exception::class)
    fun getWorkCount(@RequestBody data: Search, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        log.debug(data.toString())

        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isMain = false

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
                        if(!permJson.isNull(DefaultConfig.PERM_MAIN_READ) && permJson.getBoolean(DefaultConfig.PERM_MAIN_READ)) {
                            isMain = true
                        }
                    }
                    if(result.intSuper == 1) {
                        isMain = true
                    }
                }
            }
        } catch (e: Exception) {
            log.error(e.message)
            rtnValue.error = DefaultConfig.ERROR_NOTFOUND
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
        }

        if(!isMain) {
            rtnValue.error = DefaultConfig.ERROR_NOTUSER
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS) {
            try {
                rtnValue.result = countService.getCountWork(data)
            } catch (e: Exception) {
                log.error(e.toString())
                rtnValue.error = DefaultConfig.ERROR_DBERROR
                rtnValue.status = DefaultConfig.SERVER_DBERROR
                rtnValue.message = DefaultConfig.MESSAGE_DBERROR
            }
        }

        return rtnValue
    }

    @RequestMapping(value = ["/user"], produces = ["application/json"], method = [RequestMethod.POST])
    @ResponseBody
    @Throws(Exception::class)
    fun getUserCount(@RequestBody data: Search, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        log.debug(data.toString())

        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isMain = false

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
                        if(!permJson.isNull(DefaultConfig.PERM_MAIN_READ) && permJson.getBoolean(DefaultConfig.PERM_MAIN_READ)) {
                            isMain = true
                        }
                    }
                    if(result.intSuper == 1) {
                        isMain = true
                    }
                }
            }
        } catch (e: Exception) {
            log.error(e.message)
            rtnValue.error = DefaultConfig.ERROR_NOTFOUND
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
        }

        if(!isMain) {
            rtnValue.error = DefaultConfig.ERROR_NOTUSER
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS) {
            try {
                rtnValue.result = countService.getCountUsers(data)
            } catch (e: Exception) {
                log.error(e.toString())
                rtnValue.error = DefaultConfig.ERROR_DBERROR
                rtnValue.status = DefaultConfig.SERVER_DBERROR
                rtnValue.message = DefaultConfig.MESSAGE_DBERROR
            }
        }

        return rtnValue
    }

}
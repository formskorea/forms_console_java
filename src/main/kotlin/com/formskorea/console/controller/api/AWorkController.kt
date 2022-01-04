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
import org.springframework.web.bind.annotation.*
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import kotlin.math.ceil

@RestController
@RequestMapping(value = ["/api/work"])
class AWorkController {
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

    @RequestMapping(value = ["/add"], produces = ["application/json"], method = [RequestMethod.POST])
    @ResponseBody
    @Throws(Exception::class)
    fun setWork(@RequestBody data: Work, response: HttpServletResponse, request: HttpServletRequest): Any {
        val rtnValue = ReturnValue()

        log.debug(data.toString())

        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isWorkAdd = false

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
                        if (!permJson.isNull(DefaultConfig.PERM_WORK_ADD) && permJson.getBoolean(DefaultConfig.PERM_WORK_ADD)) {
                            isWorkAdd = true
                        }
                    }
                    if ((info.strMemberType == DefaultConfig.MEMBER_ADMIN || info.strMemberType == DefaultConfig.MEMBER_ADMIN) && result.intSuper == 1) {
                        isWorkAdd = true
                    }
                }
            }
        } catch (e: Exception) {
            log.error(e.message)
            rtnValue.error = DefaultConfig.ERROR_NOTFOUND
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_TOKENOUT
        }

        if (!isWorkAdd) {
            rtnValue.error = DefaultConfig.ERROR_NOTUSER
            rtnValue.status = DefaultConfig.SERVER_NOTUSER
            rtnValue.message = DefaultConfig.MESSAGE_NOTUSER
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.strTitle.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_WORK_TITLE
        }
        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && (data.dateReadystart.isNullOrEmpty() || data.dateReadyend.isNullOrEmpty())) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_WORK_READYDAY
        }
        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && (data.dateStart.isNullOrEmpty() || data.dateEnd.isNullOrEmpty())) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_WORK_DAY
        }
        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && (data.tags == null || data.tags!!.size <= 0)) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_WORK_NOTAG
        }
        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && data.txtInfo.isNullOrEmpty()) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_WORK_INFO
        }
        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS && (data.infos == null || data.infos!!.size <= 0)) {
            rtnValue.error = DefaultConfig.ERROR_PARAM
            rtnValue.status = DefaultConfig.SERVER_PARAMERROR
            rtnValue.message = DefaultConfig.MESSAGE_WORK_NOCOUNT
        }

        if (rtnValue.status == DefaultConfig.SERVER_SUCCESS) {
            var result = adminService.setMWork(data)

            if (result == null) {
                rtnValue.error = DefaultConfig.ERROR_NOTUSER
                rtnValue.status = DefaultConfig.SERVER_NOTUSER
                rtnValue.message = DefaultConfig.MESSAGE_INFONULL
            } else {
                rtnValue.result = data.intSeq
            }
        }
        return rtnValue
    }

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
                        if(!permJson.isNull(DefaultConfig.PERM_WORK_READ) && permJson.getBoolean(DefaultConfig.PERM_WORK_READ)) {
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
                val list = ListPage<Work>()
                list.total = adminService.getMWorkCount(data)
                if (list.total != null && list.total!! > 0) {
                    val page = list.total!!.toDouble() / data.length!!
                    list.max_page = ceil(page).toInt()
                    list.list = adminService.getMWork(data)
                    for(field in list.list!!) {
                        field.txtInfo = null
                        val winfo = WorkInfo()
                        winfo.intWorkSeq = field.intSeq
                        val workinfo = adminService.getMWorkInfo(winfo)
                        field.infos = workinfo
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
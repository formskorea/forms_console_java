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
@RequestMapping(value = ["/api/influencer"])
class AInfluencerController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var applicationService: ApplicationService

    @Autowired
    lateinit var adminService: AdminService

    @Autowired
    lateinit var mailService: MailService

    /**
     * Influencer Management
     * */

    @RequestMapping(value = ["/list"], produces = ["application/json"], method = [RequestMethod.POST])
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
                list.total = adminService.getMInfluncerCount(data)
                if (list.total != null && list.total!! > 0) {
                    val page = list.total!!.toDouble() / data.length!!
                    list.max_page = ceil(page).toInt()
                    list.list = adminService.getMInfluncerInfo(data)
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
                log.error(e.message)
                rtnValue.error = DefaultConfig.ERROR_DBERROR
                rtnValue.status = DefaultConfig.SERVER_DBERROR
                rtnValue.message = DefaultConfig.MESSAGE_DBERROR
            }
        }

        return rtnValue
    }

}
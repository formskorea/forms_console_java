package com.formskorea.console.controller.web

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.*
import com.formskorea.console.service.AdminService
import com.formskorea.console.service.ApplicationService
import com.formskorea.console.util.Etc
import com.formskorea.console.util.Token
import org.json.JSONObject
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.view.RedirectView
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Controller
@RequestMapping(value = ["/work"])
class WorkController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var applicationService: ApplicationService

    @Autowired
    lateinit var adminService: AdminService

    @RequestMapping(value = ["/list", "/"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun list(model: Model, response: HttpServletResponse, request: HttpServletRequest): Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isLogin = false
        var isUse = false

        if (token != "") {
            try {
                var userinfo = Token.get(token, DefaultConfig.TOKEN_EXPDAY)

                if (userinfo != null) {
                    val userinfo2 = applicationService.info(userinfo)
                    log.error(userinfo.toString())
                    if (userinfo2?.intStatus == DefaultConfig.MEMBER_OK || userinfo2?.intStatus == DefaultConfig.MEMBER_JOIN) {
                        isLogin = true
                        userinfo2.strMemberType = userinfo.strMemberType
                        model.addAttribute("fmcuser", userinfo2)

                        if (!userinfo2.txtPermission.isNullOrEmpty()) {
                            val permJson = JSONObject(userinfo2.txtPermission)
                            if(!permJson.isNull(DefaultConfig.PERM_WORK_READ) && permJson.getBoolean(DefaultConfig.PERM_WORK_READ)) {
                                isUse = true
                            }
                        }
                        if((userinfo.strMemberType == DefaultConfig.MEMBER_CLIENT || userinfo.strMemberType == DefaultConfig.MEMBER_ADMIN) && userinfo2.intSuper == 1) {
                            isUse = true
                        }
                    }
                }
            } catch (e: Exception) {
                log.error(e.message)
            }
        }

        if (!isLogin) {
            return RedirectView("/login")
        }

        if(!isUse) {
            return RedirectView("/pmerror")
        }

        val scripts = ArrayList<String>()
        scripts.add("/js/work.js")
        model.addAttribute("scripts", scripts)

        val styles = ArrayList<String>()
        styles.add("/css/loading.css")
        model.addAttribute("styles", styles)

        return "work"
    }

    @RequestMapping(value = ["/add"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun add(model: Model, response: HttpServletResponse, request: HttpServletRequest): Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isLogin = false
        var isUse = false

        if (token != "") {
            try {
                var userinfo = Token.get(token, DefaultConfig.TOKEN_EXPDAY)

                log.error(userinfo.toString())

                if (userinfo != null) {
                    val userinfo2 = applicationService.info(userinfo)
                    log.error(userinfo.toString())
                    if (userinfo2?.intStatus == DefaultConfig.MEMBER_OK || userinfo2?.intStatus == DefaultConfig.MEMBER_JOIN) {
                        isLogin = true
                        userinfo2.strMemberType = userinfo.strMemberType
                        model.addAttribute("fmcuser", userinfo2)

                        if (!userinfo2.txtPermission.isNullOrEmpty()) {
                            val permJson = JSONObject(userinfo2.txtPermission)
                            if(!permJson.isNull(DefaultConfig.PERM_WORK_READ) && permJson.getBoolean(DefaultConfig.PERM_WORK_READ)) {
                                isUse = true
                            }
                        }
                        if((userinfo.strMemberType == DefaultConfig.MEMBER_CLIENT || userinfo.strMemberType == DefaultConfig.MEMBER_ADMIN) && userinfo2.intSuper == 1) {
                            isUse = true
                        }
                    }
                }
            } catch (e: Exception) {
                log.error(e.message)
            }
        }

        if (!isLogin) {
            return RedirectView("/login")
        }

        val scripts = ArrayList<String>()
        scripts.add("/js/tagify.min.js")
        scripts.add("/js/workadd.js")
        model.addAttribute("scripts", scripts)

        val styles = ArrayList<String>()
        styles.add("/css/tagify.css")
        styles.add("/css/loading.css")
        model.addAttribute("styles", styles)

        return "workadd"
    }

    @RequestMapping(value = ["/read/{workseq}"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun read(model: Model, @PathVariable workseq: Int, response: HttpServletResponse, request: HttpServletRequest): Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isLogin = false
        var isUse = false

        if (token != "") {
            try {
                var userinfo = Token.get(token, DefaultConfig.TOKEN_EXPDAY)

                log.error(userinfo.toString())

                if (userinfo != null) {
                    val userinfo2 = applicationService.info(userinfo)
                    log.error(userinfo.toString())
                    if (userinfo2?.intStatus == DefaultConfig.MEMBER_OK || userinfo2?.intStatus == DefaultConfig.MEMBER_JOIN) {
                        isLogin = true
                        userinfo2.strMemberType = userinfo.strMemberType
                        model.addAttribute("fmcuser", userinfo2)

                        if (!userinfo2.txtPermission.isNullOrEmpty()) {
                            val permJson = JSONObject(userinfo2.txtPermission)
                            if(!permJson.isNull(DefaultConfig.PERM_WORK_READ) && permJson.getBoolean(DefaultConfig.PERM_WORK_READ)) {
                                isUse = true
                            }
                        }
                        if((userinfo.strMemberType == DefaultConfig.MEMBER_CLIENT || userinfo.strMemberType == DefaultConfig.MEMBER_ADMIN) && userinfo2.intSuper == 1) {
                            isUse = true
                        }
                    }
                }
            } catch (e: Exception) {
                log.error(e.message)
            }
        }

        val search = Search()
        search.seq = workseq
        search.limit = 0
        search.length = 1
        val result = adminService.getMWork(search)
        var work = Work()
        if(!result.isNullOrEmpty()) {
            work = result[0]
            val workInfo = WorkInfo()
            workInfo.intWorkSeq = work.intSeq
            work.infos = adminService.getMWorkInfo(workInfo)
            if(!work.infos.isNullOrEmpty()) {
                for (field in work.infos!!) {
                    search.seq = field.intInfSeq
                    val result3 = adminService.getMInfluncerInfo(search)
                    if(!result3.isNullOrEmpty()) {
                        field.influencer = result3[0]
                    }
                }
            }

            val tag = Tag()
            tag.intWorkSeq = workseq
            work.tags = applicationService.getTags(tag)

            search.seq = work.intClientSeq
            val result2 = adminService.getMClientInfo(search)
            if(!result2.isNullOrEmpty()) {
                work.client = result2[0]
            }
            val company = Company()
            company.intSeq = work.intCompanySeq
            work.company = applicationService.getCompany(company)
        }

        if (!isLogin) {
            return RedirectView("/login")
        }

        val scripts = ArrayList<String>()
        scripts.add("/js/workread.js")
        model.addAttribute("scripts", scripts)

        val styles = ArrayList<String>()
        styles.add("/css/loading.css")
        model.addAttribute("styles", styles)

        model.addAttribute("workseq", workseq)
        model.addAttribute("work", work)

        return "workread"
    }

}
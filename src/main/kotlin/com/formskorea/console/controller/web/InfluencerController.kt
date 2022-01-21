package com.formskorea.console.controller.web

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.User
import com.formskorea.console.service.AdminService
import com.formskorea.console.service.ApplicationService
import com.formskorea.console.util.Etc
import com.formskorea.console.util.Token
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
@RequestMapping(value = ["/influencer"])
class InfluencerController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var applicationService: ApplicationService

    @Autowired
    lateinit var adminService: AdminService

    @RequestMapping(value = ["/list"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun list(model: Model, response: HttpServletResponse, request: HttpServletRequest): Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isLogin = false

        val keyword = request.getParameter("keyword")
        val page = request.getParameter("page")
        val status = request.getParameter("status")

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

                        model.addAttribute("keyword", keyword)
                        model.addAttribute("page", page)
                        model.addAttribute("status", status)
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
        scripts.add("/js/influencer.js")
        model.addAttribute("scripts", scripts)

        val styles = ArrayList<String>()
        styles.add("/css/loading.css")
        model.addAttribute("styles", styles)

        return "influencer"
    }

    @RequestMapping(value = ["/add"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun add(model: Model, response: HttpServletResponse, request: HttpServletRequest): Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isLogin = false

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
                        model.addAttribute("influencer", User())
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
        scripts.add("//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js")
        scripts.add("/js/tagify.min.js")
        scripts.add("/js/influenceradd.js")
        model.addAttribute("scripts", scripts)

        val styles = ArrayList<String>()
        styles.add("/css/loading.css")
        styles.add("/css/tagify.css")
        model.addAttribute("styles", styles)

        return "influenceradd"
    }

    @RequestMapping(value = ["/read/{infseq}"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun read(model: Model, @PathVariable infseq: Int, response: HttpServletResponse, request: HttpServletRequest): Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isLogin = false

        val keyword = request.getParameter("keyword")
        val page = request.getParameter("page")
        val status = request.getParameter("status")

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

                        val user = User()
                        user.intSeq = infseq
                        user.strMemberType = DefaultConfig.MEMBER_INFLUENCER

                        val result = applicationService.info(user)

                        model.addAttribute("influencer", result)
                        model.addAttribute("keyword", keyword)
                        model.addAttribute("page", page)
                        model.addAttribute("status", status)
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
        scripts.add("/js/influencerread.js")
        model.addAttribute("scripts", scripts)

        val styles = ArrayList<String>()
        styles.add("/css/loading.css")
        model.addAttribute("styles", styles)

        return "influencerread"
    }

    @RequestMapping(value = ["/edit/{infseq}"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun edit(model: Model, @PathVariable infseq: Int, response: HttpServletResponse, request: HttpServletRequest): Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request)
        var isLogin = false

        val keyword = request.getParameter("keyword")
        val page = request.getParameter("page")
        val status = request.getParameter("status")

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

                        val user = User()
                        user.intSeq = infseq
                        user.strMemberType = DefaultConfig.MEMBER_INFLUENCER

                        val result = applicationService.info(user)

                        model.addAttribute("influencer", result)
                        model.addAttribute("keyword", keyword)
                        model.addAttribute("page", page)
                        model.addAttribute("status", status)
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
        scripts.add("//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js")
        scripts.add("/js/tagify.min.js")
        scripts.add("/js/influenceradd.js")
        model.addAttribute("scripts", scripts)

        val styles = ArrayList<String>()
        styles.add("/css/tagify.css")
        styles.add("/css/loading.css")
        model.addAttribute("styles", styles)

        return "influenceradd"
    }

}
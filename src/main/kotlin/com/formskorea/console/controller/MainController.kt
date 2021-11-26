package com.formskorea.console.controller

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.service.ApplicationService
import com.formskorea.console.service.DefaultService
import com.formskorea.console.util.Etc
import com.formskorea.console.util.Token
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.servlet.view.RedirectView
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse


@Controller
@RequestMapping(value = ["/"])
class MainController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var defaultService: DefaultService

    @Autowired
    lateinit var applicationService: ApplicationService

    @RequestMapping(value = ["/ping"])
    @ResponseBody
    @Throws(Exception::class)
    fun ping() : Any {
        return defaultService.ping()
    }



    @RequestMapping(value = ["/"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun root(model: Model, response: HttpServletResponse, request: HttpServletRequest) : Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request.cookies)
        var isLogin = false

        if(token != "") {
            try {
                var userinfo = Token.get(token, DefaultConfig.TOKEN_EXPDAY)

                log.error(userinfo.toString())

                if (userinfo != null) {
                    userinfo = applicationService.info(userinfo)
                    log.error(userinfo.toString())
                    if(userinfo?.intStatus == DefaultConfig.MEMBER_OK) {
                        isLogin = true
                        model.addAttribute("fmcuser", userinfo)
                    }
                }
            } catch (e: Exception) {
                log.error(e.message)
            }
        }

        if(!isLogin) {
            return RedirectView("/login")
        }

        return "index"
    }

    @RequestMapping(value = ["/profile"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun profile(model: Model, response: HttpServletResponse, request: HttpServletRequest) : Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request.cookies)
        var isLogin = false

        if(token != "") {
            try {
                var userinfo = Token.get(token, DefaultConfig.TOKEN_EXPDAY)

                log.error(userinfo.toString())

                if (userinfo != null) {
                    userinfo = applicationService.info(userinfo)
                    log.error(userinfo.toString())
                    if(userinfo?.intStatus == DefaultConfig.MEMBER_OK) {
                        isLogin = true
                        model.addAttribute("fmcuser", userinfo)
                    }
                }
            } catch (e: Exception) {
                log.error(e.message)
            }
        }

        if(!isLogin) {
            return RedirectView("/login")
        }

        return "profile"
    }

    @RequestMapping(value = ["/login"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun login(model: Model, response: HttpServletResponse, request: HttpServletRequest) : Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request.cookies)
        var isLogin = false

        if(token != "") {
            try {
                var userinfo = Token.get(token, DefaultConfig.TOKEN_EXPDAY)

                log.error(userinfo.toString())

                if (userinfo != null) {
                    userinfo = applicationService.info(userinfo)
                    if(userinfo?.intStatus == DefaultConfig.MEMBER_OK) {
                        isLogin = true
                    }
                }
            } catch (e: Exception) {
                log.error(e.message)
            }
        }

        if(isLogin) {
            return RedirectView("/")
        }

        val scripts = ArrayList<String>()
        scripts.add("/js/login.js")

        model.addAttribute("scripts", scripts)

        return "login"
    }

    @RequestMapping(value = ["/joinok"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun joinok(model: Model, response: HttpServletResponse, request: HttpServletRequest) : Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request.cookies)
        var isLogin = false

        if(token != "") {
            try {
                var userinfo = Token.get(token, DefaultConfig.TOKEN_EXPDAY)

                log.error(userinfo.toString())

                if (userinfo != null) {
                    userinfo = applicationService.info(userinfo)
                    if(userinfo?.intStatus == DefaultConfig.MEMBER_OK) {
                        isLogin = true
                    }
                }
            } catch (e: Exception) {
                log.error(e.message)
            }
        }

        if(isLogin) {
            return RedirectView("/")
        }

        return "joinok"
    }

    @RequestMapping(value = ["/join"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun join(model: Model, response: HttpServletResponse, request: HttpServletRequest) : Any {
        val token = Etc.getCookie(DefaultConfig.TOKEN_ISSUER, request.cookies)
        var isLogin = false

        if(token != "") {
            try {
                var userinfo = Token.get(token, DefaultConfig.TOKEN_EXPDAY)

                log.error(userinfo.toString())

                if (userinfo != null) {
                    userinfo = applicationService.info(userinfo)
                    if(userinfo?.intStatus == DefaultConfig.MEMBER_OK) {
                        isLogin = true
                    }
                }
            } catch (e: Exception) {
                log.error(e.message)
            }
        }

        if(isLogin) {
            return RedirectView("/")
        }

        val scripts = ArrayList<String>()
        scripts.add("/js/join.js")
        scripts.add("//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js")

        model.addAttribute("scripts", scripts)

        return "join"
    }
}
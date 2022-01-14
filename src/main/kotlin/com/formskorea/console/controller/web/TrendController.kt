package com.formskorea.console.controller.web

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.service.ApplicationService
import com.formskorea.console.util.Etc
import com.formskorea.console.util.Token
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.view.RedirectView
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Controller
@RequestMapping(value = ["/trend"])
class TrendController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var applicationService: ApplicationService

    @RequestMapping(value = [""], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun list(model: Model, response: HttpServletResponse, request: HttpServletRequest): Any {
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
        scripts.add("/js/trend.js")
        model.addAttribute("scripts", scripts)

        val styles = ArrayList<String>()
        styles.add("/css/loading.css")
        model.addAttribute("styles", styles)

        return "trend"
    }

}
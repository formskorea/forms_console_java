package com.formskorea.console.controller

import com.formskorea.console.service.DefaultService
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.ResponseBody
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse


@Controller
@RequestMapping(value = ["/"])
class MainController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var defaultService: DefaultService

    @RequestMapping(value = ["/ping"])
    @ResponseBody
    @Throws(Exception::class)
    fun ping() : Any {
        return defaultService.ping()
    }

    @RequestMapping(value = ["/"], method = [RequestMethod.GET, RequestMethod.POST])
    @Throws(Exception::class)
    fun root(model: Model, response: HttpServletResponse, request: HttpServletRequest) : Any {

        val cookie = request.cookies

        return "index"
    }

}
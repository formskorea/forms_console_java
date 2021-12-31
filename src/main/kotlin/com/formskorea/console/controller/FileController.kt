package com.formskorea.console.controller

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping(value = ["/file"])
class FileController {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

}
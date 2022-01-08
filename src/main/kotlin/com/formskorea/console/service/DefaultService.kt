package com.formskorea.console.service

import com.formskorea.console.mapper.console.DefaultMapper
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class DefaultService {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var defaultMapper: DefaultMapper

    fun ping(): String {
        return defaultMapper.getPing()
    }

}
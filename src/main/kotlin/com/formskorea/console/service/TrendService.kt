package com.formskorea.console.service

import com.formskorea.console.data.model.Search
import com.formskorea.console.data.model.Trend
import com.formskorea.console.mapper.trend.TrendMapper
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class TrendService {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var trendMapper: TrendMapper

    fun getTrend(data: Search): ArrayList<Trend> {
        return trendMapper.getTrend(data)
    }
    fun getTrendCategory(data: Search): ArrayList<Trend> {
        return trendMapper.getTrendCategory(data)
    }

}
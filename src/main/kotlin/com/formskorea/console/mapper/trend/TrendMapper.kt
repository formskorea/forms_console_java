package com.formskorea.console.mapper.trend

import com.formskorea.console.data.model.Search
import com.formskorea.console.data.model.Trend

interface TrendMapper {
    fun getTrend(data: Search): ArrayList<Trend>
    fun getTrendCategory(data: Search): ArrayList<Trend>
}
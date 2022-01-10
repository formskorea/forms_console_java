package com.formskorea.console.mapper.log

import com.formskorea.console.data.model.*

interface WorkCountMapper {
    fun getWorkCount(data: Search): ArrayList<CountWork>
    fun getUserCount(data: Search): ArrayList<CountUsers>
}
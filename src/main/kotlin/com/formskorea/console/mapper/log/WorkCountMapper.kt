package com.formskorea.console.mapper.log

import com.formskorea.console.data.model.CountUsers
import com.formskorea.console.data.model.CountWork
import com.formskorea.console.data.model.Search

interface WorkCountMapper {
    fun getWorkCount(data: Search): ArrayList<CountWork>
    fun getUserCount(data: Search): ArrayList<CountUsers>
}
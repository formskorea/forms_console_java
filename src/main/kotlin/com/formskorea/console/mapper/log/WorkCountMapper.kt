package com.formskorea.console.mapper.log

import com.formskorea.console.data.model.*

interface WorkCountMapper {
    fun getWorkCount(data: Search): ArrayList<CountWork>
    fun getUserCount(data: Search): ArrayList<CountUsers>
    fun setWorkCount(data: CountWork) : Boolean
    fun setUserCount(data: CountUsers) : Boolean
    fun setHistory(data: History) : Boolean
    fun getHistory(data: History) : ArrayList<History>
    fun createWorkLog(data: Work) : Boolean
    fun createWorkIdx(data: Work) : Boolean
    fun createWorkIdx2(data: Work) : Boolean
    fun setWorkLog(data: WorkLog) : Boolean
    fun editWorkLog(data: WorkLog) : Boolean
}
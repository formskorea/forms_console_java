package com.formskorea.console.mapper.console

import com.formskorea.console.data.model.*

interface AdminMapper {
    fun getMInfluncerInfo(data: Search): ArrayList<User>?
    fun getMInfluncerCount(data: Search): Int?
    fun getMClientInfo(data: Search): ArrayList<User>?
    fun getMClientCount(data: Search): Int?
    fun getMAdminInfo(data: Search): ArrayList<User>?
    fun getMAdminCount(data: Search): Int?
    fun setMWork(data: Work) : Boolean?
    fun editMWork(data: Work) : Boolean?
    fun delMWork(data: Work) : Boolean?
    fun getMWork(data: Search): ArrayList<Work>?
    fun getMWorkCount(data: Search): Int?
    fun getDHWorkCount(data: Search): Int?
    fun setMWorkInfo(data: WorkInfo) : Boolean?
    fun editMWorkInfo(data: WorkInfo) : Boolean?
    fun delMWorkInfo(data: WorkInfo) : Boolean?
    fun getMWorkInfo(data: WorkInfo) : ArrayList<WorkInfo>?
    fun getMCompany(data: Search) : ArrayList<Company>?
    fun getMCompanyCount(data:Search) : Int?
    fun cutWork() : Int?
}
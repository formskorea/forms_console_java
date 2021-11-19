package com.formskorea.console.mapper.dao

import com.formskorea.console.data.model.Company
import com.formskorea.console.data.model.User

interface ApplicationMapper {
    fun getInflucerInfo(data : User) : User?
    fun getClientInfo(data : User) : User?
    fun getAdminInfo(data : User) : User?
    fun getCompany(data: User) : Company?
}
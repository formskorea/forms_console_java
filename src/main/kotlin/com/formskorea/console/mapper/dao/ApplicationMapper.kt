package com.formskorea.console.mapper.dao

import com.formskorea.console.data.model.Company
import com.formskorea.console.data.model.Media
import com.formskorea.console.data.model.User

interface ApplicationMapper {
    fun getInfluncerInfo(data : User) : User?
    fun getClientInfo(data : User) : User?
    fun getAdminInfo(data : User) : User?
    fun setInfluncer(data: User) : Boolean?
    fun setClient(data: User) : Boolean?
    fun setAdmin(data: User) : Boolean?
    fun getCompany(data: Company) : Company?
    fun setCompany(data: Company) : Boolean?
    fun setMedia(data: Media) : Boolean?
}
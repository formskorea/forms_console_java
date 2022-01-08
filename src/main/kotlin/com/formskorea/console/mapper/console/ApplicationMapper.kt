package com.formskorea.console.mapper.console

import com.formskorea.console.data.model.*

interface ApplicationMapper {
    fun getInfluncerInfo(data: User): User?
    fun getClientInfo(data: User): User?
    fun getAdminInfo(data: User): User?
    fun setInfluncer(data: User): Boolean?
    fun setClient(data: User): Boolean?
    fun setAdmin(data: User): Boolean?
    fun editInfluncer(data: User): Boolean?
    fun editClient(data: User): Boolean?
    fun editAdmin(data: User): Boolean?
    fun getCompany(data: Company): Company?
    fun setCompany(data: Company): Boolean?
    fun editCompany(data: Company): Boolean?
    fun setMedia(data: Media): Boolean?
    fun getMedia(data: Media): ArrayList<Media>?
    fun delMedia(data: Media): Boolean?
    fun editMedia(data: Media): Boolean?
    fun setTag(data: Tag): Boolean?
    fun delTag(data: Tag): Boolean?
    fun getTag(data: Tag): ArrayList<Tag>?
    fun getTags(data: Tag): ArrayList<Tag>?
    fun setTagLink(data: Tag): Boolean?
    fun delTagLink(data: Tag): Boolean?
    fun setCash(data: Cash): Boolean?
    fun delCash(data: Cash): Boolean?
    fun getCash(data: Cash): ArrayList<Cash>?
}
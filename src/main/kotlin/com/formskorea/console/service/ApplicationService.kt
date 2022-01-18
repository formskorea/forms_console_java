package com.formskorea.console.service

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.*
import com.formskorea.console.mapper.console.AdminMapper
import com.formskorea.console.mapper.console.ApplicationMapper
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class ApplicationService {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var applicationMapper: ApplicationMapper

    @Autowired
    lateinit var adminMapper: AdminMapper

    fun userinfo(data: User): User? {
        return when (data.strMemberType) {
            DefaultConfig.MEMBER_ADMIN -> {
                applicationMapper.getAdminInfo(data)
            }
            DefaultConfig.MEMBER_CLIENT -> {
                applicationMapper.getClientInfo(data)
            }
            else -> {
                applicationMapper.getInfluncerInfo(data)
            }
        }
    }


    fun info(data: User): User? {
        val media = Media()
        val info = userinfo(data)

        if (info?.strNikname.isNullOrEmpty()) {
            info?.strNikname = info?.strName
        }

        if (info?.intCompanySeq != null) {
            val company = Company()
            company.intSeq = info?.intCompanySeq
            info.company = applicationMapper.getCompany(company)
        }

        //media
        media.intUserSeq = info?.intSeq
        info?.media = applicationMapper.getMedia(media)

        //tags
        val tag = Tag()
        tag.intUserSeq = info?.intSeq
        tag.intUserType = media.intUserType
        tag.intType = 1
        info?.tags = applicationMapper.getTags(tag)

        //cash
        val cash = Cash()
        cash.intUserType =info?.intSeq
        cash.intUserType = media.intUserType
        info?.cashs = applicationMapper.getCash(cash)

        return info
    }

    fun setUser(data: User): Boolean? {
        return when (data.strMemberType) {
            DefaultConfig.MEMBER_ADMIN -> {
                applicationMapper.setAdmin(data)
            }
            DefaultConfig.MEMBER_CLIENT -> {
                applicationMapper.setClient(data)
            }
            else -> {
                applicationMapper.setInfluncer(data)
            }
        }
    }

    fun editUser(data: User): Boolean? {
        //media
        val defMedia = Media()
        defMedia.intUserType = when(data.strMemberType) {
            DefaultConfig.MEMBER_CLIENT -> 1
            DefaultConfig.MEMBER_INFLUENCER -> 2
            else -> 9
        }
        defMedia.intUserSeq = data.intSeq
        applicationMapper.delMedia(defMedia)

        if(!data.media.isNullOrEmpty()) {
            for (field in data.media!!) {
                field.intUserSeq = data.intSeq
                field.intUserType = defMedia.intUserType
                applicationMapper.setMedia(field)
            }
        }

        //tag
        val defTag = Tag()
        defTag.intUserSeq = data.intSeq
        defTag.intUserType = defMedia.intUserType
        defTag.intType = 1
        applicationMapper.delTagLink(defTag)

        if(!data.tags.isNullOrEmpty()) {
            for (field in data.tags!!) {
                field.intUserSeq = data.intSeq
                field.intUserType = defMedia.intUserType
                val result = applicationMapper.getTag(field)
                if(result.isNullOrEmpty()) { //tag reg
                    applicationMapper.setTag(field)
                    field.intTagSeq = field.intSeq
                } else {
                    field.intTagSeq = result[0].intSeq
                }
                applicationMapper.setTagLink(field)
            }
        }

        //cash
        val defCash = Cash()
        defCash.intUserSeq = data.intSeq
        defCash.intUserType = defMedia.intUserType
        applicationMapper.delCash(defCash)

        if(!data.cashs.isNullOrEmpty()) {
            for (field in data.cashs!!) {
                field.intUserSeq = data.intSeq
                field.intUserType = defMedia.intUserType
                applicationMapper.setCash(field)
            }
        }

        //company
        if (data.company != null && !data.company?.strCompanyname.isNullOrEmpty()) {
            if(data.intCompanySeq != null && data.intCompanySeq!! > 0) {
                data.company!!.strAddress += "|" + data.company!!.strAddress2
                data.company!!.intStatus = 1
                applicationMapper.editCompany(data.company!!)
            } else {
                val ccresult = applicationMapper.getCompany(data.company!!)
                if (ccresult == null) {
                    data.company!!.strAddress += "|" + data.company!!.strAddress2
                    data.company!!.intStatus = 1
                    val cresult = applicationMapper.setCompany(data.company!!)
                    if (cresult != null && cresult == true) {
                        data.intCompanySeq = data.company?.intSeq
                    }
                } else {
                    data.intCompanySeq = ccresult.intSeq
                }
            }
        } else {
            data.intCompanySeq = -1
        }

        return when (data.strMemberType) {
            DefaultConfig.MEMBER_ADMIN -> {
                applicationMapper.editAdmin(data)
            }
            DefaultConfig.MEMBER_CLIENT -> {
                applicationMapper.editClient(data)
            }
            else -> {
                applicationMapper.editInfluncer(data)
            }
        }
    }

    fun setCompany(data: Company): Boolean? {
        return applicationMapper.setCompany(data)
    }

    fun editCompany(data: Company): Boolean? {
        return applicationMapper.editCompany(data)
    }

    fun getCompany(data: Company): Company? {
        return applicationMapper.getCompany(data)
    }

    fun setMedia(data: Media): Boolean? {
        return applicationMapper.setMedia(data)
    }

    fun delMedia(data: Media): Boolean? {
        return applicationMapper.delMedia(data)
    }

    fun getMedia(data: Media) : ArrayList<Media>? {
        return applicationMapper.getMedia(data)
    }

    fun editMedia(data: Media): Boolean? {
        return applicationMapper.editMedia(data)
    }

    fun editPass(data: User) : Boolean? {
        return when (data.strMemberType) {
            DefaultConfig.MEMBER_ADMIN -> {
                applicationMapper.editAdmin(data)
            }
            DefaultConfig.MEMBER_CLIENT -> {
                applicationMapper.editClient(data)
            }
            else -> {
                applicationMapper.editInfluncer(data)
            }
        }
    }

    fun setTag(data: Tag): Boolean? {
        var rtnValue = true
        try {
            val result = applicationMapper.getTags(data)
            if (result.isNullOrEmpty()) {
                if (applicationMapper.setTag(data) == true) {
                    val taglink = Tag()
                    taglink.intTagSeq = data.intSeq
                    taglink.intUserType = data.intUserType
                    taglink.intUserSeq = data.intUserSeq
                    applicationMapper.setTagLink(taglink)
                }
            } else {
                data.intSeq = result[0].intSeq
            }
        } catch (e: Exception) {
            return false
        }
        return rtnValue
    }

    fun delTag(data: Tag): Boolean? {
        var rtnValue = true
        try {
            val result = applicationMapper.getTags(data)
            if (result.isNullOrEmpty()) {
                if(applicationMapper.delTag(data) == true) {
                    val taglink = Tag()
                    taglink.intTagSeq = data.intSeq
                    taglink.intUserType = data.intUserType
                    taglink.intUserSeq = data.intUserSeq

                    applicationMapper.delTagLink(taglink)
                }
            }
        } catch (e: Exception) {
            return false
        }
        return rtnValue
    }

    fun getTags(data: Tag): ArrayList<Tag>? {
        return applicationMapper.getTags(data)
    }

}
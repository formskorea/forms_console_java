package com.formskorea.console.service

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.Company
import com.formskorea.console.data.model.Media
import com.formskorea.console.data.model.User
import com.formskorea.console.mapper.dao.ApplicationMapper
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class ApplicationService {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var applicationMapper: ApplicationMapper

    fun info(data : User) : User? {
        val media = Media()
        val info = when(data.strMemberType) {
            DefaultConfig.MEMBER_ADMIN -> {
                media.intUserType = 9
                applicationMapper.getAdminInfo(data)
            }
            DefaultConfig.MEMBER_CLIENT -> {
                media.intUserType = 1
                applicationMapper.getClientInfo(data)
            }
            else -> {
                media.intUserType = 2
                applicationMapper.getInfluncerInfo(data)
            }
        }

        if(info?.strNikname.isNullOrEmpty()) {
            info?.strNikname = info?.strName
        }

        if(info?.intCompanySeq != null) {
            val company = Company()
            company.intSeq = info?.intCompanySeq
            info.company = applicationMapper.getCompany(company)
            info.intCompanySeq = null
        }

        media.intUserSeq = info?.intSeq
        info?.media = applicationMapper.getMedia(media)

        return info
    }

    fun setUser(data: User) : Boolean? {
        return when(data.strMemberType) {
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

    fun editUser(data: User) : Boolean? {
        return when(data.strMemberType) {
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

    fun setCompany (data: Company) : Boolean? {
        return applicationMapper.setCompany(data)
    }

    fun getCompany (data: Company) : Company? {
        return applicationMapper.getCompany(data)
    }

    fun setMedia(data: Media) : Boolean? {
        return applicationMapper.setMedia(data)
    }

}
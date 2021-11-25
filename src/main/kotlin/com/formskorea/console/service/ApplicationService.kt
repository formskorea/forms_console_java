package com.formskorea.console.service

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.Company
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
        val info = when(data.strMemberType) {
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

        if(info?.strNikname.isNullOrEmpty()) {
            info?.strNikname = info?.strName
        }

        if(info?.intCompanySeq != null) {
            val company = Company()
            company.intSeq = info?.intCompanySeq
            info.company = applicationMapper.getCompany(company)
            info.intCompanySeq = null
        }

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

    fun setCompany (data: Company) : Boolean? {
        return applicationMapper.setCompany(data)
    }

    fun getCompany (data: Company) : Company? {
        return applicationMapper.getCompany(data)
    }

}
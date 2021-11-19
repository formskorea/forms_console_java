package com.formskorea.console.service

import com.formskorea.console.config.DefaultConfig
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
                applicationMapper.getInflucerInfo(data)
            }
        }

        if(info?.intCompanySeq != null) {
            info.company = applicationMapper.getCompany(data)
            info.intCompanySeq = null
        }

        return info
    }

}
package com.formskorea.console.service

import com.formskorea.console.data.model.*
import com.formskorea.console.mapper.console.AdminMapper
import com.formskorea.console.mapper.console.ApplicationMapper
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class AdminService {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var applicationMapper: ApplicationMapper

    @Autowired
    lateinit var adminMapper: AdminMapper


    fun getMInfluncerInfo(data: Search): ArrayList<User>? {
        return adminMapper.getMInfluncerInfo(data)
    }

    fun getMInfluncerCount(data: Search): Int? {
        return adminMapper.getMInfluncerCount(data)
    }

    fun getMClientInfo(data: Search): ArrayList<User>? {
        return adminMapper.getMClientInfo(data)
    }

    fun getMClientCount(data: Search): Int? {
        return adminMapper.getMClientCount(data)
    }

    fun getMAdminInfo(data: Search): ArrayList<User>? {
        return adminMapper.getMAdminInfo(data)
    }

    fun getMAdminCount(data: Search): Int? {
        return adminMapper.getMAdminCount(data)
    }

    fun setMWork(data: Work): Boolean? {
        try {
            adminMapper.setMWork(data)

            //work info
            val workInfo = WorkInfo()
            workInfo.intWorkSeq = data.intSeq
            workInfo.intStatus = 9

            adminMapper.editMWorkInfo(workInfo)

            if (!data.infos.isNullOrEmpty()) {
                for(field in data.infos!!) {
                    field.intWorkSeq = data.intSeq
                    field.intClientSeq = data.intClientSeq
                    adminMapper.setMWorkInfo(field)
                }
            }

            //tag
            val defTag = Tag()
            defTag.intUserSeq = data.intClientSeq
            defTag.intUserType = 1
            defTag.intType = 5
            applicationMapper.delTagLink(defTag)

            if (!data.tags.isNullOrEmpty()) {
                for (field in data.tags!!) {
                    field.intUserSeq = data.intClientSeq
                    field.intUserType = 1
                    defTag.intType = 5
                    field.intWorkSeq = data.intSeq

                    val result = applicationMapper.getTag(field)
                    if (result.isNullOrEmpty()) { //tag reg
                        applicationMapper.setTag(field)
                        field.intTagSeq = field.intSeq
                    } else {
                        field.intTagSeq = result[0].intSeq
                    }
                    applicationMapper.setTagLink(field)
                }
            }

            return true
        } catch (e: Exception) {
            log.error(e.message)
            return false
        }
    }

    fun getMWork(data: Search): ArrayList<Work>? {
        return adminMapper.getMWork(data)
    }

    fun getMWorkCount(data: Search): Int? {
        return adminMapper.getMWorkCount(data)
    }

    fun getMWorkInfo(data: WorkInfo): ArrayList<WorkInfo>? {
        return adminMapper.getMWorkInfo(data)
    }
}
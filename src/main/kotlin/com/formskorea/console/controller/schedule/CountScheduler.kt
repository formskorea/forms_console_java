package com.formskorea.console.controller.schedule

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.History
import com.formskorea.console.service.CountService
import com.formskorea.console.util.Etc
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import java.util.*

@Component
class CountScheduler {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var countService: CountService

    @Scheduled(cron = "0 59 23 * * *")
    fun countScheduler() {
        val history = History()

        history.intAdminSeq = 0
        history.intClientSeq = 0
        history.intInfluencerSeq = 0
        history.intWorkSeq = 0
        history.intCode = DefaultConfig.HISTORY_CODE_SYSTEM

        try {
            val workCount = countService.getCountWorkNow()
            val userCount = countService.getCountUsersNow()

            countService.setCountWork(workCount)
            countService.setUserWork(userCount)

            history.txtMemo = "협업 "+ Etc.setDatetoString(Date(), "yyyy-MM-dd") +"일자 카운트 등록\n" +
                    "사용자 "+ Etc.setDatetoString(Date(), "yyyy-MM-dd") +"일자 카운트 등록"

            countService.setHistory(history)
        } catch (e: Exception) {
            history.txtMemo = "SYSTEM ERROR :\n\n ${e.message}"

            countService.setHistory(history)
        }

    }
}
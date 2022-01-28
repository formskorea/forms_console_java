package com.formskorea.console.controller.schedule

import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.History
import com.formskorea.console.service.AdminService
import com.formskorea.console.service.CountService
import com.formskorea.console.util.Etc
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import java.util.*

@Component
class WorkScheduler {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    @Autowired
    lateinit var adminService: AdminService

    @Autowired
    lateinit var countService: CountService

    @Scheduled(cron = "0 10 0 * * *")
    fun cutWork() {
        val history = History()

        history.intAdminSeq = 0
        history.intClientSeq = 0
        history.intInfluencerSeq = 0
        history.intWorkSeq = 0
        history.intCode = DefaultConfig.HISTORY_CODE_SYSTEM

        try {
            val count = adminService.cutWork()
            history.txtMemo = "협업 ${count}건이 자동종료 되었습니다."
            countService.setHistory(history)
        } catch (e: Exception) {
            history.txtMemo = "SYSTEM ERROR :\n\n ${e.message}"
            countService.setHistory(history)
        }
    }

}
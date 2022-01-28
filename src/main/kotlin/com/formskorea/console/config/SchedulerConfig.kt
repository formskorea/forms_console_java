package com.formskorea.console.config

import org.springframework.context.annotation.Configuration
import org.springframework.scheduling.annotation.EnableAsync
import org.springframework.scheduling.annotation.EnableScheduling
import org.springframework.scheduling.annotation.SchedulingConfigurer
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler
import org.springframework.scheduling.config.ScheduledTaskRegistrar


@Configuration
@EnableScheduling
@EnableAsync
class SchedulerConfig : SchedulingConfigurer {
    private val POOL_SIZE = 2
    private val THREAD_NAME_PREFIX = "forms-scheduler-"
    override fun configureTasks(scheduledTaskRegistrar: ScheduledTaskRegistrar) {
        val threadPoolTaskScheduler = ThreadPoolTaskScheduler()
        threadPoolTaskScheduler.poolSize = POOL_SIZE
        threadPoolTaskScheduler.setThreadNamePrefix(THREAD_NAME_PREFIX)
        threadPoolTaskScheduler.initialize()
        scheduledTaskRegistrar.setTaskScheduler(threadPoolTaskScheduler)
    }
}
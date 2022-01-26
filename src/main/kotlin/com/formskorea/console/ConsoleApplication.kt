package com.formskorea.console

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.scheduling.annotation.EnableScheduling

@SpringBootApplication
@EnableScheduling
class ConsoleApplication

fun main(args: Array<String>) {
    runApplication<ConsoleApplication>(*args)
}

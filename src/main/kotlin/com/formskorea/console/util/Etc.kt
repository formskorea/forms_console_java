package com.formskorea.console.util

import com.formskorea.console.config.DefaultConfig
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.text.NumberFormat
import java.text.SimpleDateFormat
import java.util.*
import java.util.regex.Pattern
import javax.servlet.http.Cookie
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

object Etc {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    fun setComma(value: Int): String {
        val nf = NumberFormat.getInstance()
        return nf.format(value)
    }

    fun setStringtoDate(value: String, ext: String = "yyyy-MM-dd HH:mm:ss"): Date {
        val sf = SimpleDateFormat(ext)
        return sf.parse(value)
    }

    fun setDatetoString(value: Date, ext: String = "yyyy-MM-dd HH:mm:ss"): String {
        val sf = SimpleDateFormat(ext)
        return sf.format(value)
    }

    fun randomRange(n1: Int, n2: Int): Int {
        return (Math.random() * (n2 - n1 + 1)).toInt() + n1
    }

    fun setDateAdd(type: Int, add: Int, defdate: Date = Date()): Date {
        val cal = Calendar.getInstance()
        cal.time = defdate
        cal.add(type, add)
        return Date(cal.timeInMillis)
    }

    fun checkValid(data: String, regex: String): Boolean {
        return Pattern.compile(regex).matcher(data).matches()
    }

    fun checkEMail(data: String): Boolean {
        val regex = "^([0-9a-zA-Z_.-]+)@([0-9a-zA-Z_-]+)(.[0-9a-zA-Z_-]+){1,2}$"
        return checkValid(data, regex)
    }

    fun checkMobile(data: String): Boolean {
        val regex = "\\d{3}-\\d{3,4}-\\d{4}"
        return checkValid(data, regex)
    }

    fun checkTelnum(data: String): Boolean {
        val regex = "\\d{2,3}-\\d{3,4}-\\d{4}"
        return checkValid(data, regex)
    }

    fun checkPassword(data: String): Boolean {
        val regex = "^.*(?=^.{8,30}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"
        return checkValid(data, regex)
    }

    fun checkHangle(data: String): Boolean {
        val regex = "^[가-힣]*$"
        return checkValid(data, regex)
    }

    fun checkEnglish(data: String): Boolean {
        val regex = "^[a-zA-Z]*$"
        return checkValid(data, regex)
    }

    fun checkNumber(data: String): Boolean {
        val regex = "^[0-9]*$"
        return checkValid(data, regex)
    }

    fun getCookie(key: String, request: HttpServletRequest): String {
        if (request.cookies != null) {
            for (field in request.cookies) {
                if (field.name == key) {
                    return field.value
                }
            }
        }
        return ""
    }

    fun setCookie(key: String, value: String?, response: HttpServletResponse, day: Int? = -1) {
        val cookie = Cookie(key, value)
        if (day != null && day > 0) {
            cookie.maxAge = day * 24 * 60 * 60
        }
        cookie.path = "/"
        response.addCookie(cookie)
    }

    fun random(start: Int, end: Int): Int {
        return (start until end).random()
    }

    fun setTelnum(value: String): String {
        var rtnvalue = value.replace("-", "")

        log.error("rtnvalue : " + rtnvalue + " :: ${rtnvalue.length}")

        rtnvalue = when (rtnvalue.length) {
            7 -> rtnvalue.substring(0, 3) + "-" + rtnvalue.substring(3, 7)
            8 -> rtnvalue.substring(0, 4) + "-" + rtnvalue.substring(4, 8)
            9 -> rtnvalue.substring(0, 2) + "-" + rtnvalue.substring(2, 5) + "-" + rtnvalue.substring(5, 9)
            10 -> if (rtnvalue.take(2) == "02") {
                rtnvalue.substring(0, 2) + "-" + rtnvalue.substring(2, 6) + "-" + rtnvalue.substring(6, 10)
            } else {
                rtnvalue.substring(0, 3) + "-" + rtnvalue.substring(3, 6) + "-" + rtnvalue.substring(6, 10)
            }
            11 -> rtnvalue.substring(0, 3) + "-" + rtnvalue.substring(3, 7) + "-" + rtnvalue.substring(7, 11)
            else -> value
        }

        return rtnvalue
    }
}
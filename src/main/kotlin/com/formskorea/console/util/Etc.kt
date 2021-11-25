package com.formskorea.console.util

import com.formskorea.console.config.DefaultConfig
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.text.NumberFormat
import java.text.SimpleDateFormat
import java.util.*
import java.util.regex.Pattern
import javax.servlet.http.Cookie

object Etc {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    fun setComma(value: Int) : String {
        val nf = NumberFormat.getInstance()
        return nf.format(value)
    }

    fun setStringtoDate(value: String, ext : String = "yyyy-MM-dd HH:mm:ss") : Date {
        val sf = SimpleDateFormat(ext)
        return sf.parse(value)
    }

    fun setDatetoString(value: Date, ext : String = "yyyy-MM-dd HH:mm:ss") : String {
        val sf = SimpleDateFormat(ext)
        return sf.format(value)
    }

    fun randomRange(n1: Int, n2: Int): Int {
        return (Math.random() * (n2 - n1 + 1)).toInt() + n1
    }

    fun setDateAdd(type: Int, add: Int, defdate: Date = Date()) : Date {
        val cal = Calendar.getInstance()
        cal.time = defdate
        cal.add(type, add)
        return Date(cal.timeInMillis)
    }

    fun checkValid(data: String, regex: String) : Boolean {
        return Pattern.compile(regex).matcher(data).matches()
    }

    fun checkEMail(data: String) : Boolean {
        val regex = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$"
        return checkValid(data, regex)
    }

    fun checkMobile(data: String) : Boolean {
        val regex = "\\d{3}-\\d{3,4}-\\d{4}"
        return checkValid(data, regex)
    }

    fun checkTelnum(data: String) : Boolean {
        val regex = "\\d{2,3}-\\d{3,4}-\\d{4}"
        return checkValid(data, regex)
    }

    fun checkPassword(data: String) : Boolean {
        val regex = "^.*(?=^.{8,30}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"
        return checkValid(data, regex)
    }

    fun checkHangle(data: String) : Boolean {
        val regex = "^[가-힣]*$"
        return checkValid(data, regex)
    }

    fun checkEnglish(data: String) : Boolean {
        val regex = "^[a-zA-Z]*$"
        return checkValid(data, regex)
    }

    fun checkNumber(data: String) : Boolean {
        val regex = "^[0-9]*$"
        return checkValid(data, regex)
    }

    fun getCookie(key: String, cookie: Array<Cookie>?) : String {
        if(cookie != null) {
            for (field in cookie) {
                if (field.name == key) {
                    return field.value
                }
            }
        }
        return ""
    }
}
package com.formskorea.console.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.mail.SimpleMailMessage
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.stereotype.Service

@Service
class MailService {

    @Autowired
    lateinit var javaMailSender: JavaMailSender

    fun sendMail(title: String, contents: String, toMailList: ArrayList<String>) {
        val simpleMailMessage = SimpleMailMessage()
        var tomail = ""
        for(field in toMailList) {
            tomail += if(tomail.isNotEmpty()) { "," } else { "" } + field
        }

        simpleMailMessage.setTo(tomail)
        simpleMailMessage.setSubject(title)
        simpleMailMessage.setText(contents)

        javaMailSender.send(simpleMailMessage)
    }

    fun sendMail(title: String, contents: String, toMail: String) {
        val array = ArrayList<String>()
        array.add(toMail)
        sendMail(title, contents, array)
    }

}
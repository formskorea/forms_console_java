package com.formskorea.console.util

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import com.formskorea.console.config.DefaultConfig
import com.formskorea.console.data.model.User
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import java.time.LocalDateTime
import java.time.ZoneOffset
import java.util.*

object Token {
    var log = LoggerFactory.getLogger(this::class.java) as Logger

    private val DAY = 3600L * 24

    fun make(member: User): String {
        return try {
            JWT.create()
                .withIssuer(DefaultConfig.TOKEN_ISSUER)
                .withClaim("email", member.strEmail)
                .withClaim("type", member.strMemberType)
                .withClaim("name", member.strName)
                .withClaim("nik", member.strNikname)
                .withClaim("rand", Date().time + Etc.randomRange(111, 999))
                .withExpiresAt(Date.from(LocalDateTime.now().toInstant(ZoneOffset.ofHours(9))))
                .sign(Algorithm.HMAC256(DefaultConfig.TOKEN_KEY))
        } catch (e: Exception) {
            ""
        }
    }

    fun get(value: String, day: Int = 30): User? {
        try {
            val member = User()

            val verifier = JWT.require(Algorithm.HMAC256(DefaultConfig.TOKEN_KEY))
                .withIssuer(DefaultConfig.TOKEN_ISSUER)
                .acceptExpiresAt(DAY * day) // 만료일 -{day}일
                .build()

            val jwt = verifier.verify(value)
            member.strEmail = jwt.getClaim("email").asString()
            member.strName = jwt.getClaim("name").asString()
            member.strMemberType = jwt.getClaim("type").asString()
            member.strNikname = jwt.getClaim("nik").asString()

            return member
        } catch (e: Exception) {
            return null
        }
    }
}
package com.formskorea.console.config

object DefaultConfig {
    const val TOKEN_NAME = "fmc-tkn"
    const val TOKEN_EXPDAY = 30

    const val SERVER_SUCCESS = 200
    const val SERVER_PARAMERROR = 300
    const val SERVER_NOTFOUND = 400
    const val SERVER_APIERROR = 500
    const val SERVER_NOTUSER = 600
    const val SERVER_LOGOUT = 699
    const val SERVER_DBERROR = 800
    const val SERVER_NULL = 900

    const val ERROR_PARAM = "param error"
    const val ERROR_NOTFOUND = "not found"
    const val ERROR_APIERROR = "api error"
    const val ERROR_NOTUSER = "not user"
    const val ERROR_LOGOUT = "logout"
    const val ERROR_DBERROR = "database error"
    const val ERROR_NULL = "null"

    const val MESSAGE_OK = "정상"
    const val MESSAGE_INFONULL = "로그인 정보를 찾을 수 없습니다."
    const val MESSAGE_MEMBERTYPE = "회원구분 정보가 없습니다."
    const val MESSAGE_EMPTY_EMAIL = "이메일 정보가 없습니다."
    const val MESSAGE_CHECK_EMAIL = "이메일 형식이 맞지 않습니다."
    const val MESSAGE_NOTUSER = "사용금지된 회원입니다."
    const val MESSAGE_REJECT = "탈퇴한 회원입니다."
    const val MESSAGE_EMPTY_PASSWORD = "비밀번호가 없습니다."
    const val MESSAGE_PASSNOTMATCH = "비밀번호가 일치하지 않습니다."
    const val MESSAGE_REJOIN = "이미 가입된 회원입니다."
    const val MESSAGE_TOKENOUT = "토큰이 만료되었습니다."
    const val MESSAGE_NULL = "값이 없습니다."
    const val MESSAGE_NOFILE = "파일이 없습니다."
    const val MESSAGE_NOIMAGEFILE = "이미지파일이 아닙니다."

    const val MESSAGE_DBERROR = "일시적인 장애가 발생되었습니다.\n잠시후 다시 시도해 주세요."

    const val MEMBER_INFLUENCER = "influencer"
    const val MEMBER_CLIENT = "client"
    const val MEMBER_ADMIN = "admin"

    const val TOKEN_ISSUER = "fmc-user"
    const val TOKEN_KEY = "ghkanfaostptustlzmflt"

    const val MEMBER_OK = 1
    const val MEMBER_REJECT = 5
    const val MEMBER_CUT = 9

}
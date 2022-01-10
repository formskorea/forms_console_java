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
    const val ERROR_PROCESS = "server error"

    const val MESSAGE_OK = "정상처리 되었습니다."
    const val MESSAGE_INFONULL = "로그인 정보를 찾을 수 없습니다."
    const val MESSAGE_MEMBERTYPE = "회원구분 정보가 없습니다."
    const val MESSAGE_EMPTY_NAME = "성명 정보가 없습니다."
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
    const val MESSAGE_PROCESS = "처리중 오류가 발생했습니다."

    const val MESSAGE_WORK_TITLE = "협업명을 입력해주세요."
    const val MESSAGE_WORK_READYDAY = "모집기간을 선택하여 주세요."
    const val MESSAGE_WORK_DAY = "진행기간을 선택하여 주세요."
    const val MESSAGE_WORK_NOTAG = "키워드를 입력해 주세요."
    const val MESSAGE_WORK_INFO = "협업내용을 입력해 주세요."
    const val MESSAGE_WORK_NOCOUNT = "인플루언서가 선택되지 않았습니다."

    const val MESSAGE_DBERROR = "일시적인 장애가 발생되었습니다.\n잠시후 다시 시도해 주세요."

    const val MEMBER_INFLUENCER = "influencer"
    const val MEMBER_CLIENT = "client"
    const val MEMBER_ADMIN = "admin"

    const val TOKEN_ISSUER = "fmc-user"
    const val TOKEN_KEY = "ghkanfaostptustlzmflt"

    const val MEMBER_OK = 1
    const val MEMBER_JOIN = 0
    const val MEMBER_REJECT = 5
    const val MEMBER_CUT = 9

    const val MAIL_SEND_PASSWORD_TITLE = "Meta Console 임시 접속 비밀번호를 전달드립니다."
    const val MAIL_SEND_PASSWORD_INFO = "안녕하세요. Meta Console 입니다." +
            "\n회원찾기에 성공하여, 임시 비밀번호를 전달드립니다." +
            "\n임시 비밀번호는 아래와 같습니다." +
            "\n \n \n ==================================" +
            "\n       비밀번호 : {new_password}" +
            "\n ==================================" +
            "\n \n * 본메일은 발송전용 메일입니다."

    const val PERM_SUPER = "super"
    const val PERM_MAIN_READ = "mread"
    const val PERM_INFLUENCER_READ = "iread"
    const val PERM_INFLUENCER_ADD = "iadd"
    const val PERM_INFLUENCER_EDIT = "iedit"
    const val PERM_INFLUENCER_DEL = "idel"
    const val PERM_CLIENT_READ = "cread"
    const val PERM_CLIENT_ADD = "cadd"
    const val PERM_CLIENT_EDIT = "cedit"
    const val PERM_CLIENT_DEL = "cdel"
    const val PERM_WORK_READ = "wread"
    const val PERM_WORK_ADD = "wadd"
    const val PERM_WORK_EDIT = "wedit"
    const val PERM_WORK_DEL = "wdel"

}
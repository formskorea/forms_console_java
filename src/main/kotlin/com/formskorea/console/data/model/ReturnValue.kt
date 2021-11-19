package com.formskorea.console.data.model

import com.formskorea.console.config.DefaultConfig

data class ReturnValue(
    var status: Int = DefaultConfig.SERVER_SUCCESS,
    var error : String = "",
    var message : String = DefaultConfig.MESSAGE_OK,
    var result: Any? = null
)

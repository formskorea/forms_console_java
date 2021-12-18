package com.formskorea.console.data.model

data class Search(
    var keyword: String?,
    var start: Int?,
    var end: Int?,
    var limit : Int?,
    var length: Int?,
    var status: Int?
)

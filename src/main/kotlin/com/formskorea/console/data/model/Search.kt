package com.formskorea.console.data.model

data class Search(
    var keyword: String? = null,
    var start: Int? = null,
    var end: Int? = null,
    var limit : Int? = null,
    var length: Int? = null,
    var status: Int? = null,
    var page: Int? = null,
    var media1: Int? = null,
    var media2: Int? = null,
    var media3: Int? = null,
    var seq: Int? = null
)

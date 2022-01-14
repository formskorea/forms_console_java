package com.formskorea.console.data.model

data class Search(
    var keyword: String? = null,
    var start: String? = null,
    var end: String? = null,
    var limit : Int? = null,
    var length: Int? = null,
    var status: Int? = null,
    var page: Int? = null,
    var media1: Int? = null,
    var media2: Int? = null,
    var media3: Int? = null,
    var seq: Int? = null,
    var date: String? = null,
    var mtype: Int? = null,
    var itype: Int? = null,
    var stype: String? = null,
    var sex: Int? = null,
    var age: String? = null
)

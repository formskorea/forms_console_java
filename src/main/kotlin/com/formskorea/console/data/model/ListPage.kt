package com.formskorea.console.data.model

data class ListPage<T>(
    var list: ArrayList<T>? = null,
    var max_page: Int? = 1,
    var total: Int? = 0
)
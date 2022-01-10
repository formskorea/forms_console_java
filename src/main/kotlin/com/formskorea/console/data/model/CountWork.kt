package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class CountWork(
    @SerializedName("seq") var intSeq: Long? = null,
    @SerializedName("date") var dateDay: String? = null,
    @SerializedName("instagram") var intInstagram: Int? = null,
    @SerializedName("youtube") var intYoutube: Int? = null,
    @SerializedName("blog") var intBlog: Int? = null,
    @SerializedName("work") var intWork: Int? = null
)

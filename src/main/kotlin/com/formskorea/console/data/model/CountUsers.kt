package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class CountUsers(
    @SerializedName("seq") var intSeq: Long? = null,
    @SerializedName("date") var dateDay: String? = null,
    @SerializedName("influencer") var intInfluencer: Int? = null,
    @SerializedName("client") var intClient: Int? = null,
    @SerializedName("instagram") var intInstagram: Int? = null,
    @SerializedName("youtube") var intYoutube: Int? = null,
    @SerializedName("blog") var intBlog: Int? = null
)

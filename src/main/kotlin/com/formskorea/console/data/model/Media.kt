package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class Media(
    @SerializedName("seq") var intSeq: Int? = null,
    @SerializedName("userseq") var intUserSeq: Int? = null,
    @SerializedName("usertype") var intUserType: Int? = null,
    @SerializedName("type") var intType: Int? = null,
    @SerializedName("url") var strURL: String? = null,
    @SerializedName("status") var intStatus: Int? = null,
    @SerializedName("count1") var intCount1: Int? = null,
    @SerializedName("count2") var intCount2: Int? = null,
    @SerializedName("count3") var intCount3: Int? = null
)

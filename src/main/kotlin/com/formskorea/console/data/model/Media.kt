package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class Media(
    var intSeq: Int? = null,
    @SerializedName("userseq") var intUserSeq: Int? = null,
    @SerializedName("usertype") var intUserType: Int? = null,
    @SerializedName("type") var intType: Int? = null,
    @SerializedName("url") var strURL: String? = null,
    @SerializedName("status") var intStatus: Int? = null
)

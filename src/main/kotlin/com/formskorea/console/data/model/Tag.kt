package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class Tag(
    @SerializedName("seq") var intSeq: Int? = null,
    @SerializedName("tag") var strTag: String? = null,
    @SerializedName("reg") var dateReg: String? = null,
    var intTagSeq: Int? = null,
    var intUserType: Int? = null,
    var intUserSeq: Int? = null
)

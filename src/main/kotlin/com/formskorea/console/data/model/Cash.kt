package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class Cash(
    @SerializedName("seq") var intSeq: Int? = null,
    var intUserType: Int? = null,
    var intUserSeq: Int? = null,
    @SerializedName("cashtype") var intCashType: Int? = null,
    @SerializedName("banktype") var strBankType: String? = null,
    @SerializedName("banknum") var strBankNum: String? = null
)

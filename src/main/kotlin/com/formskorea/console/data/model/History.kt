package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class History(
    @SerializedName("seq") var intSeq: Int? = null,
    @SerializedName("code") var intCode: Int? = null,
    @SerializedName("aseq") var intAdminSeq: Int? = null,
    @SerializedName("cseq") var intClientSeq: Int? = null,
    @SerializedName("iseq") var intInfluencerSeq: Int? = null,
    @SerializedName("wseq") var intWorkSeq: Int? = null,
    @SerializedName("memo") var txtMemo: String? = null,
    @SerializedName("reg") var dateReg: String? = null
)

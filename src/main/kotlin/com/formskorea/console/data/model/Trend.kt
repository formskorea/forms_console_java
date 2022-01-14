package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class Trend(
    @SerializedName("seq") var intSeq: Long? = null,
    @SerializedName("date") var dateDay: String? = null,
    @SerializedName("type") var intType: Int? = null,
    @SerializedName("stype") var strType: String? = null,
    @SerializedName("sex") var intSex: Int? = null,
    @SerializedName("age") var strAge: String? = null,
    @SerializedName("trend") var strTrendText: String? = null,
    @SerializedName("percent") var fltPercent: Float? = null,
    @SerializedName("reg") var dateReg: String? = null
)

package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class WorkLog (
    @SerializedName("seq") var intSeq: Int? = null,
    @SerializedName("day") var dateDay: String? = null,
    @SerializedName("wseq") var intWorkSeq: Int? = null,
    @SerializedName("wiseq") var intWorkInfoSeq: Int? = null,
    @SerializedName("mseq") var intMediaSeq: Int? = null,
    @SerializedName("mtype") var intMediaType: Int? = null,
    @SerializedName("cseq") var intClientSeq: Int? = null,
    @SerializedName("iseq") var intInfluencerSeq: Int? = null,
    @SerializedName("count1") var intCount1: Int? = null,
    @SerializedName("count2") var intCount2: Int? = null,
    @SerializedName("count3") var intCount3: Int? = null,
    @SerializedName("count4") var intCount4: Int? = null,
    @SerializedName("count5") var intCount5: Int? = null,
    @SerializedName("count6") var intCount6: Int? = null,
    @SerializedName("count7") var intCount7: Int? = null,
    @SerializedName("count8") var intCount8: Int? = null,
    @SerializedName("count9") var intCount9: Int? = null,
    @SerializedName("count10") var intCount10: Int? = null
)
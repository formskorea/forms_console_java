package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class WorkInfo(
    @SerializedName("seq") var intSeq: Int? = null,
    @SerializedName("wseq") var intWorkSeq: Int? = null,
    @SerializedName("cseq") var intClientSeq: Int? = null,
    @SerializedName("iseq") var intInfSeq: Int? = null,
    @SerializedName("mtype") var intMediaType: Int? = null,
    @SerializedName("mseq") var intMediaSeq: Int? = null,
    @SerializedName("iurl") var strURL: String? = null,
    @SerializedName("ustatus") var intUserStatus: Int? = null,
    @SerializedName("cstatus") var intClientStatus: Int? = null,
    @SerializedName("price") var intPrice: Int? = null,
    @SerializedName("reg") var dateReg: String? = null,
    @SerializedName("edit") var dateEdit: String? = null,
    var influencer: User? = null,
    var media: Media? = null,
    @SerializedName("status") var intStatus: Int? = null
)
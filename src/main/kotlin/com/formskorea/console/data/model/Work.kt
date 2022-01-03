package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class Work(
    @SerializedName("seq") var intSeq: Int? = null,
    @SerializedName("title") var strTitle: String? = null,
    @SerializedName("info") var txtInfo: String? = null,
    @SerializedName("rstart") var dateReadystart: String? = null,
    @SerializedName("rend") var dateReadyend: String? = null,
    @SerializedName("start") var dateStart: String? = null,
    @SerializedName("end") var dateEnd: String? = null,
    @SerializedName("cseq") var intClientSeq: Int? = null,
    @SerializedName("comseq") var intCompanySeq: Int? = null,
    @SerializedName("stype") var intSelecttype: Int? = null,
    @SerializedName("totalprice") var intTotalPrice: Int? = null,
    @SerializedName("status") var intStatus: Int? = null,
    @SerializedName("reg") var dateReg: String? = null,
    @SerializedName("edit") var dateEdit: String? = null,
    var client: User? = null,
    var company: Company? = null,
    var tags: ArrayList<Tag>? = null,
    var infos: ArrayList<WorkInfo>? = null
)
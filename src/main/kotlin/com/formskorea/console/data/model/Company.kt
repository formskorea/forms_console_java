package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class Company(
    var intSeq: Int? = null,
    @SerializedName("comname") var strCompanyname: String? = null,
    @SerializedName("homepage") var strHomepage: String? = null,
    @SerializedName("tel") var strTelnum: String? = null,
    @SerializedName("zip") var strZipcode: String? = null,
    @SerializedName("address") var strAddress: String? = null,
    @SerializedName("address2") var strAddress2: String? = null,
    @SerializedName("zone") var strZone: String? = null,
    @SerializedName("level") var intLevel: Int? = null,
    @SerializedName("status") var intStatus: Int? = null,
    @SerializedName("reg") var dateReg: Int? = null,
    @SerializedName("edit") var dateEdit: Int? = null
)

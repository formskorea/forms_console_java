package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class Influencer(
    @SerializedName("ifid") var strIFID: String? = null,
    @SerializedName("ifname") var strName: String? = null
)

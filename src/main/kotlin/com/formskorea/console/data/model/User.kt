package com.formskorea.console.data.model

import com.google.gson.annotations.SerializedName

data class User(
    @SerializedName("seq") var intSeq: Int? = null,
    @SerializedName("mtype") var strMemberType: String? = null,
    @SerializedName("email") var strEmail: String? = null,
    @SerializedName("pass") var strPassword: String? = null,
    @SerializedName("name") var strName: String? = null,
    @SerializedName("mobile") var strMobile: String? = null,
    @SerializedName("tel") var strTelnum: String? = null,
    @SerializedName("nik") var strNikname: String? = null,
    @SerializedName("sex") var intSex: Int? = null,
    @SerializedName("perm") var strPermission: String? = null,
    @SerializedName("level") var intLevel: Int? = null,
    @SerializedName("status") var intStatus: Int? = null,
    @SerializedName("instargram") var strInstagram: String? = null,
    @SerializedName("youtube") var strYoutube: String? = null,
    @SerializedName("blog") var strBlog: String? = null,
    @SerializedName("mall") var strMall: String? = null,
    @SerializedName("reg") var dateReg: String? = null,
    @SerializedName("edit") var dateEdit: String? = null,
    var company: Company? = null,
    var media: ArrayList<Media>? = null,
    var tags: ArrayList<Tag>? = null,
    var cashs: ArrayList<Cash>? = null,
    @SerializedName("comseq") var intCompanySeq: Int? = null,
    @SerializedName("pass2") var strPassword2: String? = null,
    var txtPermission: String? = null,
    @SerializedName("save") var isSave : Boolean = false,
    var isLogin : Boolean? = false,
    var intSuper: Int? = null
)

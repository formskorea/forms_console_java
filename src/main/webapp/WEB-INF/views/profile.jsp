<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.data.model.User" %>
<%@ page import="com.formskorea.console.config.DefaultConfig" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String[] media = new String[4];
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
    User userinfo = (User) request.getAttribute("fmcuser");
    String memberType = "";
    switch (userinfo.getStrMemberType()) {
        case DefaultConfig.MEMBER_ADMIN:
            memberType = "관리자";
            break;
        case DefaultConfig.MEMBER_CLIENT:
            memberType = "고객사";
        default:
            memberType = "인플루언서";
    }
    String tags = "";
    String tagsv = "";
    for (int i = 0; i < userinfo.getTags().size(); i++) {
        tags += (i > 0 ? ", " : "") + "#" + userinfo.getTags().get(i).getStrTag();
        tagsv += (i > 0 ? "," : "") + userinfo.getTags().get(i).getStrTag();
    }

    String cashs = "";
    String[] cashsv = new String[2];
    if (userinfo.getCashs() != null && userinfo.getCashs().size() > 0) {
        for (int i = 0; i < userinfo.getCashs().size(); i++) {
            cashs += (i > 0 ? "<br />" : "") + userinfo.getCashs().get(i).getStrBankType() + " " + userinfo.getCashs().get(i).getStrBankNum();
            cashsv[0] = userinfo.getCashs().get(i).getStrBankType();
            cashsv[1] = userinfo.getCashs().get(i).getStrBankNum();
        }
    } else {
        cashs = "없음";
    }

    String[] corpaddress = new String[2];
    if (userinfo.getCompany() != null && userinfo.getCompany().getStrAddress() != null && !userinfo.getCompany().getStrAddress().equals("")) {
        String[] address = userinfo.getCompany().getStrAddress().split("\\|");
        corpaddress[0] = address[0] != null && !address[0].equals("") ? address[0] : "";
        corpaddress[1] = address[1] != null && !address[1].equals("") ? address[1] : "";
    }

%>
<jsp:include page="inc_header.jsp">
    <jsp:param name="styles" value="${arrCss}"/>
</jsp:include>
<jsp:include page="inc_menu.jsp">
    <jsp:param name="fmcuser" value="${userinfo}"/>
</jsp:include>
<main id="main" class="main">

    <div class="pagetitle">
        <h1>내 정보</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item active">내 정보</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section profile">
        <div class="row">
            <div class="col-xl-4">

                <div class="card">
                    <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

                        <img src="/img/ic_user.svg" alt="Profile" class="rounded-circle">
                        <h2><%=userinfo.getStrNikname()%>
                        </h2>
                        <h3><%=memberType%> Lv. <%=userinfo.getIntLevel()%>
                        </h3>
                        <div class="social-links mt-2" id="media_box">
                            <% for (Integer i = 0; i < userinfo.getMedia().size(); i++) {
                                switch (userinfo.getMedia().get(i).getIntType()) {
                                    case 1: %>
                            <a href="<%=userinfo.getMedia().get(i).getStrURL()%>" target="_blank" id="goto_instagram"
                               class="instagram"><i
                                    class="bi bi-instagram"></i></a>
                            <%
                                    media[0] = userinfo.getMedia().get(i).getStrURL();
                                    break;
                                case 2: %>
                            <a href="<%=userinfo.getMedia().get(i).getStrURL()%>" target="_blank" id="goto_youtube"
                               class="youtube"><i
                                    class="bi bi-youtube"></i></a>
                            <%
                                    media[1] = userinfo.getMedia().get(i).getStrURL();
                                    break;
                                case 3: %>
                            <a href="<%=userinfo.getMedia().get(i).getStrURL()%>" target="_blank" id="goto_blog"
                               class="blog"><i
                                    class="bi bi-bootstrap"></i></a>
                            <%
                                    media[2] = userinfo.getMedia().get(i).getStrURL();
                                    break;
                                case 4: %>
                            <a href="<%=userinfo.getMedia().get(i).getStrURL()%>" target="_blank" id="goto_shoppingmall"
                               class="shoppingmall"><i class="bi bi-cart3"></i></a>
                            <%
                                            media[3] = userinfo.getMedia().get(i).getStrURL();
                                            break;
                                    }
                                } %>
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-xl-8">

                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <ul class="nav nav-tabs nav-tabs-bordered">

                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">
                                    내 정보
                                </button>
                            </li>

                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">정보수정
                                </button>
                            </li>

                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-settings">설정
                                </button>
                            </li>

                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">
                                    비밀번호 변경
                                </button>
                            </li>

                        </ul>
                        <div class="tab-content pt-2">

                            <div class="tab-pane fade show active profile-overview" id="profile-overview">

                                <h5 class="card-title"><strong><i class="bi bi-info-circle"></i> 개인정보</strong></h5>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">성명</div>
                                    <div class="col-lg-9 col-md-8" id="view_name"><%=userinfo.getStrName()%>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">이메일</div>
                                    <div class="col-lg-9 col-md-8" id="view_email"><%=userinfo.getStrEmail()%>
                                    </div>
                                </div>

                                <% switch (userinfo.getStrMemberType()) {
                                    case DefaultConfig.MEMBER_CLIENT: %>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">연락처</div>
                                    <div class="col-lg-9 col-md-8" id="view_mobile"><%=userinfo.getStrMobile()%>
                                    </div>
                                </div>
                                <% break;
                                    case DefaultConfig.MEMBER_INFLUENCER:
                                %>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">활동명</div>
                                    <div class="col-lg-9 col-md-8" id="view_nikname"><%=userinfo.getStrNikname()%>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">연락처</div>
                                    <div class="col-lg-9 col-md-8" id="view_mobile"><%=userinfo.getStrMobile()%>
                                    </div>
                                </div>
                                <% break;
                                } %>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">해시태그</div>
                                    <div class="col-lg-9 col-md-8" id="view_tags"><%=(!userinfo.getStrMemberType().equals(DefaultConfig.MEMBER_ADMIN) && !tags.equals("") ? tags : "없음")%>
                                    </div>
                                </div>
                                <% if (userinfo.getStrMemberType().equals(DefaultConfig.MEMBER_CLIENT)) { %>
                                <h5 class="card-title"><strong><i class="bi bi-building"></i> 회사정보</strong></h5>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">회사명</div>
                                    <div class="col-lg-9 col-md-8" id="view_corpname"><%=(userinfo.getCompany() != null ? userinfo.getCompany().getStrCompanyname() : "없음")%>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">회사 연락처</div>
                                    <div class="col-lg-9 col-md-8" id="view_corptel"><%=(userinfo.getCompany() != null ? userinfo.getCompany().getStrTelnum() : "없음")%>
                                    </div>
                                </div>
                                <% } %>
                                <% if (userinfo.getStrMemberType().equals(DefaultConfig.MEMBER_INFLUENCER)) { %>
                                <h5 class="card-title"><strong><i class="bi bi-building"></i> 소속사정보</strong></h5>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">소속사명</div>
                                    <div class="col-lg-9 col-md-8" id="view_corpname"><%=(userinfo.getCompany() != null ? userinfo.getCompany().getStrCompanyname() : "없음")%>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">소속사 연락처</div>
                                    <div class="col-lg-9 col-md-8" id="view_corptel"><%=(userinfo.getCompany() != null ? userinfo.getCompany().getStrTelnum() : "없음")%>
                                    </div>
                                </div>
                                <% } %>
                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">주소</div>
                                    <div class="col-lg-9 col-md-8" id="view_address"><%=(userinfo.getCompany() != null ? "(" + userinfo.getCompany().getStrZipcode() + ") " + userinfo.getCompany().getStrAddress().replace("|", " ") : "없음")%>
                                    </div>
                                </div>
                                <% if (userinfo.getStrMemberType().equals(DefaultConfig.MEMBER_INFLUENCER)) { %>
                                <h5 class="card-title view_bank"><strong><i class="bi bi-cash-coin"></i> 금융정보</strong></h5>
                                <div class="row view_bank">
                                    <div class="col-lg-3 col-md-4 label ">입금은행정보</div>
                                    <div class="col-lg-9 col-md-8" id="view_cash"><%=cashs%>
                                    </div>
                                </div>
                                <% } %>
                            </div>

                            <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                                <!-- Profile Edit Form -->
                                <form id="form_editinfo" method="post" action="#">
                                    <%--                                    <div class="row mb-3">--%>
                                    <%--                                        <label class="col-md-4 col-lg-3 col-form-label"></label>--%>
                                    <%--                                        <div class="col-md-8 col-lg-9">--%>
                                    <%--                                            <img src="/img/ic_user.svg" alt="Profile">--%>
                                    <%--                                            <div class="pt-2">--%>
                                    <%--                                                <a href="#" class="btn btn-primary btn-sm"--%>
                                    <%--                                                   title="Upload new profile image"><i class="bi bi-upload"></i></a>--%>
                                    <%--                                                <a href="#" class="btn btn-danger btn-sm"--%>
                                    <%--                                                   title="Remove my profile image"><i class="bi bi-trash"></i></a>--%>
                                    <%--                                            </div>--%>
                                    <%--                                        </div>--%>
                                    <%--                                    </div>--%>
                                    <h5 class="card-title"><strong><i class="bi bi-info-circle"></i> 개인정보</strong></h5>
                                    <div class="row mb-3">
                                        <label for="Name" class="col-md-4 col-lg-3 col-form-label">성명</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="Name" type="text" class="form-control" id="Name"
                                                   value="<%=userinfo.getStrName()%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="Email" class="col-md-4 col-lg-3 col-form-label">이메일</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="Email" type="text" class="form-control" id="Email"
                                                   value="<%=userinfo.getStrEmail()%>">
                                        </div>
                                    </div>
                                    <% switch (userinfo.getStrMemberType()) {
                                        case DefaultConfig.MEMBER_CLIENT: %>
                                    <div class="row mb-3">
                                        <label for="Mobile" class="col-md-4 col-lg-3 col-form-label">연락처</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="Mobile" type="text" class="form-control" id="Mobile"
                                                   value="<%=userinfo.getStrMobile()%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="hashtag" class="col-md-4 col-lg-3 col-form-label">해시태그</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="hashtag" type="text" class="form-control" id="hashtag"
                                                   value="<%=tagsv%>">
                                        </div>
                                    </div>
                                    <h5 class="card-title"><strong><i class="bi bi-building"></i> 회사정보</strong></h5>
                                    <div class="row mb-3">
                                        <label for="corpname" class="col-md-4 col-lg-3 col-form-label">회사명</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="corpname" type="text" class="form-control" id="corpname"
                                                   value="<%=(userinfo.getCompany() != null &&  userinfo.getCompany().getStrCompanyname() != null ? userinfo.getCompany().getStrCompanyname() : "")%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="corpname" class="col-md-4 col-lg-3 col-form-label">회사 연락처</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="corptel" type="tel" class="form-control" id="corptel"
                                                   value="<%=(userinfo.getCompany() != null && userinfo.getCompany().getStrTelnum() != null  ? userinfo.getCompany().getStrTelnum() : "")%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="zipcode" class="col-md-4 col-lg-3 col-form-label">우편번호</label>
                                        <div class="col-md-8 col-lg-5">
                                            <input type="text" name="zipcode" class="form-control" id="zipcode"
                                                   readonly
                                                   value="<%=(userinfo.getCompany() != null &&  userinfo.getCompany().getStrZipcode() != null ? userinfo.getCompany().getStrZipcode(): "")%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="address1" class="col-md-4 col-lg-3 col-form-label">주소</label>
                                        <div class="col-md-4 col-lg-6">
                                            <input type="text" name="address1" class="form-control" id="address1"
                                                   readonly value="<%=corpaddress[0]%>">
                                        </div>
                                        <div class="col-md-8 col-lg-3">
                                            <button class="btn btn-outline-primary w-100" type="button"
                                                    id="addr_search">
                                                주소검색
                                            </button>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="address2" class="col-md-4 col-lg-3 col-form-label">상세주소</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="address2" type="text" class="form-control" id="address2"
                                                   value="<%=corpaddress[1]%>">
                                        </div>
                                    </div>
                                    <% break;
                                        case DefaultConfig.MEMBER_INFLUENCER:
                                    %>
                                    <div class="row mb-3">
                                        <label for="Nikname" class="col-md-4 col-lg-3 col-form-label">활동명</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="Nikname" type="text" class="form-control" id="Nikname"
                                                   value="<%=userinfo.getStrNikname()%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="Mobile" class="col-md-4 col-lg-3 col-form-label">연락처</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="Mobile" type="text" class="form-control" id="Mobile"
                                                   value="<%=userinfo.getStrMobile()%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="hashtag" class="col-md-4 col-lg-3 col-form-label">해시태그</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="hashtag" type="text" class="form-control" id="hashtag"
                                                   value="<%=tagsv%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="media_1" class="form-col-md-4 col-lg-3 col-form-label"><i
                                                class="bi bi-instagram"></i>
                                            Instargram</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="text" name="media_1" class="form-control" id="media_1"
                                                   placeholder="" value="<%=media[0]%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="media_2" class="form-col-md-4 col-lg-3 col-form-label"><i
                                                class="bi bi-youtube"></i>
                                            Youtube</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="text" name="media_2" class="form-control" id="media_2"
                                                   placeholder="" value="<%=media[1]%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="media_3" class="form-col-md-4 col-lg-3 col-form-label"><i
                                                class="bi bi-bootstrap"></i>
                                            Blog</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="text" name="media_3" class="form-control" id="media_3"
                                                   placeholder="" value="<%=media[2]%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <label for="media_4" class="form-col-md-4 col-lg-3 col-form-label"><i
                                                class="bi bi-cart3"></i> Shopping
                                            mall</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="text" name="media_4" class="form-control" id="media_4"
                                                   placeholder="" value="<%=media[3]%>">
                                        </div>
                                    </div>
                                    <h5 class="card-title"><strong><i class="bi bi-building"></i> 소속사정보</strong></h5>
                                    <div class="row mb-3">
                                        <label for="corpname" class="col-md-4 col-lg-3 col-form-label">소속사 유무</label>
                                        <div class="col-lg-2">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gridRadios"
                                                       id="gridRadios1"
                                                       value="1" <%=(userinfo.getCompany() != null ? "checked" : "")%> >
                                                <label class="form-check-label" for="gridRadios1">
                                                    있음
                                                </label>
                                            </div>
                                        </div>
                                        <div class="form-check form-check-inline col-lg-2">
                                            <input class="form-check-input" type="radio" name="gridRadios"
                                                   id="gridRadios2"
                                                   value="0" <%=(userinfo.getCompany() == null ? "checked" : "")%>>
                                            <label class="form-check-label" for="gridRadios2">
                                                없음
                                            </label>
                                        </div>

                                    </div>
                                    <div class="row mb-3 corpinfo <%=(userinfo.getCompany() == null ? "d-none" : "")%>">
                                        <label for="corpname" class="col-md-4 col-lg-3 col-form-label">소속사명</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="corpname" type="text" class="form-control" id="corpname"
                                                   value="<%=(userinfo.getCompany() != null &&  userinfo.getCompany().getStrCompanyname() != null ? userinfo.getCompany().getStrCompanyname() : "")%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3 corpinfo <%=(userinfo.getCompany() == null ? "d-none" : "")%>">
                                        <label for="corpname" class="col-md-4 col-lg-3 col-form-label">소속사 연락처</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="corptel" type="tel" class="form-control" id="corptel"
                                                   value="<%=(userinfo.getCompany() != null && userinfo.getCompany().getStrTelnum() != null  ? userinfo.getCompany().getStrTelnum() : "")%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3 corpinfo <%=(userinfo.getCompany() == null ? "d-none" : "")%>">
                                        <label for="zipcode" class="col-md-4 col-lg-3 col-form-label">우편번호</label>
                                        <div class="col-md-8 col-lg-5">
                                            <input type="text" name="zipcode" class="form-control" id="zipcode"
                                                   readonly
                                                   value="<%=(userinfo.getCompany() != null &&  userinfo.getCompany().getStrZipcode() != null ? userinfo.getCompany().getStrZipcode(): "")%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3 corpinfo <%=(userinfo.getCompany() == null ? "d-none" : "")%>">
                                        <label for="address1" class="col-md-4 col-lg-3 col-form-label">주소</label>
                                        <div class="col-md-4 col-lg-6">
                                            <input type="text" name="address1" class="form-control" id="address1"
                                                   readonly value="<%=(corpaddress[0] != null ? corpaddress[0] : "")%>">
                                        </div>
                                        <div class="col-md-8 col-lg-3">
                                            <button class="btn btn-outline-primary w-100" type="button"
                                                    id="addr_search">
                                                주소검색
                                            </button>
                                        </div>
                                    </div>
                                    <div class="row mb-3 corpinfo <%=(userinfo.getCompany() == null ? "d-none" : "")%>">
                                        <label for="address2" class="col-md-4 col-lg-3 col-form-label">상세주소</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="address2" type="text" class="form-control" id="address2"
                                                   value="<%=(corpaddress[1] != null ? corpaddress[1] : "")%>">
                                        </div>
                                    </div>
                                    <h5 class="card-title"><strong><i class="bi bi-cash-coin"></i> 금융정보</strong></h5>
                                    <div class="row mb-3">
                                        <label for="banktype" class="col-md-4 col-lg-3 col-form-label">입금은행정보</label>
                                        <div class="col-md-8 col-lg-3">
                                            <input name="banktype" type="text" class="form-control" id="banktype"
                                                   value="<%=cashsv[0]%>" placeholder="은행구분 예)국민, 신한 등">
                                        </div>
                                        <div class="col-md-8 col-lg-6">
                                            <input name="bankinfo" type="text" class="form-control" id="bankinfo"
                                                   value="<%=cashsv[1]%>" placeholder="계좌번호입력">
                                        </div>
                                    </div>
                                    <% break;
                                    } %>
                                    <div class="text-center mt-5">
                                        <button type="submit" class="btn btn-primary">내정보 수정하기</button>
                                    </div>
                                </form><!-- End Profile Edit Form -->

                            </div>

                            <div class="tab-pane fade pt-3" id="profile-settings">

                                <!-- Settings Form -->
                                <form>

                                    <div class="row mb-3">
                                        <label for="" class="col-md-4 col-lg-3 col-form-label">알림 설정</label>
                                        <div class="col-md-8 col-lg-9">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="changesMade"
                                                       checked>
                                                <label class="form-check-label" for="changesMade">
                                                    이메일 알림
                                                </label>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary">설정 수정</button>
                                    </div>
                                </form><!-- End settings Form -->

                            </div>

                            <div class="tab-pane fade pt-3" id="profile-change-password">
                                <!-- Change Password Form -->
                                <form>

                                    <div class="row mb-3">
                                        <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">현재
                                            비밀번호</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="password" type="password" class="form-control"
                                                   id="currentPassword">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">새 비밀번호</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="newpassword" type="password" class="form-control"
                                                   id="newPassword">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">새 비밀번호
                                            확인</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input name="renewpassword" type="password" class="form-control"
                                                   id="renewPassword">
                                        </div>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary">비밀번호 변경</button>
                                    </div>
                                </form><!-- End Change Password Form -->

                            </div>

                        </div><!-- End Bordered Tabs -->

                    </div>
                </div>

            </div>
        </div>
    </section>

</main>
<script>
    var MEMTYPE = "<%=userinfo.getStrMemberType()%>";
</script>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

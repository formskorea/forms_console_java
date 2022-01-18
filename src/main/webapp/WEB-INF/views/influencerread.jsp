<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.data.model.User" %>
<%@ page import="com.formskorea.console.config.DefaultConfig" %>
<%@ page import="com.formskorea.console.data.model.Media" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
    User userinfo = (User) request.getAttribute("fmcuser");
    User influencer = (User) request.getAttribute("influencer");

    String infStatus = "대기";
    switch (influencer.getIntStatus()) {
        case DefaultConfig.MEMBER_OK:
            infStatus = "정상";
            break;
        case DefaultConfig.MEMBER_REJECT:
            infStatus = "탈퇴";
            break;
        case DefaultConfig.MEMBER_CUT:
            infStatus = "차단";
            break;
    }

    String[] Urls = new String[5];
    Urls[1] = "";
    Urls[2] = "";
    Urls[3] = "";
    Urls[4] = "";
    
//
//    for (int i = 0; i < influencer.getMedia().size(); i++) {
//        Media field = influencer.getMedia().get(i);
//        if (field.getStrURL() != null && !field.getStrURL().isBlank()) {
//            Urls[field.getIntType()] = field.getStrURL();
//        }
//    }

%>
<jsp:include page="inc_header.jsp">
    <jsp:param name="styles" value="${arrCss}"/>
</jsp:include>
<jsp:include page="inc_menu.jsp">
    <jsp:param name="fmcuser" value="${userinfo}"/>
    <jsp:param name="nowmenu" value="3"/>
</jsp:include>
<main id="main" class="main">

    <div class="pagetitle">
        <h1><%=influencer.getStrName()%>(<%=influencer.getStrNikname()%>)의 정보</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item">인플루언서</li>
                <li class="breadcrumb-item active">상세정보</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section">
        <div class="row work-add">
            <div class="card">
                <h5 class="card-title"><strong>회원정보</strong></h5>
                <div class="card-body">
                    <div class="row mb-3">
                        <label class="col-md-2 col-form-label">성명</label>
                        <div class="col-md-4">
                            <%=influencer.getStrName()%>
                        </div>
                        <label class="col-md-2 col-form-label">활동명</label>
                        <div class="col-md-4">
                            <%=influencer.getStrNikname()%>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-md-2 col-form-label">이메일</label>
                        <div class="col-md-4">
                            <%=influencer.getStrEmail()%>
                        </div>
                        <label class="col-md-2 col-form-label">연락처</label>
                        <div class="col-md-4">
                            <%=influencer.getStrMobile()%>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-md-2 col-form-label">상태</label>
                        <div class="col-md-10">
                            <%=infStatus%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <h5 class="card-title"><strong>매체정보</strong></h5>
                <div class="card-body">
                    <% if (!Urls[1].isBlank()) { %>
                    <div class="row mb-3">
                        <label class="col-md-2 col-form-label">Instagram</label>
                        <div class="col-md-10">
                            <%=Urls[1]%>
                        </div>
                    </div>
                    <% } %>
                    <% if (!Urls[2].isBlank()) { %>
                    <div class="row mb-3">
                        <label class="col-md-2 col-form-label">Youtube</label>
                        <div class="col-md-10">
                            <%=Urls[2]%>
                        </div>
                    </div>
                    <% } %>
                    <% if (!Urls[3].isBlank()) { %>
                    <div class="row mb-3">
                        <label class="col-md-2 col-form-label">Blog</label>
                        <div class="col-md-10">
                            <%=Urls[3]%>
                        </div>
                    </div>
                    <% } %>
                    <% if (!Urls[4].isBlank()) { %>
                    <div class="row mb-3">
                        <label class="col-md-2 col-form-label">Shopping mall</label>
                        <div class="col-md-10">
                            <%=Urls[4]%>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
            <% if (influencer.getCompany() != null) { %>
            <div class="card">
                <h5 class="card-title"><strong>소속사 정보</strong></h5>
                <div class="card-body">
                    <div class="row mb-3 inf_comapy_checked">
                        <label class="col-md-2 col-form-label">소속사명</label>
                        <div class="col-md-4">
                            <%=influencer.getCompany().getStrCompanyname()%>
                        </div>
                        <label class="col-md-2 col-form-label">소속사 연락처</label>
                        <div class="col-md-4">
                            <%=influencer.getCompany().getStrTelnum()%>
                        </div>
                    </div>
                    <div class="row mb-3 inf_comapy_checked">
                        <label class="col-md-2 col-form-label">주소</label>
                        <div class="col-md-12">
                            (<%=influencer.getCompany().getStrZipcode()%>) <%=influencer.getCompany().getStrAddress().replace("|", " ")%>
                        </div>
                    </div>
                    <div class="row mb-3 inf_comapy_checked">
                        <label class="col-md-2 col-form-label">사업자 등록번호</label>
                        <div class="col-md-4">
                           <%=influencer.getCompany().getStrCompanynum()%>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            <div class="row mb-3 align-center">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <button class="btn-lg btn-primary w-100" type="button" id="inf_editgo"><i class="bx bx-user-plus"></i> 인플루언서 수정하기</button>
                </div>
                <div class="col-md-3"></div>
            </div>
        </div>
    </section>
</main>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_searchcompany.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

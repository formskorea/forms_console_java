<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.data.model.User" %>
<%@ page import="com.formskorea.console.config.DefaultConfig" %>
<%@ page import="com.formskorea.console.data.model.Media" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
    User userinfo = (User) request.getAttribute("fmcuser");

    User client = (User) request.getAttribute("client");

    String keyword = (String) request.getAttribute("keyword");
    String ppage = (String) request.getAttribute("page");
    String status = (String) request.getAttribute("status");

    String infStatus = "대기";
    switch (client.getIntStatus()) {
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

    String tagsv = "";
    if(client.getTags() != null && client.getTags().size() > 0) {
        for (int i = 0; i < client.getTags().size(); i++) {
            tagsv += (i > 0 ? ", " : "") + "#" + client.getTags().get(i).getStrTag();
        }
    }

%>
<jsp:include page="inc_header.jsp">
    <jsp:param name="styles" value="${arrCss}"/>
</jsp:include>
<jsp:include page="inc_menu.jsp">
    <jsp:param name="fmcuser" value="${userinfo}"/>
    <jsp:param name="nowmenu" value="4"/>
</jsp:include>
<main id="main" class="main">

    <div class="pagetitle">
        <h1><%=client.getStrName()%>의 정보</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item">협력사</li>
                <li class="breadcrumb-item active">상세정보</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section">
        <div class="row work-add">
            <div class="card">
                <h5 class="card-title"><strong>담당자 정보</strong></h5>
                <div class="card-body">
                    <div class="row mb-3">
                        <label class="col-md-2 col-form-label">성명</label>
                        <div class="col-md-4">
                            <%=client.getStrName()%>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-md-2 col-form-label">이메일</label>
                        <div class="col-md-4">
                            <%=client.getStrEmail()%>
                        </div>
                        <label class="col-md-2 col-form-label">연락처</label>
                        <div class="col-md-4">
                            <%=client.getStrMobile()%>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-md-2 col-form-label">관련 키워드</label>
                        <div class="col-md-10">
                            <%=tagsv%>
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
            <% if (client.getCompany() != null) { %>
            <div class="card">
                <h5 class="card-title"><strong>회사 정보</strong></h5>
                <div class="card-body">
                    <div class="row mb-3 inf_comapy_checked">
                        <label class="col-md-2 col-form-label">회사명</label>
                        <div class="col-md-4">
                            <%=client.getCompany().getStrCompanyname()%>
                        </div>
                        <label class="col-md-2 col-form-label">회사 연락처</label>
                        <div class="col-md-4">
                            <%=client.getCompany().getStrTelnum()%>
                        </div>
                    </div>
                    <div class="row mb-3 inf_comapy_checked">
                        <label class="col-md-2 col-form-label">주소</label>
                        <div class="col-md-10">
                            (<%=client.getCompany().getStrZipcode()%>
                            ) <%=client.getCompany().getStrAddress().replace("|", " ")%>
                        </div>
                    </div>
                    <div class="row mb-3 inf_comapy_checked">
                        <label class="col-md-2 col-form-label">사업자 등록번호</label>
                        <div class="col-md-4">
                            <%=(client.getCompany().getStrCompanynum() == null ? "없음" : client.getCompany().getStrCompanynum())%>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            <div class="mb-3 align-center text-center">
                <button class="btn-lg btn-primary" type="button" id="cl_editgo"><i class="bx bx-user-plus"></i> 협력사 수정하기</button>
                <button class="btn-lg btn-outline-primary ms-3" type="button" id="cl_listgo">목록으로</button>
            </div>
        </div>
    </section>
</main>
<script>
    var keyword = "<%=keyword%>";
    var page = "<%=ppage%>";
    var status = "<%=status%>";
    var infno = "<%=client.getIntSeq()%>";
</script>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_searchcompany.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

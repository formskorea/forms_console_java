<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.data.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
    User userinfo = (User) request.getAttribute("fmcuser");
%>
<jsp:include page="inc_header.jsp">
    <jsp:param name="styles" value="${arrCss}"/>
</jsp:include>
<jsp:include page="inc_menu.jsp">
    <jsp:param name="fmcuser" value="${userinfo}"/>
</jsp:include>
<main id="main" class="main">

    <div class="pagetitle">
        <h1>협력사</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item active">협력사</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section">
        <div class="card mt-5 mb-3" id="search_box">
            <div class="card-body mt-3 row pt-3">
                <div class="row col-md-4 mb-3">
                    <div class="btn-group" role="group" aria-label="상태">
                        <button type="button" id="search_status1" class="status btn btn-primary" ss-data="1">정상</button>
                        <button type="button" id="search_status2" class="status btn btn-outline-primary" ss-data="0">대기</button>
                        <button type="button" id="search_status3" class="status btn btn-outline-primary" ss-data="9">차단</button>
                        <button type="button" id="search_status4" class="status btn btn-outline-primary" ss-data="5">탈퇴</button>
                    </div>
                </div>
                <div class="row col-md-6 mb-3">
                    <div class="input-group">
                        <span class="input-group-text">키워드 검색</span>
                        <input type="text" class="form-control" id="search_text" name="search_text" aria-describedby="basic-addon3"
                               placeholder="예)뷰티, 아모레">
                    </div>
                </div>
                <div class="row col-md-2 mb-3">
                    <button class="btn btn-primary" id="search_button"><i class="bi bi-search"></i> 검색하기</button>
                </div>
            </div>

        </div>
        <div class="row g-0 mb-3" id="item_box">
            <div class="card mb-3 item_row">
                <div class="row g-0">
<%--                    <div class="col-md-2 align-center">--%>
<%--                        <img src="/img/card.jpg" class="img-fluid rounded" alt="...">--%>
<%--                    </div>--%>
                    <div class="col-md-12">
                        <div class="card-body">
                            <div class="row">
                                <h5 class="card-title item_name col-md-3 text-1em text-1em">활동명</h5>
                                <span class="item_tel col-md-3 card-title text-secondary text-center text-1em">010-0000-0000</span>
                                <span class="item_email col-md-3 card-title text-secondary text-center text-1em">email@email.com</span>
                                <span class="item_level col-md-2 card-title text-secondary text-center text-1em">lv1</span>
                                <span class="item_status col-md-1 card-title text-secondary text-center text-1em"><span class="badge bg-success text-light">정상</span></span>
                            </div>
                            <div class="row item_company_box">
                                <h5 class="card-title item_companyname col-md-3 pt-md-0 text-1em">회사명</h5>
                                <span class="item_companytel col-md-3 card-title text-secondary pt-md-0 text-center text-1em">010-0000-0000</span>
                                <span class="item_companyaddr col-md-6 card-title text-secondary pt-md-0 text-center text-1em">주소주소</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row g-0 mb-3 d-none" id="loading_box">
            <div class="loader col-md-12 text-center">Loading...</div>
        </div>
        <div class="row g-0 mb-3 d-none" id="empty_box">
            <div class="text-center">
                <i class="bi bi-trash2" style="font-size: 6em;"></i><br />
                <span>협력사 정보가 없습니다.</span>
            </div>
        </div>
        <nav aria-label="Page navigation" id="page_box">

        </nav>
    </section>

</main>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

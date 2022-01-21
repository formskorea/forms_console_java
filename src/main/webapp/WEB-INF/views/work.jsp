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
    <jsp:param name="nowmenu" value="5"/>
</jsp:include>
<main id="main" class="main">

    <div class="pagetitle">
        <h1>협업</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item active">협업</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section">
        <div class="text-end mb-3">
            <button class="btn btn-primary" id="work_addgo"><i class="bx bx-add-to-queue"></i> 새로등록</button>
        </div>
        <div class="card mb-3" id="search_box">
            <div class="card-body mt-3 row pt-3">
                <div class="row col-md-4 mb-3">
                    <div class="btn-group" role="group" aria-label="상태">
                        <button type="button" id="search_status1" class="status btn btn-primary" ss-data="1">진행</button>
                        <button type="button" id="search_status2" class="status btn btn-outline-primary" ss-data="0">
                            모집
                        </button>
                        <button type="button" id="search_status3" class="status btn btn-outline-primary" ss-data="9">
                            취소
                        </button>
                        <button type="button" id="search_status4" class="status btn btn-outline-primary" ss-data="5">
                            대기
                        </button>
                        <button type="button" id="search_status5" class="status btn btn-outline-primary" ss-data="7">
                            완료
                        </button>
                    </div>
                </div>
                <div class="row col-md-6 mb-3">
                    <div class="input-group">
                        <span class="input-group-text">키워드 검색</span>
                        <input type="text" class="form-control" id="search_text" name="search_text"
                               aria-describedby="basic-addon3"
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
                                <h5 class="card-title item_title col-md-5 text-1em text-1em">협업명</h5>
                                <div class="col-md-3 card-title text-center"><span
                                        class="item_days text-secondary text-1em">0000-00-00 ~ 0000-00-00</span></div>
                                <div class="col-md-1 card-title text-center text-secondary text-1em"><i
                                        class="bi bi-instagram" data-bs-toggle="tooltip"
                                        data-bs-placement="top" data-bs-original-title="인스타그램"></i>&nbsp;
                                    <span class="item_instagram_count">-</span></div>
                                <div class="col-md-1 card-title text-center text-secondary text-1em"><i
                                        class="bi bi-play-btn-fill" data-bs-toggle="tooltip"
                                        data-bs-placement="top" data-bs-original-title="유튜브"></i>&nbsp;
                                    <span class="item_youtube_count">-</span></div>
                                <div class="col-md-1 card-title text-center text-secondary text-1em"><i
                                        class="bi bi-bootstrap" data-bs-toggle="tooltip"
                                        data-bs-placement="top" data-bs-original-title="블로그"></i>&nbsp;
                                    <span class="item_blog_count">-</span></div>
                                <span class="item_status col-md-1 card-title text-secondary text-center text-1em"><span
                                        class="badge bg-success text-light">진행</span></span>
                            </div>
                            <div class="row">
                                <h5 class="item_companyname col-md-3 pt-md-0 text-1em">회사명</h5>
                                <span class="item_companytel col-md-2 text-secondary pt-md-0 text-center text-1em">010-0000-0000</span>
                                <span class="item_companyemail col-md-3 text-secondary pt-md-0 text-center text-1em">aaaa@bbbb.com</span>
                                <span class="item_totalprice col-md-2 text-secondary pt-md-0 text-center text-1em text-bold">0원</span>
                                <span class="item_readbox col-md-2 text-secondary pt-md-0 text-end">
                                    <button class="btn btn-outline-primary item_readgo align-center"><i
                                            class="ri-information-line"></i> 상세보기</button>
                                </span>
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
                <i class="bi bi-trash2" style="font-size: 6em;"></i><br/>
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

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
        <h1>인플루언서</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item active">인플루언서</li>
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
                    <button class="btn btn-primary"><i class="bi bi-search"></i> 검색하기</button>
                </div>
            </div>

        </div>
        <div class="row g-0 mb-3" id="item_box">
            <div class="card mb-3 item_row">
                <div class="row g-0">
                    <div class="col-md-2 align-center">
                        <img src="/img/card.jpg" class="img-fluid rounded" alt="...">
                    </div>
                    <div class="col-md-10">
                        <div class="card-body">
                            <div class="row">
                                <h5 class="card-title item_name col-md-3">활동명 (성명)</h5>
                                <span class="item_tel col-md-3 card-title text-secondary" style="text-align: center;">010-0000-0000</span>
                                <span class="item_email col-md-3 card-title text-secondary" style="text-align: center;">email@email.com</span>
                                <span class="item_level col-md-1 card-title text-secondary" style="text-align: center;">lv1</span>
                                <span class="item_status col-md-1 card-title text-secondary"
                                      style="text-align: center;"> <span
                                        class="badge bg-success text-light">정상</span></span>
                            </div>
                            <div class="row mb-1 item_instagram_box">
                                <label class="col-md-6 h5"><a href="#" target="_blank" class="item_media_link"
                                                              data-bs-toggle="tooltip" data-bs-placement="top"
                                                              data-bs-original-title="인스타그램 링크"><i
                                        class="bi bi-instagram"></i> <span
                                        class="h5 item_media_link">-</span></a></label>
                                <div class="col-md-2 h5"><i class="ri-user-received-2-fill" data-bs-toggle="tooltip"
                                                            data-bs-placement="top" data-bs-original-title="팔로워"></i>
                                    <span class="item_follower">-</span></div>
                                <div class="col-md-2 h5"><i class="ri-user-shared-2-fill" data-bs-toggle="tooltip"
                                                            data-bs-placement="top" data-bs-original-title="팔로우"></i>
                                    <span class="item_follow">-</span></div>
                                <div class="col-md-2 h5"><i class="bi bi-image" data-bs-toggle="tooltip"
                                                            data-bs-placement="top" data-bs-original-title="게시물"></i>
                                    <span class="item_upcount">-</span></div>
                            </div>
                            <div class="row mb-1 item_youtube_box">
                                <label class="col-md-6 h5"><a href="#" target="_blank" class="item_media_link"
                                                              data-bs-toggle="tooltip" data-bs-placement="top"
                                                              data-bs-original-title="유튜브 링크"><i
                                        class="bi bi-play-btn-fill"></i> <span
                                        class="h5 item_media_link">-</span></a></label>
                                <div class="col-md-2 h5"><i class="ri-user-received-2-fill" data-bs-toggle="tooltip"
                                                            data-bs-placement="top" data-bs-original-title="구독자"></i>
                                    <span class="item_follower">-</span></div>
                                <div class="col-md-2 h5"><i class="bi bi-play-btn-fill" data-bs-toggle="tooltip"
                                                            data-bs-placement="top" data-bs-original-title="조회수"></i>
                                    <span class="item_follow">-</span></div>
                                <div class="col-md-2 h5"><i class="bi bi-camera-video" data-bs-toggle="tooltip"
                                                            data-bs-placement="top" data-bs-original-title="동영상"></i>
                                    <span class="item_upcount">-</span></div>
                            </div>
                            <div class="row mb-1 item_blog_box">
                                <label class="col-md-6 h5"><a href="#" target="_blank" class="item_media_link"
                                                              data-bs-toggle="tooltip" data-bs-placement="top"
                                                              data-bs-original-title="블로그 링크"><i
                                        class="bi bi-bootstrap"></i> <span
                                        class="h5 item_media_link">-</span></a></label>
                                <div class="col-md-2 h5"><i class="ri-user-received-2-fill" data-bs-toggle="tooltip"
                                                            data-bs-placement="top" data-bs-original-title="방문자"></i>
                                    <span class="item_follower">-</span></div>
                                <div class="col-md-2 h5"><i class="ri-stack-overflow-fill" data-bs-toggle="tooltip"
                                                            data-bs-placement="top" data-bs-original-title="게시물"></i>
                                    <span class="item_follow">-</span></div>
                            </div>
                            <div class="row mb-1 item_blog_box">
                                <label class="col-md-12 h5"><a href="#" target="_blank" class="item_media_link"
                                                              data-bs-toggle="tooltip" data-bs-placement="top"
                                                              data-bs-original-title="쇼핑몰 링크"><i
                                        class="bi bi-cart3"></i> <span class="h5 item_media_link">-</span></a></label>
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
                <span>인플루언서 정보가 없습니다.</span>
            </div>
        </div>
        <nav aria-label="Page navigation" id="page_box">
            <ul class="pagination justify-content-center">
                <li class="page-item"><a class="page-link" href="#">이전</a></li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">다음</a></li>
            </ul>
        </nav>
    </section>

</main>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

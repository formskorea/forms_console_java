<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.data.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
    User userinfo = (User) request.getAttribute("fmcuser");

    String keyword = (String) request.getAttribute("keyword");
    String ppage = (String) request.getAttribute("page");
    String status = (String) request.getAttribute("status");
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
        <h1>인플루언서</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item active">인플루언서</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section">
        <div class="text-end mt-3 mb-3">
            <button class="btn btn-primary" id="inf_addgo"><i class="bx bx-add-to-queue"></i> 새로등록</button>
        </div>
        <div class="card mb-3" id="search_box">
            <div class="card-body mt-3 row pt-3">
                <div class="row col-md-4 mb-3">
                    <div class="btn-group" role="group" aria-label="상태">
                        <button type="button" id="search_status1" class="status btn btn-primary" ss-data="1">정상</button>
                        <button type="button" id="search_status2" class="status btn btn-outline-primary" ss-data="0">
                            대기
                        </button>
                        <button type="button" id="search_status3" class="status btn btn-outline-primary" ss-data="9">
                            차단
                        </button>
                        <button type="button" id="search_status4" class="status btn btn-outline-primary" ss-data="5">
                            탈퇴
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
                                <h5 class="card-title item_name col-md-3 text-1em">활동명 (성명)</h5>
                                <span class="item_tel col-md-3 card-title text-secondary text-center text-1em">010-0000-0000</span>
                                <span class="item_email col-md-3 card-title text-secondary text-center text-1em">email@email.com</span>
                                <span class="item_level col-md-2 card-title text-secondary text-center text-1em">lv1</span>
                                <span class="item_status col-md-1 card-title text-secondary text-center text-1em"><span
                                        class="badge bg-success text-light">정상</span></span>
                            </div>
                            <div class="row mb-1 item_instagram_box">
                                <label class="col-md-6 "><a href="#" target="_blank" class="item_media_link text-1em"
                                                            data-bs-toggle="tooltip" data-bs-placement="top"
                                                            data-bs-original-title="인스타그램 링크"><i
                                        class="bi bi-instagram"></i> <span
                                        class="item_media_link">-</span></a></label>
                                <div class="col-md-2  text-1em"><i class="ri-user-received-2-fill"
                                                                   data-bs-toggle="tooltip"
                                                                   data-bs-placement="top"
                                                                   data-bs-original-title="팔로워"></i>
                                    <span class="item_follower">-</span></div>
                                <div class="col-md-2  text-1em"><i class="ri-user-shared-2-fill"
                                                                   data-bs-toggle="tooltip"
                                                                   data-bs-placement="top"
                                                                   data-bs-original-title="팔로우"></i>
                                    <span class="item_follow">-</span></div>
                                <div class="col-md-2  text-1em"><i class="bi bi-image" data-bs-toggle="tooltip"
                                                                   data-bs-placement="top"
                                                                   data-bs-original-title="게시물"></i>
                                    <span class="item_upcount">-</span></div>
                            </div>
                            <div class="row mb-1 item_youtube_box">
                                <label class="col-md-6 "><a href="#" target="_blank" class="item_media_link text-1em"
                                                            data-bs-toggle="tooltip" data-bs-placement="top"
                                                            data-bs-original-title="유튜브 링크"><i
                                        class="bi bi-play-btn-fill"></i> <span
                                        class="  item_media_link">-</span></a></label>
                                <div class="col-md-2 text-1em"><i class="ri-user-received-2-fill"
                                                                  data-bs-toggle="tooltip"
                                                                  data-bs-placement="top"
                                                                  data-bs-original-title="구독자"></i>
                                    <span class="item_follower">-</span></div>
                                <div class="col-md-2 text-1em"><i class="bi bi-play-btn-fill" data-bs-toggle="tooltip"
                                                                  data-bs-placement="top"
                                                                  data-bs-original-title="조회수"></i>
                                    <span class="item_follow">-</span></div>
                                <div class="col-md-2 text-1em"><i class="bi bi-camera-video" data-bs-toggle="tooltip"
                                                                  data-bs-placement="top"
                                                                  data-bs-original-title="동영상"></i>
                                    <span class="item_upcount">-</span></div>
                            </div>
                            <div class="row mb-1 item_blog_box">
                                <label class="col-md-6 "><a href="#" target="_blank" class="item_media_link text-1em"
                                                            data-bs-toggle="tooltip" data-bs-placement="top"
                                                            data-bs-original-title="블로그 링크"><i
                                        class="bi bi-bootstrap"></i> <span
                                        class="  item_media_link">-</span></a></label>
                                <div class="col-md-2 text-1em"><i class="ri-user-received-2-fill"
                                                                  data-bs-toggle="tooltip"
                                                                  data-bs-placement="top"
                                                                  data-bs-original-title="방문자"></i>
                                    <span class="item_follower">-</span></div>
                                <div class="col-md-2 text-1em"><i class="ri-stack-overflow-fill"
                                                                  data-bs-toggle="tooltip"
                                                                  data-bs-placement="top"
                                                                  data-bs-original-title="게시물"></i>
                                    <span class="item_follow">-</span></div>
                            </div>
                            <div class="row mb-1 item_shopping_box">
                                <label class="col-md-12"><a href="#" target="_blank" class="item_media_link text-1em"
                                                            data-bs-toggle="tooltip" data-bs-placement="top"
                                                            data-bs-original-title="쇼핑몰 링크"><i
                                        class="bi bi-cart3"></i> <span class="  item_media_link">-</span></a></label>
                            </div>
                            <div class="row">
                                <div class="col-md-12 text-end">
                                    <button class="btn btn-outline-primary item_readgo align-center"><i
                                            class="ri-information-line"></i> 상세보기
                                    </button>
                                </div>
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
                <span>인플루언서 정보가 없습니다.</span>
            </div>
        </div>
        <nav aria-label="Page navigation" id="page_box">
        </nav>
    </section>
</main>
<script>
    var keyword = "<%=keyword%>";
    var page = "<%=ppage%>";
    var status = "<%=status%>";
</script>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

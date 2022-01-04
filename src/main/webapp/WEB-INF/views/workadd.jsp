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
                <li class="breadcrumb-item">협업</li>
                <li class="breadcrumb-item active">등록</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section">
        <form id="form_editinfo" method="post" action="#">
            <div class="row work-add">
                <div class="card">
                    <h5 class="card-title"><strong>기본정보</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <label for="work_title" class="col-md-2 col-form-label">협업명</label>
                            <div class="col-md-10">
                                <input name="work_title" type="text" class="form-control"
                                       id="work_title" placeholder="협업명을 입력해주세요.">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="work_wstart" class="col-md-2 col-form-label">모집기간</label>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_wstart" name="work_wstart">
                            </div>
                            <div class="col-md-1 text-center">
                                ~
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_wend" name="work_wend">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="work_start" class="col-md-2 col-form-label">진행기간</label>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_start" name="work_start">
                            </div>
                            <div class="col-md-1 text-center">
                                ~
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_end" name="work_end">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="hashtag" class="col-md-2 col-form-label">관련 키워드</label>
                            <div class="col-md-10">
                                <input name="hashtag" type="text" class="form-control" id="hashtag" value="">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="hashtag" class="col-md-2 col-form-label">담당자 선택</label>
                            <div class="col-md-3">
                                <input name="work_name" type="text" class="form-control" id="work_name" readonly value="">
                            </div>
                            <div class="col-md-4">
                                <input name="work_company" type="text" class="form-control" id="work_company" readonly value="">
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-primary" id="work_clientsearch"><i class="bi bi-search"></i> 담당자 검색</button>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="quill-editor-full" style="min-height: 200px;">협업 내용을 입력해 주세요.</div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <h5 class="card-title"><strong>인플루언서 선택</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <label class="col-md-2 col-form-label">선택 구분</label>
                            <div class="col-md-2">
                                <input class="form-check-input" type="radio" name="work_inf_select"
                                       id="work_inf_select1" value="option1" checked>
                                <label class="form-check-label" for="work_inf_select1">
                                    Meta Console 추천
                                </label>
                            </div>
                            <div class="col-md-2">
                                <input class="form-check-input" type="radio" name="work_inf_select"
                                       id="work_inf_select2" value="option2">
                                <label class="form-check-label" for="work_inf_select2">
                                    직접선택
                                </label>
                            </div>
                            <div class="col-md-2">
                                <input class="form-check-input" type="radio" name="work_inf_select"
                                       id="work_inf_select3" value="option3">
                                <label class="form-check-label" for="work_inf_select3">
                                    인플루언서 지원
                                </label>
                            </div>
                        </div>
                        <div class="row mb-3 d-none" id="work_influencer_list">
                            <div class="card mb-3 inf_item_row">
                                <div class="row g-0">
                                    <div class="col-md-12">
                                        <div class="card-body">
                                            <div class="row">
                                                <h5 class="card-title inf_item_name col-md-3 text-1em">활동명 (성명)</h5>
                                                <span class="inf_item_tel col-md-3 card-title text-secondary text-center text-1em">010-0000-0000</span>
                                                <span class="inf_item_email col-md-3 card-title text-secondary text-center text-1em">email@email.com</span>
                                                <span class="inf_item_level col-md-2 card-title text-secondary text-center text-1em">lv1</span>
                                                <span class="item_status col-md-1 card-title text-secondary text-center text-1em"><button class="btn btn-secondary inf_item_delete"><i class="bi bi-trash"></i> 삭제</button></span>
                                            </div>
                                            <div class="row mb-1 inf_item_instagram_box">
                                                <label class="col-md-7 "><a href="#" target="_blank" class="inf_item_media_link text-1em"
                                                                            data-bs-toggle="tooltip" data-bs-placement="top"
                                                                            data-bs-original-title="인스타그램 링크"><i
                                                        class="bi bi-instagram"></i> <span
                                                        class="  inf_item_media_link">-</span></a></label>
                                                <div class="col-md-2 work_item_select">
                                                    <input type="checkbox" class="inf_item_select"> <label>선택</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="input-group mb-3">
                                                        <input type="text" class="form-control work_item_price text-end" placeholder="" aria-describedby="basic-addon2" maxlength="10">
                                                        <span class="input-group-text">원</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-1 inf_item_youtube_box">
                                                <label class="col-md-7 "><a href="#" target="_blank" class="inf_item_media_link text-1em"
                                                                            data-bs-toggle="tooltip" data-bs-placement="top"
                                                                            data-bs-original-title="유튜브 링크"><i
                                                        class="bi bi-play-btn-fill"></i> <span
                                                        class="inf_item_media_link">-</span></a></label>
                                                <div class="col-md-2 work_item_select">
                                                    <input type="checkbox" class="inf_item_select"> <label>선택</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="input-group mb-3">
                                                        <input type="text" class="form-control work_item_price text-end" placeholder="" aria-describedby="basic-addon2" maxlength="10">
                                                        <span class="input-group-text">원</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-1 inf_item_blog_box">
                                                <label class="col-md-7 "><a href="#" target="_blank" class="inf_item_media_link text-1em"
                                                                            data-bs-toggle="tooltip" data-bs-placement="top"
                                                                            data-bs-original-title="블로그 링크"><i
                                                        class="bi bi-bootstrap"></i> <span
                                                        class="  inf_item_media_link">-</span></a></label>
                                                <div class="col-md-2 work_item_select">
                                                    <input type="checkbox" class="inf_item_select"> <label>선택</label>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="input-group mb-3">
                                                        <input type="text" class="form-control work_item_price text-end" placeholder="" aria-describedby="basic-addon2" maxlength="10">
                                                        <span class="input-group-text">원</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3 text-center align-center">
                            <button type="button" class="btn btn-primary" id="work_infsearch">인플루언서 추가</button>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12 text-center" id="#work_total_price">
                                <span class="text-2em">총</span>
                                <strong><span class="text-4em" id="work_item_totalprice">0</span></strong>
                                <span class="text-2em">원</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mb-3 align-center">
                    <div class="col-md-3"></div>
                    <div class="col-md-6"><button class="btn-lg btn-primary w-100" type="submit"><i class="bi bi-clipboard-plus"></i> 협업 등록</button></div>
                    <div class="col-md-3"></div>
                </div>
            </div>
        </form>
    </section>
</main>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_searchclient.jsp"/>
<jsp:include page="inc_searchinf.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

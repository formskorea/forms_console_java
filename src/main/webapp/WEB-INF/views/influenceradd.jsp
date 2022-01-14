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
    <jsp:param name="nowmenu" value="3"/>
</jsp:include>
<main id="main" class="main">

    <div class="pagetitle">
        <h1>등록</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item">인플루언서</li>
                <li class="breadcrumb-item active">등록</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section">
        <form id="form_editinfo" method="post" action="#">
            <div class="row work-add">
                <div class="card">
                    <h5 class="card-title"><strong>회원정보</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <label for="inf_name" class="col-md-2 col-form-label">성명</label>
                            <div class="col-md-4">
                                <input name="inf_name" type="text" class="form-control"
                                       id="inf_name" placeholder="성명을 입력해주세요.">
                            </div>
                            <label for="inf_nik" class="col-md-2 col-form-label">활동명</label>
                            <div class="col-md-4">
                                <input name="inf_nik" type="text" class="form-control"
                                       id="inf_nik" placeholder="활동명을 입력해주세요.">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_email" class="col-md-2 col-form-label">이메일</label>
                            <div class="col-md-4">
                                <div class="row">
                                    <span class="col-md-8">
                                        <input name="inf_email" type="text" class="form-control "
                                               id="inf_email" placeholder="이메일을 입력해주세요.">
                                    </span>
                                    <span class="col-md-4 text-center">
                                        <button class="btn btn-primary" type="button" id="inf_email_check"><i
                                                class="bi bi-check"></i> 중복확인</button>
                                    </span>
                                </div>
                            </div>
                            <label for="inf_mobile" class="col-md-2 col-form-label">연락처</label>
                            <div class="col-md-4">
                                <input name="inf_mobile" type="text" class="form-control"
                                       id="inf_mobile" placeholder="연락처를 입력해주세요.">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_pass" class="col-md-2 col-form-label">비밀번호</label>
                            <div class="col-md-4">
                                <input name="inf_pass" type="password" class="form-control"
                                       id="inf_pass" placeholder="비밀번호를 입력해주세요.">
                            </div>
                            <label for="inf_pass2" class="col-md-2 col-form-label">비밀번호 확인</label>
                            <div class="col-md-4">
                                <input name="inf_pass2" type="password" class="form-control"
                                       id="inf_pass2" placeholder="비밀번호를 다시 입력해주세요.">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <h5 class="card-title"><strong>매체정보</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <label for="inf_media1" class="col-md-2 col-form-label">Instagram</label>
                            <div class="col-md-10">
                                <input name="inf_media1" type="text" class="form-control"
                                       id="inf_media1" placeholder="Instagram URL을 입력해주세요.">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_media2" class="col-md-2 col-form-label">Youtube</label>
                            <div class="col-md-10">
                                <input name="inf_media2" type="text" class="form-control"
                                       id="inf_media2" placeholder="Youtube URL을 입력해주세요.">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_media3" class="col-md-2 col-form-label">Blog</label>
                            <div class="col-md-10">
                                <input name="inf_media3" type="text" class="form-control"
                                       id="inf_media3" placeholder="Blog URL을 입력해주세요.">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_media4" class="col-md-2 col-form-label">Shopping mall</label>
                            <div class="col-md-10">
                                <input name="inf_media4" type="text" class="form-control"
                                       id="inf_media4" placeholder="Shopping mall URL을 입력해주세요.">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <h5 class="card-title"><strong>소속사 정보</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-10">
                                <div class="form-check-inline">
                                    <input name="inf_company_type" type="radio" class="form-check-input"
                                           id="inf_company_type1" value="1" checked>
                                    <label for="inf_company_type1" class="form-check-label">소속사 있음</label>
                                </div>
                                <div class="form-check-inline">
                                    <input name="inf_company_type" type="radio" class="form-check-input"
                                           id="inf_company_type2" value="0">
                                    <label for="inf_company_type2" class="form-check-label">소속사 없음</label>
                                </div>
                            </div>
                            <div class="col-md-2 text-end">
                                <button class="btn btn-primary" type="button" id="inf_company_searchgo"><i
                                        class="bi bi-search"></i> 소속사 검색</button>
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked">
                            <label for="inf_pass" class="col-md-2 col-form-label">소속사명</label>
                            <div class="col-md-4">
                                <input name="inf_company_name" type="text" class="form-control"
                                       id="inf_company_name" placeholder="소속사명을 입력해주세요.">
                            </div>
                            <label for="inf_pass2" class="col-md-2 col-form-label">소속사 연락처</label>
                            <div class="col-md-4">
                                <input name="inf_company_tel" type="text" class="form-control"
                                       id="inf_compnay_tel" placeholder="소속사 연락처를 입력해주세요.">
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked">
                            <label for="inf_pass" class="col-md-2 col-form-label">주소</label>
                            <div class="col-md-3">
                                <input name="inf_company_zipcode" type="text" class="form-control"
                                       id="inf_company_zipcode" disabled placeholder="우편번호">
                            </div>
                            <div class="col-md-5">
                                <input name="inf_company_address1" type="text" class="form-control"
                                       id="inf_company_address1" disabled placeholder="주소를 검색해주세요.">
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-primary" type="button" id="inf_company_addressgo"><i
                                        class="bi bi-search"></i> 주소검색</button>
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked">
                            <div class="col-md-2"></div>
                            <div class="col-md-10">
                                <input name="inf_company_address2" type="text" class="form-control"
                                       id="inf_company_address2" placeholder="상세주소를 입력해주세요.">
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked">
                            <label for="inf_company_number" class="col-md-2 col-form-label">사업자 등록번호</label>
                            <div class="col-md-4">
                                <input name="inf_company_number" type="text" class="form-control"
                                       id="inf_company_number" placeholder="사업자 등록번호를 입력해주세요.">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mb-3 align-center">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <button class="btn-lg btn-primary w-100" type="submit"><i class="bx bx-user-plus"></i> 인플루언서 등록
                        </button>
                    </div>
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

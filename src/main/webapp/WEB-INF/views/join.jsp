<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.config.DefaultConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
%>
<jsp:include page="inc_header.jsp">
    <jsp:param name="styles" value="${arrCss}"/>
</jsp:include>
<main>
    <div class="container">

        <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-6 d-flex flex-column align-items-center justify-content-center">

                        <div class="d-flex justify-content-center py-4">
                            <a href="/login" class="logo d-flex align-items-center w-auto">
                                <img src="/img/logo.png" alt="">
                                <span class="d-none d-lg-block">Meta Console</span>
                            </a>
                        </div><!-- End Logo -->

                        <div class="card mb-3">

                            <div class="card-body">

                                <div class="pt-4 pb-2">
                                    <h5 class="card-title text-center pb-0 fs-4"><strong>회원가입</strong></h5>
                                    <p class="text-center small"><strong>Meta Console</strong> 회원가입을 진행해 주세요.</p>
                                </div>

                                <form id="join_form" class="row g-3 needs-validation" novalidate>
                                    <h5>회원정보</h5>
                                    <div class="col-12 pt-2 pb-2">
                                        <div class="form-check form-check-inline mr-2">
                                            <input class="form-check-input" type="radio" name="gridRadios"
                                                   id="gridRadios1" value="<%=DefaultConfig.MEMBER_CLIENT%>" checked>
                                            <label class="form-check-label" for="gridRadios1">
                                                협력사
                                            </label>
                                        </div>
                                        <div class="form-check  form-check-inline mr-2">
                                            <input class="form-check-input" type="radio" name="gridRadios"
                                                   id="gridRadios2" value="<%=DefaultConfig.MEMBER_INFLUENCER%>">
                                            <label class="form-check-label" for="gridRadios2">
                                                인플루언서
                                            </label>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <label for="useremail" class="form-label">이메일 <i class="bi bi-check-circle text-success"></i> </label>
                                        <div class="input-group has-validation">
                                            <input type="email" name="useremail" class="form-control" id="useremail"
                                                   required>
                                            <div class="invalid-feedback">이메일을 입력해 주세요.</div>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <label for="yourPassword" class="form-label">비밀번호 <i class="bi bi-check-circle text-success"></i></label>
                                        <input type="password" name="passwword" class="form-control" id="yourPassword"
                                               required>
                                        <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
                                    </div>
                                    <div class="col-12">
                                        <label for="yourPassword2" class="form-label">비밀번호 확인 <i class="bi bi-check-circle text-success"></i></label>
                                        <input type="password" name="passwword2" class="form-control" id="yourPassword2"
                                               required>
                                        <div class="invalid-feedback">비밀번호 확인를 입력해주세요.</div>
                                    </div>
                                    <div class="col-12 mb-2">
                                        <label for="name" class="form-label">성명</label>
                                        <input type="tel" name="name" class="form-control" id="name" >
                                    </div>
                                    <div class="form_influencer d-none col-12">
                                        <label for="nikname" class="form-label">활동명</label>
                                        <input type="text" name="nikname" class="form-control" id="nikname" >
                                    </div>
                                    <div class="col-12 mb-2">
                                        <label for="mobile" class="form-label">연락처</label>
                                        <input type="tel" name="mobile" class="form-control" id="mobile" >
                                    </div>
                                    <hr/>

                                    <h5 class="form_client">회사정보</h5>
                                    <div class="form_client col-12">
                                        <label for="corpname" class="form-label">회사명</label>
                                        <input type="text" name="corpname" class="form-control" id="corpname">
                                    </div>

                                    <div class="form_client col-12">
                                        <label for="corptel" class="form-label">회사 연락처</label>
                                        <input type="tel" name="corptel" class="form-control" id="corptel">
                                        <div class="invalid-feedback">회사 연락처를 입력해주세요.</div>
                                    </div>

                                    <h5 class="form_influencer d-none">소속사 정보</h5>
                                    <div class="form_influencer d-none col-12">
                                        <label for="in_corpname" class="form-label">소속사명</label>
                                        <input type="text" name="corpname" class="form-control" id="in_corpname">
                                    </div>

                                    <div class="form_influencer d-none col-12">
                                        <label for="in_corptel" class="form-label">소속사 연락처</label>
                                        <input type="tel" name="corptel" class="form-control" id="in_corptel">
                                        <div class="invalid-feedback">회사 연락처를 입력해주세요.</div>
                                    </div>

                                    <div class="col-md-3">
                                        <label for="zipcode" class="form-label">우편번호</label>
                                        <input type="text" name="zipcode" class="form-control" id="zipcode" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="address1" class="form-label">주소</label>
                                        <input type="text" name="address1" class="form-control" id="address1" readonly>
                                    </div>
                                    <div class="col-md-3 mt-5">
                                        <button class="btn btn-outline-primary w-100" type="button" id="addr_search">
                                            주소검색
                                        </button>
                                    </div>
                                    <div class="col-12">
                                        <label for="address2" class="form-label">상세주소</label>
                                        <input type="text" name="address2" class="form-control" id="address2">
                                    </div>

                                    <div class="form_influencer d-none col-12">
                                        <label for="media_1" class="form-label"><i class="bi bi-instagram"></i>
                                            Instargram</label>
                                        <input type="text" name="media_1" class="form-control" id="media_1"
                                               placeholder="">
                                    </div>
                                    <div class="form_influencer d-none col-12">
                                        <label for="media_2" class="form-label"><i class="bi bi-youtube"></i>
                                            Youtube</label>
                                        <input type="text" name="media_2" class="form-control" id="media_2">
                                    </div>

                                    <div class="form_influencer d-none col-12">
                                        <label for="media_3" class="form-label"><i class="bi bi-bootstrap"></i>
                                            Blog</label>
                                        <input type="text" name="media_3" class="form-control" id="media_3">
                                    </div>

                                    <div class="form_influencer d-none col-12">
                                        <label for="media_4" class="form-label"><i class="bi bi-cart3"></i> Shopping
                                            mall</label>
                                        <input type="text" name="media_4" class="form-control" id="media_4">
                                    </div>

                                    <div class="col-12 mt-5">
                                        <button class="btn btn-primary w-100" type="submit">회원가입</button>
                                    </div>
                                    <div class="col-12 mb-0">
                                        <p class="small mb-2">회원가입 버튼을 클릭하면 Meta Console의 <a href="/rule?type=1" target="_blank"><strong>약관</strong></a>및 <a href="/rule?type=2" target="_blank"><strong>개인정보 보호정책</strong></a>에 동의하게 됩니다.</p>
                                        <p class="small mb-0">로그인을 원하시면 <a href="/login"><strong>이곳</strong></a>을
                                            클릭해주세요.</p>
                                        <p class="small">회원정보를 찾으시려면 <a href="/find"><strong>이곳</strong></a>을
                                            클릭해주세요.</p>
                                    </div>
                                </form>

                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </section>

    </div>
</main>
<!-- End #main -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
        class="bi bi-arrow-up-short"></i></a>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>
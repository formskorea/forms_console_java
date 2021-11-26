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
                    <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

                        <div class="d-flex justify-content-center py-4">
                            <a href="/login" class="logo d-flex align-items-center w-auto">
                                <img src="/img/logo.png" alt="">
                                <span class="d-none d-lg-block">Meta Console</span>
                            </a>
                        </div><!-- End Logo -->

                        <div class="card mb-3">

                            <div class="card-body">

                                <div class="pt-4 pb-2">
                                    <h5 class="card-title text-center pb-0 fs-4"><strong>회원 로그인</strong></h5>
                                    <p class="text-center small">이메일과 비밀번호를 입력해 주세요.</p>
                                </div>

                                <form id="login_form" class="row g-3 needs-validation" novalidate>

                                    <div class="col-12 pt-2 pb-2">
                                        <label for="gridRadios1" class="form-label">회원구분</label><br />
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
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="gridRadios"
                                                   id="gridRadios3" value="<%=DefaultConfig.MEMBER_ADMIN%>">
                                            <label class="form-check-label" for="gridRadios3">
                                                폼즈직원
                                            </label>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <label for="useremail" class="form-label">이메일</label>
                                        <div class="input-group has-validation">
                                            <input type="email" name="useremail" class="form-control" id="useremail"
                                                   required>
                                            <div class="invalid-feedback">이메일을 입력해 주세요.</div>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <label for="yourPassword" class="form-label">비밀번호</label>
                                        <input type="password" name="passwword" class="form-control" id="yourPassword"
                                               required>
                                        <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
                                    </div>

                                    <div class="col-12">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="remember" value="true"
                                                   id="rememberMe">
                                            <label class="form-check-label" for="rememberMe">로그인 기억하기</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <button class="btn btn-primary w-100" type="submit">로그인</button>
                                    </div>
                                    <div class="col-12 mb-0">
                                        <p class="small mb-0">회원가입을 원하시면 <a href="/join"><strong>이곳</strong></a>을
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
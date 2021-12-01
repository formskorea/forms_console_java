<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.config.DefaultConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
    String email = (String) request.getAttribute("email");
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
                        <div class="card mb-3 col-12">
                            <div class="card-body">
                                <div class="pt-4 pb-2">
                                    <h5 class="card-title text-center pb-0 fs-4"><strong>회원정보 찾기완료</strong></h5>
                                    <p class="text-center small"><strong>Meta Console</strong>에서 회원 정보를 찾았습니다.</p>
                                </div>
                                <h5>정보찾기 안내</h5>
                                <div class="col-12 pt-2 pb-2">
                                    <ul>
                                        <li>Meta Console에서 <%=email%>로 가입된 정보를 찾았습니다.</li>
                                        <li>가입시 등록한 이메일로 임시비밀번호가 발급되었습니다.</li>
                                        <li>비밀번호는 로그인 후 내정보에서 수정가능합니다.</li>
                                    </ul>
                                </div>
                                <h5>약관 및 가입정책</h5>
                                <ul>
                                    <li><a href="/rule?type=1" target="_blank"><strong>회원 약관 보기</strong></a></li>
                                    <li><a href="/rule?type=2" target="_blank"><strong>데이터 정책 보기</strong></a></li>
                                    <li><a href="/rule?type=2" target="_blank"><strong>쿠키 정책 보기</strong></a></li>
                                </ul>
                                <div class="col-12">
                                    <a href="/login"><button class="btn btn-outline-primary w-100" type="button">로그인으로 이동</button></a>
                                </div>
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
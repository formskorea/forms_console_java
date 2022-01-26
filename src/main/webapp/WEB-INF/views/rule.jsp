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
                                    <h5 class="card-title text-center pb-0 fs-4"><strong>이용약관</strong></h5>
                                    <p class="text-center small">
                                        
                                    </p>
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
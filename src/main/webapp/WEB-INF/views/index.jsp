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
        <h1>Blank Page</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                <li class="breadcrumb-item">Pages</li>
                <li class="breadcrumb-item active">Blank</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section">
        <div class="row">
            <div class="col-lg-6">

                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Example Card</h5>
                        <p>This is an examle page with no contrnt. You can use it as a starter for your custom
                            pages.</p>
                    </div>
                </div>

            </div>

            <div class="col-lg-6">

                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Example Card</h5>
                        <p>This is an examle page with no contrnt. You can use it as a starter for your custom
                            pages.</p>
                    </div>
                </div>

            </div>
        </div>
    </section>

</main>
<!-- End #main -->
<jsp:include page="inc_footer.jsp" />
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

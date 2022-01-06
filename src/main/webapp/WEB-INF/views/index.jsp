<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.data.model.User" %>
<%@ page import="com.formskorea.console.config.DefaultConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
    User userinfo = (User) request.getAttribute("fmcuser");
    String pages = "";
    if(userinfo.getStrMemberType() != "") {
        switch (userinfo.getStrMemberType()) {
            case DefaultConfig.MEMBER_CLIENT:
                pages = "inc_dh_client.jsp";
                break;
            case DefaultConfig.MEMBER_ADMIN:
                pages = "inc_dh_admin.jsp";
                break;
            default:
                pages = "inc_dh_influencer.jsp";
                break;
        }
    }
%>
<jsp:include page="inc_header.jsp">
    <jsp:param name="styles" value="${arrCss}"/>
</jsp:include>
<jsp:include page="inc_menu.jsp">
    <jsp:param name="fmcuser" value="${userinfo}"/>
    <jsp:param name="nowmenu" value="1"/>
</jsp:include>
<main id="main" class="main">

    <div class="pagetitle">
        <h1>대시보드</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                <li class="breadcrumb-item active">대시보드</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section dashboard">
        <jsp:include page="<%=pages%>" />
    </section>

</main>
<!-- End #main -->
<jsp:include page="inc_footer.jsp" />
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

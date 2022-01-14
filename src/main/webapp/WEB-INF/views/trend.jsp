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
    <jsp:param name="nowmenu" value="2"/>
</jsp:include>
<main id="main" class="main">

    <div class="pagetitle">
        <h1>트랜드 분석</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item active">트랜드 분석</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section">
        <div class="row align-center">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><strong>네이버 트랜드</strong> <span>| 분류별</span></h5>
                        <div class="row mt-md-3 mb-md-3">
                            <div class="col-md-4">
                                <input type="date" class="form-control text-0-8em" id="trand1_date" name="trand1_date">
                            </div>
                            <div class="col-md-5">
                                <select class="form-control text-0-8em" name="trand1_category" id="trand1_category">
                                    <option value="요리·레시피">요리·레시피</option>
                                    <option value="IT·컴퓨터">IT·컴퓨터</option>
                                    <option value="패션·미용">패션·미용</option>
                                    <option value="비즈니스·경제" selected>비즈니스·경제</option>
                                    <option value="영화">영화</option>
                                    <option value="게임">게임</option>
                                    <option value="국내여행">국내여행</option>
                                    <option value="세계여행">세계여행</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-primary text-0-8em w-100" id="trand1_search"><i class="bi bi-search"></i>검색</button>
                            </div>
                        </div>
                        <div class="row">
                            <ol class="list-group list-group-numbered" id="admin_dh_ntrend_list">
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><strong>네이버 트랜드</strong> <span>| 성별</span></h5>
                        <div class="row mt-md-3 mb-md-3">
                            <div class="col-md-4">
                                <input type="date" class="form-control text-0-8em" id="trand2_date" name="trand2_date">
                            </div>
                            <div class="col-md-2">
                                <select class="form-control text-0-8em" name="trand2_sex" id="trand2_sex">
                                    <option value="9" selected>전체</option>
                                    <option value="1">남자</option>
                                    <option value="2">여자</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select class="form-control text-0-8em" name="trand2_category" id="trand2_category">
                                    <option value="0-12세">0-12세</option>
                                    <option value="13-18세">13-18세</option>
                                    <option value="19-24세">19-24세</option>
                                    <option value="25-29세" selected>25-29세</option>
                                    <option value="30-34세">30-34세</option>
                                    <option value="35-39세">35-39세</option>
                                    <option value="40-44세">40-44세</option>
                                    <option value="45-49세">45-49세</option>
                                    <option value="50-54세">50-54세</option>
                                    <option value="55-59세">55-59세</option>
                                    <option value="60세-">60세-</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-primary text-0-8em w-100" id="trand2_search"><i class="bi bi-search"></i>검색</button>
                            </div>
                        </div>
                        <div class="row">
                            <ol class="list-group list-group-numbered" id="admin_dh_n2trend_list">
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title"><strong>구글 트랜드</strong> <span>| 어제</span></h5>
                        <div class="row mt-md-3 mb-md-3">
                            <div class="col-md-4">
                                <input type="date" class="form-control text-0-8em" id="trand3_date" name="trand1_date">
                            </div>
                            <div class="col-md-5"></div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-primary text-0-8em w-100" id="trand3_search"><i class="bi bi-search"></i>검색</button>
                            </div>
                        </div>
                        <div class="row">
                            <ol class="list-group list-group-numbered" id="admin_dh_gtrend_list">
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                                <li class="list-group-item text-0-8em"></li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

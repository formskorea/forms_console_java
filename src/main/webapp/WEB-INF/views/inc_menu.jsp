<%@ page import="com.formskorea.console.data.model.User" %>
<%@ page import="com.formskorea.console.config.DefaultConfig" %>
<%@ page import="org.json.JSONObject" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    User userinfo = (User) request.getAttribute("fmcuser");

    JSONObject permJson = new JSONObject();
    String permission = userinfo.getTxtPermission();
    if (!permission.equals("")) {
        permJson = new JSONObject(permission);
    }
    Boolean isInfluencer = false;
    Boolean isCient = false;
    Boolean isWork = false;
    Boolean isSetting = false;
    Boolean isTrand = false;
    Boolean isSuper = userinfo.getIntSuper() == 1;
    String memberType = "";

    switch (userinfo.getStrMemberType()) {
        case DefaultConfig.MEMBER_ADMIN:
            memberType = "관리자";
            if (isSuper || (!permJson.isNull(DefaultConfig.PERM_INFLUENCER_READ) && permJson.getBoolean(DefaultConfig.PERM_INFLUENCER_READ))) {
                isInfluencer = true;
            }
            if (isSuper || (!permJson.isNull(DefaultConfig.PERM_CLIENT_READ) && permJson.getBoolean(DefaultConfig.PERM_CLIENT_READ))) {
                isCient = true;
            }
            if (isSuper || (!permJson.isNull(DefaultConfig.PERM_WORK_READ) && permJson.getBoolean(DefaultConfig.PERM_WORK_READ))) {
                isWork = true;
            }
            isSetting = true;
            isTrand = true;
            break;
        case DefaultConfig.MEMBER_CLIENT:
            memberType = "고객사";
            if (isSuper || (!permJson.isNull(DefaultConfig.PERM_INFLUENCER_READ) && permJson.getBoolean(DefaultConfig.PERM_INFLUENCER_READ))) {
                isInfluencer = true;
            }
            if (isSuper || (!permJson.isNull(DefaultConfig.PERM_CLIENT_READ) && permJson.getBoolean(DefaultConfig.PERM_CLIENT_READ))) {
                isCient = true;
            }
            if (isSuper || (!permJson.isNull(DefaultConfig.PERM_WORK_READ) && permJson.getBoolean(DefaultConfig.PERM_WORK_READ))) {
                isWork = true;
            }
        default:
            memberType = "인플루언서";

            if (isSuper || (!permJson.isNull(DefaultConfig.PERM_INFLUENCER_READ) && permJson.getBoolean(DefaultConfig.PERM_INFLUENCER_READ))) {
                isInfluencer = true;
            }
            if (isSuper || (!permJson.isNull(DefaultConfig.PERM_CLIENT_READ) && permJson.getBoolean(DefaultConfig.PERM_CLIENT_READ))) {
                isCient = true;
            }
            if (isSuper || (!permJson.isNull(DefaultConfig.PERM_WORK_READ) && permJson.getBoolean(DefaultConfig.PERM_WORK_READ))) {
                isWork = true;
            }
    }
%>
<!-- ======= Header ======= -->
<header id="header" class="header fixed-top d-flex align-items-center">
    <div class="d-flex align-items-center justify-content-between">
        <a href="/" class="logo d-flex align-items-center">
            <img src="/img/logo.png" alt="">
            <span class="d-none d-lg-block">Meta Console</span>
        </a>
        <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

            <li class="nav-item d-block d-lg-none">
                <a class="nav-link nav-icon search-bar-toggle " href="#">
                    <i class="bi bi-search"></i>
                </a>
            </li>

            <li class="nav-item dropdown">

                <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-bell"></i>
                    <span class="badge bg-primary badge-number" id="main_alert_count">4</span>
                </a><!-- End Notification Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
                    <li class="dropdown-header">
                        You have 4 new notifications
                        <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="notification-item">
                        <i class="bi bi-exclamation-circle text-warning"></i>
                        <div>
                            <h4>Lorem Ipsum</h4>
                            <p>Quae dolorem earum veritatis oditseno</p>
                            <p>30 min. ago</p>
                        </div>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="dropdown-footer">
                        <a href="#">Show all notifications</a>
                    </li>

                </ul><!-- End Notification Dropdown Items -->

            </li><!-- End Notification Nav -->

            <li class="nav-item dropdown">

                <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                    <i class="bi bi-chat-left-text"></i>
                    <span class="badge bg-danger badge-number" id="main_noti_count">3</span>
                </a><!-- End Messages Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow messages">
                    <li class="dropdown-header">
                        You have 3 new messages
                        <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="message-item">
                        <a href="#">
                            <img src="/img/messages-1.jpg" alt="" class="rounded-circle">
                            <div>
                                <h4>Maria Hudson</h4>
                                <p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
                                <p>4 hrs. ago</p>
                            </div>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="dropdown-footer">
                        <a href="#">Show all messages</a>
                    </li>

                </ul><!-- End Messages Dropdown Items -->

            </li><!-- End Messages Nav -->

            <li class="nav-item dropdown pe-3">

                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    <img src="/img/ic_user.svg" alt="Profile" class="rounded-circle">
                    <span class="d-none d-md-block dropdown-toggle ps-2"><%=userinfo.getStrNikname()%></span>
                </a><!-- End Profile Iamge Icon -->

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                    <li class="dropdown-header">
                        <h6><%=userinfo.getStrNikname()%>
                        </h6>
                        <span><%=memberType%> Lv.<%=userinfo.getIntLevel()%></span>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="/profile">
                            <i class="bi bi-person"></i>
                            <span>내 정보</span>
                        </a>
                    </li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li>
                        <a class="dropdown-item d-flex align-items-center" href="/logout">
                            <i class="bi bi-box-arrow-right"></i>
                            <span>로그아웃</span>
                        </a>
                    </li>

                </ul><!-- End Profile Dropdown Items -->
            </li><!-- End Profile Nav -->

        </ul>
    </nav><!-- End Icons Navigation -->

</header>
<!-- End Header -->

<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">
        <li class="nav-item">
            <a class="nav-link" href="/">
                <i class="bi bi-grid"></i>
                <span>대시보드</span>
            </a>
        </li><!-- End Dashboard Nav -->
        <% if(isTrand) { %>
        <li class="nav-item">
            <a class="nav-link" href="/trend">
                <i class="bi bi-clipboard-data"></i>
                <span>트랜드 분석</span>
            </a>
        </li>
        <% } %>
        <% if (isInfluencer) { %>
        <li class="nav-item">
            <a class="nav-link" href="/influencer/list">
                <i class="bi bi-instagram"></i>
                <span>인플루언서</span>
            </a>
        </li>
        <% } %>
        <% if (isCient) { %>
        <li class="nav-item">
            <a class="nav-link" href="/client/list">
                <i class="bi bi-building"></i>
                <span>협력사</span>
            </a>
        </li>
        <% } %>
        <% if (isWork) { %>
        <li class="nav-item">
            <a class="nav-link" href="/work/list">
                <i class="bi bi-journal-check"></i>
                <span>협업</span>
            </a>
        </li>
        <% } %>
        <% if (isSetting) { %>
        <li class="nav-item">
            <a class="nav-link" href="/setting">
                <i class="bi bi-gear"></i>
                <span>사이트 셋팅</span>
            </a>
        </li>
        <% } %>
    </ul>

</aside>
<!-- End Sidebar-->
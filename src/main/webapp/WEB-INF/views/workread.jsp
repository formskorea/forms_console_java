<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.data.model.User" %>
<%@ page import="com.formskorea.console.data.model.Work" %>
<%@ page import="com.formskorea.console.data.model.WorkInfo" %>
<%@ page import="com.formskorea.console.data.model.Tag" %>
<%@ page import="com.formskorea.console.util.Etc" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
    User userinfo = (User) request.getAttribute("fmcuser");
    Integer workseq = (Integer) request.getAttribute("workseq");
    Work work = (Work) request.getAttribute("work");

    String keyword = (String) request.getAttribute("keyword");
    String ppage = (String) request.getAttribute("page");
    String status = (String) request.getAttribute("status");

    Integer[] mediacount = new Integer[4];
    mediacount[0] = 0;
    mediacount[1] = 0;
    mediacount[2] = 0;
    mediacount[3] = 0;

    ArrayList<WorkInfo> mediauser1 = new ArrayList<>();
    ArrayList<WorkInfo> mediauser2 = new ArrayList<>();
    ArrayList<WorkInfo> mediauser3 = new ArrayList<>();

    for (Integer i = 0; i < work.getInfos().size(); i++) {
        WorkInfo winfo = work.getInfos().get(i);
        if (winfo.getIntMediaType() > 0) {
            mediacount[winfo.getIntMediaType()]++;

            switch (winfo.getIntMediaType()) {
                case 1:
                    mediauser1.add(winfo);
                    break;
                case 2:
                    mediauser2.add(winfo);
                    break;
                case 3:
                    mediauser3.add(winfo);
                    break;
            }
        }
    }

    String status_span = "";
    String day_span = "";
    String day_span1 = work.getDateReadystart() + " ~ " + work.getDateReadyend();
    String day_span2 = work.getDateStart() + " ~ " + work.getDateEnd();

    switch (work.getIntStatus()) {
        case 0:
            status_span = "<span class=\"badge bg-secondary text-light\">모집</span>";
            day_span = day_span1;
            break;
        case 1:
            status_span = "<span class=\"badge bg-success text-light\">진행</span>";
            day_span = day_span2;
            break;
        case 7:
            status_span = "<span class=\"badge bg-warning text-light\">완료</span>";
            day_span = day_span2;
            break;
        case 5:
            status_span = "<span class=\"badge bg-dark text-light\">대기</span>";
            day_span = day_span2;
            break;
        default:
            status_span = "<span class=\"badge bg-danger text-light\">취소</span>";
            day_span = day_span2;
            break;
    }

    String tags = "";
    if (work.getTags() != null && work.getTags().size() > 0) {
        for (Integer i = 0; i < work.getTags().size(); i++) {
            Tag field = work.getTags().get(i);
            tags += (i != 0 ? ", " : "") + "#" + field.getStrTag();
        }
    }

    String comAddress = "";
    if (work.getCompany().getStrAddress() != null && !work.getCompany().getStrAddress().isBlank()) {
        comAddress = "(" + work.getCompany().getStrZipcode() + ") " + work.getCompany().getStrAddress().replace("|", " ");
    }

    Date defDEnd = new Date();
    Date defCutEnd = Etc.INSTANCE.setStringtoDate(work.getDateEnd(), "yyyy-MM-dd");
    Date defCutStart = Etc.INSTANCE.setStringtoDate(work.getDateStart(), "yyyy-mm-dd");

    if(defDEnd.getTime() > defCutEnd.getTime()) {
        defDEnd = defCutEnd;
    }

    Date defDStart = Etc.INSTANCE.setDateAdd(Calendar.DAY_OF_MONTH, -6, defDEnd);

    if(defDStart.getTime() < defCutStart.getTime()) {
        defDStart = defCutStart;
    }

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
                <li class="breadcrumb-item active">No. <%=workseq%>
                </li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section">
        <div class="card mb-md-3">
            <div class="card-body pt-3 row">
                <span class="col-lg-5"><%=work.getStrTitle()%></span>
                <span class="col-lg-3 text-center"><%=day_span%></span>
                <span class="col-lg-3 text-center">
                    <span><i class="bi bi-instagram"></i> <%=mediacount[1]%></span>&nbsp;/&nbsp;
                    <span><i class="bi bi bi-play-btn-fill"></i>  <%=mediacount[2]%></span>&nbsp;/&nbsp;
                    <span><i class="bi bi-bootstrap"></i>  <%=mediacount[3]%></span>
                </span>
                <span class="col-lg-1 text-center"><%=status_span%></span>
            </div>
        </div>
        <div class="card mb-md-3">
            <div class="card-body">
                <!-- Default Tabs -->
                <ul class="nav nav-tabs mt-md-3 mb-md-3" id="myTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home"
                                type="button" role="tab" aria-controls="home" aria-selected="true">협업내용
                        </button>
                    </li>
                    <% if (mediacount[1] > 0) { %>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="instagram-tab" data-bs-toggle="tab" data-bs-target="#instagram"
                                type="button" role="tab" aria-controls="profile" aria-selected="false"/>
                        인스타그램</button>
                    </li>
                    <% } %>
                    <% if (mediacount[2] > 0) { %>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="youtube-tab" data-bs-toggle="tab" data-bs-target="#youtube"
                                type="button" role="tab" aria-controls="contact" aria-selected="false">유튜브
                        </button>
                    </li>
                    <% } %>
                    <% if (mediacount[3] > 0) { %>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="blog-tab" data-bs-toggle="tab" data-bs-target="#blog"
                                type="button" role="tab" aria-controls="contact" aria-selected="false">블로그
                        </button>
                    </li>
                    <% } %>
                </ul>
                <div class="tab-content pt-2" id="myTabContent">
                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <h5 class="card-title"><strong>기본정보</strong></h5>
                        <div class="row mb-lg-3">
                            <span class="col-md-2"><strong>모집기간</strong></span>
                            <span class="col-md-4 text-secondary"><%=day_span1%></span>
                            <span class="col-md-2"><strong>진행기간</strong></span>
                            <span class="col-md-4 text-secondary"><%=day_span2%></span>
                        </div>
                        <div class="row mb-lg-3">
                            <span class="col-md-2"><strong>관련 키워드</strong></span>
                            <span class="col-md-10 text-secondary"><%=tags%></span>
                        </div>
                        <div class="row mb-lg-1">
                            <span class="col-md-2"><strong>협업 내용</strong></span>
                        </div>
                        <div class="row mb-lg-3 p-md-2">
                            <div id="workread_info" class="col-md-12">
                                <%=work.getTxtInfo()%>
                            </div>
                        </div>
                        <hr/>
                        <h5 class="card-title"><strong>담당자 정보</strong></h5>
                        <div class="row mb-lg-3">
                            <span class="col-md-2"><strong>회사명</strong></span>
                            <span class="col-md-4 text-secondary"><%=work.getCompany().getStrCompanyname()%></span>
                            <span class="col-md-2"><strong>회사 연락처</strong></span>
                            <span class="col-md-4 text-secondary"><%=work.getCompany().getStrTelnum()%></span>
                        </div>
                        <div class="row mb-lg-3">
                            <span class="col-md-2"><strong>주소</strong></span>
                            <span class="col-md-10 text-secondary"><%=comAddress%></span>
                        </div>
                        <div class="row mb-lg-3">
                            <span class="col-md-2"><strong>담당자명</strong></span>
                            <span class="col-md-4 text-secondary"><%=work.getClient().getStrName()%></span>
                            <span class="col-md-2"><strong>레벨</strong></span>
                            <span class="col-md-4 text-secondary">lv<%=work.getClient().getIntLevel()%></span>
                        </div>
                        <div class="row mb-lg-3">
                            <span class="col-md-2"><strong>연락처</strong></span>
                            <span class="col-md-4 text-secondary"><%=work.getClient().getStrMobile()%></span>
                            <span class="col-md-2"><strong>이메일</strong></span>
                            <span class="col-md-4 text-secondary"><%=work.getClient().getStrEmail()%></span>
                        </div>
                        <hr/>
                        <h5 class="card-title"><strong>인플루언서 정보</strong></h5>
                        <ul class="list-group mb-md-5">
                            <li class="list-group-item list-group-item-primary">
                                <div class="row">
                                    <span class="col-md-1 text-center text-0-9em pt-md-2"><strong>순번</strong></span>
                                    <span class="col-md-1 text-center text-0-9em pt-md-2"><strong>성명(활동명)</strong></span>
                                    <span class="col-md-2 text-center text-0-9em pt-md-2"><strong>연락처</strong></span>
                                    <span class="col-md-2 text-center text-0-9em pt-md-2"><strong>이메일</strong></span>
                                    <span class="col-md-1 text-center text-0-9em pt-md-2"><strong>매체</strong></span>
                                    <span class="col-md-2 text-center text-0-9em pt-md-2"><strong>URL</strong></span>
                                    <span class="col-md-1 text-center text-0-9em pt-md-2"><strong>금액</strong></span>
                                    <span class="col-md-1 text-center text-0-9em"><strong>협력사<br/>승인</strong></span>
                                    <span class="col-md-1 text-center text-0-9em"><strong>인플루언서<br/>승인</strong></span>
                                </div>
                            </li>
                            <% for (Integer i = 0; i < work.getInfos().size(); i++) {
                                WorkInfo field = work.getInfos().get(i);
                                String cstatus = "";
                                String istatus = "";
                                String mediatype = "";
                                switch (field.getIntClientStatus()) {
                                    case 1:
                                        cstatus = "승인";
                                        break;
                                    case 5:
                                        cstatus = "보류";
                                        break;
                                    default:
                                        cstatus = "요청";
                                        break;
                                }
                                switch (field.getIntUserStatus()) {
                                    case 1:
                                        istatus = "승인";
                                        break;
                                    case 5:
                                        istatus = "보류";
                                        break;
                                    case 9:
                                        istatus = "취소";
                                        break;
                                    default:
                                        istatus = "요청";
                                        break;
                                }
                                switch (field.getIntMediaType()) {
                                    case 1:
                                        mediatype = "인스타그램";
                                        break;
                                    case 2:
                                        mediatype = "유튜브";
                                        break;
                                    default:
                                        mediatype = "블로그";
                                        break;
                                }
                            %>
                            <li class="list-group-item">
                                <div class="row">
                                    <span class="col-md-1 text-center text-0-9em"><%=(i + 1)%>.</span>
                                    <span class="col-md-1 text-center text-0-9em"><%=field.getInfluencer().getStrName()%><br/>(<%=field.getInfluencer().getStrNikname()%>)</span>
                                    <span class="col-md-2 text-center text-0-9em"><%=field.getInfluencer().getStrMobile()%></span>
                                    <span class="col-md-2 text-center text-0-9em"><%=field.getInfluencer().getStrEmail()%></span>
                                    <span class="col-md-1 text-center text-0-9em"><%=mediatype%></span>
                                    <span class="col-md-2 text-center text-0-9em"><a href="<%=field.getStrURL()%>"
                                                                                     target="_blank"><%=(field.getStrURL() != null ? field.getStrURL() : "")%></a> </span>
                                    <span class="col-md-1 text-center text-0-9em"><%=Etc.INSTANCE.setComma(field.getIntPrice())%>원</span>
                                    <span class="col-md-1 text-center text-0-9em"><%=cstatus%></span>
                                    <span class="col-md-1 text-center text-0-9em"><%=istatus%></span>
                                </div>
                            </li>
                            <% } %>
                        </ul>
                        <div class="text-center mb-md-5">
                            <button class="btn-lg btn-primary" type="button" id="work_editgo"><i
                                    class="bi bi-file-earmark-code"></i> 수정하기
                            </button>
                            <button class="btn-lg btn-outline-primary ms-3" type="button" id="work_listgo">목록으로</button>
                        </div>
                    </div>
                    <% if (mediacount[1] > 0) { %>
                    <div class="tab-pane fade" id="instagram" role="tabpanel" aria-labelledby="profile-tab">
                        <div class="row mb-md-3">
                            <div class="col-md-1">
                                <select class="form-select" id="work_i_select">
                                    <option value="1" selected="selected">일별</option>
                                    <option value="2">월별</option>
                                    <option value="3">년별</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="work_i_userselect">
                                    <option value="" selected="selected">전체</option>
                                    <%
                                        if (mediauser1.size() > 0) {
                                            for (int i = 0; i < mediauser1.size(); i++) {
                                                WorkInfo workInfo = (WorkInfo) mediauser1.get(i);
                                    %>
                                    <option value="<%=workInfo.getInfluencer().getIntSeq()%>"><%=workInfo.getInfluencer().getStrName()%></option>
                                    <% }
                                    } %>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_i_start" name="work_i_start" value="<%=Etc.INSTANCE.setDatetoString(defDStart, "yyyy-MM-dd")%>">
                            </div>
                            <div class="col-md-1 text-center align-middle">
                                ~
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_i_end" name="work_i_end" value="<%=Etc.INSTANCE.setDatetoString(defDEnd, "yyyy-MM-dd")%>">
                            </div>
                            <div class="col-md-2 text-center">
                                <button type="button" class="btn btn-primary" id="work_i_search"><i
                                        class="bi bi-search"></i> 기간검색
                                </button>
                            </div>
                        </div>
                        <div id="instagram_chart" class="mb-md-3"
                             style="width: 100%; min-height: 100px; max-height: 400px;"></div>
                        <div class="row pb-0">
                            <table class="table work-table" id="work_i_list">
                                <thead>
                                <tr>
                                    <th scope="col" width="25%" class="text-center table-primary">날짜</th>
                                    <th scope="col" width="15%" class="text-center table-primary">좋아요</th>
                                    <th scope="col" width="15%" class="text-center table-primary">댓글</th>
                                    <th scope="col" width="15%" class="text-center table-primary">게시물</th>
                                    <th scope="col" width="15%" class="text-center table-primary">팔로워</th>
                                    <th scope="col" width="15%" class="text-center table-primary">팔로우</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="work_i_body">
                                    <th scope="row" class="work_i_date text-center">2022-01-01</th>
                                    <td class="work_i_count1 text-end">0</td>
                                    <td class="work_i_count2 text-end">0</td>
                                    <td class="work_i_count3 text-end">0</td>
                                    <td class="work_i_count4 text-end">0</td>
                                    <td class="work_i_count5 text-end">0</td>
                                </tr>
                                <tr class="work_i_loading">
                                    <td colspan="6">
                                        <div class="row g-0 mb-3">
                                            <div class="loader col-md-12 text-center">Loading...</div>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="work_i_list_empty">
                                    <td colspan="6">
                                        <div class="text-center">
                                            <i class="bi bi-trash2" style="font-size: 6em;"></i><br/>
                                            <span>인스타그램 누적 Log가 없습니다.</span>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <% } %>
                    <% if (mediacount[2] > 0) { %>
                    <div class="tab-pane fade" id="youtube" role="tabpanel" aria-labelledby="profile-tab">
                        <div class="row mb-md-3">
                            <div class="col-md-1">
                                <select class="form-select" id="work_y_select">
                                    <option value="1" selected="selected">일별</option>
                                    <option value="2">월별</option>
                                    <option value="3">년별</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="work_y_userselect">
                                    <option value="" selected="selected">전체</option>
                                    <%
                                        if (mediauser2.size() > 0) {
                                            for (int i = 0; i < mediauser2.size(); i++) {
                                                WorkInfo workInfo = (WorkInfo) mediauser2.get(i);
                                    %>
                                    <option value="<%=workInfo.getInfluencer().getIntSeq()%>"><%=workInfo.getInfluencer().getStrName()%></option>
                                    <% }
                                    } %>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_y_start" name="work_y_start" value="<%=Etc.INSTANCE.setDatetoString(defDStart, "yyyy-MM-dd")%>">
                            </div>
                            <div class="col-md-1 text-center align-middle">
                                ~
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_y_end" name="work_y_end" value="<%=Etc.INSTANCE.setDatetoString(defDEnd, "yyyy-MM-dd")%>">
                            </div>
                            <div class="col-md-2 text-center">
                                <button type="button" class="btn btn-primary" id="work_y_search"><i
                                        class="bi bi-search"></i> 기간검색
                                </button>
                            </div>
                        </div>
                        <div id="youtube_chart" class="mb-md-3"
                             style="width: 100%; min-height: 100px; max-height: 400px;"></div>
                        <div class="row pb-0">
                            <table class="table work-table" id="work_y_list">
                                <thead>
                                <tr>
                                    <th scope="col" width="25%" class="text-center table-primary">날짜</th>
                                    <th scope="col" width="15%" class="text-center table-primary">재생수</th>
                                    <th scope="col" width="15%" class="text-center table-primary">댓글</th>
                                    <th scope="col" width="15%" class="text-center table-primary">좋아요</th>
                                    <th scope="col" width="15%" class="text-center table-primary">총조회수</th>
                                    <th scope="col" width="15%" class="text-center table-primary">총동영상수</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="work_y_body">
                                    <th scope="row" class="work_y_date text-center">2022-01-01</th>
                                    <td class="work_y_count1 text-end">0</td>
                                    <td class="work_y_count2 text-end">0</td>
                                    <td class="work_y_count3 text-end">0</td>
                                    <td class="work_y_count4 text-end">0</td>
                                    <td class="work_y_count5 text-end">0</td>
                                </tr>
                                <tr class="work_y_loading">
                                    <td colspan="6">
                                        <div class="row g-0 mb-3">
                                            <div class="loader col-md-12 text-center">Loading...</div>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="work_y_list_empty">
                                    <td colspan="6">
                                        <div class="text-center">
                                            <i class="bi bi-trash2" style="font-size: 6em;"></i><br/>
                                            <span>유튜브 누적 Log가 없습니다.</span>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <% } %>
                    <% if (mediacount[3] > 0) { %>
                    <div class="tab-pane fade" id="blog" role="tabpanel" aria-labelledby="contact-tab">
                        <div class="row mb-md-3">
                            <div class="col-md-1">
                                <select class="form-select" id="work_b_select">
                                    <option value="1" selected="selected">일별</option>
                                    <option value="2">월별</option>
                                    <option value="3">년별</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="work_b_userselect">
                                    <option value="" selected="selected">전체</option>
                                    <%
                                        if (mediauser3.size() > 0) {
                                            for (int i = 0; i < mediauser3.size(); i++) {
                                                WorkInfo workInfo = (WorkInfo) mediauser3.get(i);
                                    %>
                                    <option value="<%=workInfo.getInfluencer().getIntSeq()%>"><%=workInfo.getInfluencer().getStrName()%></option>
                                    <% }
                                    } %>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_b_start" name="work_b_start" value="<%=Etc.INSTANCE.setDatetoString(defDStart, "yyyy-MM-dd")%>">
                            </div>
                            <div class="col-md-1 text-center align-middle">
                                ~
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_b_end" name="work_b_end" value="<%=Etc.INSTANCE.setDatetoString(defDEnd, "yyyy-MM-dd")%>">
                            </div>
                            <div class="col-md-2 text-center">
                                <button type="button" class="btn btn-primary" id="work_b_search"><i
                                        class="bi bi-search"></i> 기간검색
                                </button>
                            </div>
                        </div>
                        <div id="blog_chart" class="mb-md-3"
                             style="width: 100%; min-height: 100px; max-height: 400px;"></div>
                        <div class="row pb-0">
                            <table class="table work-table" id="work_b_list">
                                <thead>
                                <tr>
                                    <th scope="col" width="25%" class="text-center table-primary">날짜</th>
                                    <th scope="col" width="15%" class="text-center table-primary">공감</th>
                                    <th scope="col" width="15%" class="text-center table-primary">댓글</th>
                                    <th scope="col" width="15%" class="text-center table-primary">게시물</th>
                                    <th scope="col" width="15%" class="text-center table-primary">오늘방문수</th>
                                    <th scope="col" width="15%" class="text-center table-primary">총방문수</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="work_b_body">
                                    <th scope="row" class="work_b_date text-center">2022-01-01</th>
                                    <td class="work_b_count1 text-end">0</td>
                                    <td class="work_b_count2 text-end">0</td>
                                    <td class="work_b_count3 text-end">0</td>
                                    <td class="work_b_count4 text-end">0</td>
                                    <td class="work_b_count5 text-end">0</td>
                                </tr>
                                <tr class="work_b_loading">
                                    <td colspan="6">
                                        <div class="row g-0 mb-3">
                                            <div class="loader col-md-12 text-center">Loading...</div>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="work_b_list_empty">
                                    <td colspan="6">
                                        <div class="text-center">
                                            <i class="bi bi-trash2" style="font-size: 6em;"></i><br/>
                                            <span>블로그 누적 Log가 없습니다.</span>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <% } %>
                </div><!-- End Default Tabs -->
            </div>
        </div>
    </section>
</main>
<script>
    var workno = <%=workseq%>;
    var keyword = "<%=keyword%>";
    var page = "<%=ppage%>";
    var status = "<%=status%>";
</script>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

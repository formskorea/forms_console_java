<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.data.model.*" %>
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

    Boolean isEdit = false;
    Integer infStatus = 0;
    Integer infType = 1;

    String[] clientSelect = new String[2];
    clientSelect[0] = "";
    clientSelect[1] = "";

    String tags = "";

    if (work != null && work.getIntSeq() > 0) {
        isEdit = true;

        clientSelect[0] = work.getClient().getStrName() + " : " + work.getClient().getStrMobile();
        clientSelect[1] = work.getCompany().getStrCompanyname() + " : " + work.getCompany().getStrTelnum();

        infStatus = work.getIntStatus();
        infType = work.getIntSelecttype();

        if (work.getTags() != null && work.getTags().size() > 0) {
            for (Integer i = 0; i < work.getTags().size(); i++) {
                Tag field = work.getTags().get(i);
                tags += (i != 0 ? "," : "") + field.getStrTag();
            }
        }
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
        <% if (isEdit) { %>
        <h1>협업 No. <%=workseq%> 수정</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item">협업</li>
                <li class="breadcrumb-item active">수정
                </li>
            </ol>
        </nav>
        <% } else { %>
        <h1>협업</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item">협업</li>
                <li class="breadcrumb-item active">등록</li>
            </ol>
        </nav>
        <% } %>
    </div><!-- End Page Title -->

    <section class="section">
        <form id="form_editinfo" method="post" action="#">
            <div class="row work-add">
                <div class="card">
                    <h5 class="card-title"><strong>기본정보</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <label for="work_title" class="col-md-2 col-form-label">협업명</label>
                            <div class="col-md-10">
                                <input name="work_title" type="text" class="form-control"
                                       id="work_title" placeholder="협업명을 입력해주세요."
                                       value="<%=(isEdit && !work.getStrTitle().isBlank() ? work.getStrTitle() : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="work_wstart" class="col-md-2 col-form-label">모집기간</label>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_wstart" name="work_wstart"
                                       value="<%=(isEdit && !work.getDateReadystart().isBlank() ? work.getDateReadystart() : "")%>">
                            </div>
                            <div class="col-md-1 text-center">
                                ~
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_wend" name="work_wend"
                                       value="<%=(isEdit && !work.getDateReadyend().isBlank() ? work.getDateReadyend() : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="work_start" class="col-md-2 col-form-label">진행기간</label>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_start" name="work_start"
                                       value="<%=(isEdit && !work.getDateStart().isBlank() ? work.getDateStart() : "")%>">
                            </div>
                            <div class="col-md-1 text-center">
                                ~
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="work_end" name="work_end"
                                       value="<%=(isEdit && !work.getDateEnd().isBlank() ? work.getDateEnd() : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="hashtag" class="col-md-2 col-form-label">관련 키워드</label>
                            <div class="col-md-10">
                                <input name="hashtag" type="text" class="form-control" id="hashtag" value="<%=tags%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="hashtag" class="col-md-2 col-form-label">담당자 선택</label>
                            <div class="col-md-3">
                                <input name="work_name" type="text" class="form-control" id="work_name" readonly
                                       value="<%=clientSelect[0]%>">
                            </div>
                            <div class="col-md-4">
                                <input name="work_company" type="text" class="form-control" id="work_company" readonly
                                       value="<%=clientSelect[1]%>">
                            </div>
                            <div class="col-md-3">
                                <button type="button" class="btn btn-primary" id="work_clientsearch"><i
                                        class="bi bi-search"></i> 담당자 검색
                                </button>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="quill-editor-full"
                                 style="min-height: 200px;"><%=(isEdit && work.getTxtInfo() != null && !work.getTxtInfo().isBlank() ? work.getTxtInfo() : "협업 내용을 입력해 주세요.")%>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="work_status1" class="col-md-2 col-form-label">상태</label>
                            <div class="col-md-10">
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="work_status"
                                           id="work_status1" value="0" <%=(infStatus == 0 ? "checked" : "")%>>
                                    <label class="form-check-label" for="work_status1">
                                        모집
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="work_status"
                                           id="work_status2" value="1" <%=(infStatus == 1 ? "checked" : "")%>>
                                    <label class="form-check-label" for="work_status2">
                                        진행
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="work_status"
                                           id="work_status3" value="5" <%=(infStatus == 5 ? "checked" : "")%>>
                                    <label class="form-check-label" for="work_status3">
                                        대기
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="work_status"
                                           id="work_status4" value="7" <%=(infStatus == 7 ? "checked" : "")%>>
                                    <label class="form-check-label" for="work_status4">
                                        완료
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="work_status"
                                           id="work_status5" value="9" <%=(infStatus == 9 ? "checked" : "")%>>
                                    <label class="form-check-label" for="work_status5">
                                        취소
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <h5 class="card-title"><strong>인플루언서 선택</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <label class="col-md-2 col-form-label">선택 구분</label>
                            <div class="col-md-2">
                                <input class="form-check-input" type="radio" name="work_inf_select"
                                       id="work_inf_select1" value="option1" <%=(infType == 1 ? "checked" : "")%>>
                                <label class="form-check-label" for="work_inf_select1">
                                    Meta Console 추천
                                </label>
                            </div>
                            <div class="col-md-2">
                                <input class="form-check-input" type="radio" name="work_inf_select"
                                       id="work_inf_select2" value="option2" <%=(infType == 2 ? "checked" : "")%>>
                                <label class="form-check-label" for="work_inf_select2">
                                    직접선택
                                </label>
                            </div>
                            <div class="col-md-2">
                                <input class="form-check-input" type="radio" name="work_inf_select"
                                       id="work_inf_select3" value="option3" <%=(infType == 3 ? "checked" : "")%>>
                                <label class="form-check-label" for="work_inf_select3">
                                    인플루언서 지원
                                </label>
                            </div>
                        </div>
                        <div class="row mb-3 d-none" id="work_influencer_list">
                            <div class="card mb-3 inf_item_row">
                                <div class="row g-0">
                                    <div class="col-md-12">
                                        <div class="card-body">
                                            <div class="row">
                                                <h5 class="card-title inf_item_name col-md-3 text-1em">활동명 (성명)</h5>
                                                <span class="inf_item_tel col-md-3 card-title text-secondary text-center text-1em">010-0000-0000</span>
                                                <span class="inf_item_email col-md-3 card-title text-secondary text-center text-1em">email@email.com</span>
                                                <span class="inf_item_level col-md-2 card-title text-secondary text-center text-1em">lv1</span>
                                                <span class="item_status col-md-1 card-title text-secondary text-center text-1em"><button
                                                        class="btn btn-secondary inf_item_delete"><i
                                                        class="bi bi-trash"></i> 삭제</button></span>
                                            </div>
                                            <div class="row mb-1 inf_item_instagram_box">
                                                <label class="col-md-3 "><a href="#" target="_blank"
                                                                            class="inf_item_media_link text-1em"
                                                                            data-bs-toggle="tooltip"
                                                                            data-bs-placement="top"
                                                                            data-bs-original-title="인스타그램 링크"><i
                                                        class="bi bi-instagram"></i> <span
                                                        class="  inf_item_media_link">-</span></a></label>
                                                <div class="col-md-1 work_item_select">
                                                    <input type="checkbox" class="inf_item_select"> <label>선택</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text">URL</span>
                                                        <input type="text" class="form-control work_item_url text-end"
                                                               placeholder="">
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <input type="text" class="form-control work_item_price text-end"
                                                               placeholder="" aria-describedby="basic-addon2"
                                                               maxlength="10">
                                                        <span class="input-group-text">원</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text">협력사</span>
                                                        <select class="form-select work_item_cstatus">
                                                            <option selected value="0">대기</option>
                                                            <option value="1">등록</option>
                                                            <option value="5">반려</option>
                                                            <option value="9">취소</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text">인플루언서</span>
                                                        <select class="form-select work_item_istatus">
                                                            <option selected value="0">대기</option>
                                                            <option value="1">등록</option>
                                                            <option value="5">반려</option>
                                                            <option value="9">취소</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-1 inf_item_youtube_box">
                                                <label class="col-md-3 "><a href="#" target="_blank"
                                                                            class="inf_item_media_link text-1em"
                                                                            data-bs-toggle="tooltip"
                                                                            data-bs-placement="top"
                                                                            data-bs-original-title="유튜브 링크"><i
                                                        class="bi bi-play-btn-fill"></i> <span
                                                        class="inf_item_media_link">-</span></a></label>
                                                <div class="col-md-1 work_item_select">
                                                    <input type="checkbox" class="inf_item_select"> <label>선택</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text">URL</span>
                                                        <input type="text" class="form-control work_item_url text-end"
                                                               placeholder="">
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <input type="text" class="form-control work_item_price text-end"
                                                               placeholder="" maxlength="10">
                                                        <span class="input-group-text">원</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text">협력사</span>
                                                        <select class="form-select work_item_cstatus">
                                                            <option selected value="0">대기</option>
                                                            <option value="1">등록</option>
                                                            <option value="5">반려</option>
                                                            <option value="9">취소</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text">인플루언서</span>
                                                        <select class="form-select work_item_istatus">
                                                            <option selected value="0">대기</option>
                                                            <option value="1">등록</option>
                                                            <option value="5">반려</option>
                                                            <option value="9">취소</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-1 inf_item_blog_box">
                                                <label class="col-md-3 "><a href="#" target="_blank"
                                                                            class="inf_item_media_link text-1em"
                                                                            data-bs-toggle="tooltip"
                                                                            data-bs-placement="top"
                                                                            data-bs-original-title="블로그 링크"><i
                                                        class="bi bi-bootstrap"></i> <span
                                                        class="  inf_item_media_link">-</span></a></label>
                                                <div class="col-md-1 work_item_select">
                                                    <input type="checkbox" class="inf_item_select"> <label>선택</label>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text">URL</span>
                                                        <input type="text" class="form-control work_item_url text-end"
                                                               placeholder="">
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <input type="text" class="form-control work_item_price text-end"
                                                               placeholder="" maxlength="10">
                                                        <span class="input-group-text">원</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text">협력사</span>
                                                        <select class="form-select work_item_cstatus">
                                                            <option selected value="0">대기</option>
                                                            <option value="1">등록</option>
                                                            <option value="5">반려</option>
                                                            <option value="9">취소</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="input-group mb-3">
                                                        <span class="input-group-text">인플루언서</span>
                                                        <select class="form-select work_item_istatus">
                                                            <option selected value="0">대기</option>
                                                            <option value="1">등록</option>
                                                            <option value="5">반려</option>
                                                            <option value="9">취소</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3 text-center align-center">
                            <button type="button" class="btn btn-primary" id="work_infsearch">인플루언서 추가</button>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12 text-center" id="#work_total_price">
                                <span class="text-2em">총</span>
                                <strong><span class="text-4em" id="work_item_totalprice">0</span></strong>
                                <span class="text-2em">원</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mb-3 text-center">
                    <button class="btn-lg btn-primary" type="submit"><i class="bi bi-clipboard-plus"></i>
                        협업 <%=(isEdit ? "수정" : "등록")%>
                    </button>
                    <button class="btn-lg btn-outline-primary ms-3" type="button" id="work_listgo">목록으로</button>
                    <% if (isEdit) { %>
                    <button class="btn-lg btn-outline-primary ms-3" type="button" id="work_readgo">상세내용</button>
                    <% } %>
                </div>
            </div>
        </form>
    </section>
</main>
<script>
    var i_selectlist = new Array();
    var c_selectlist = {};
    var workno = <%=workseq%>;
    var keyword = "<%=keyword%>";
    var page = "<%=ppage%>";
    var status = "<%=status%>";
    var wostatus = "0";
    var isEdit = <%=(isEdit ? "true" : "false")%>;
    <% if(isEdit) { %>
    c_selectlist.seq = <%=work.getClient().getIntSeq()%>;
    c_selectlist.comseq = <%=work.getCompany().getIntSeq()%>;
    c_selectlist.email = "<%=work.getClient().getStrEmail()%>";
    c_selectlist.name = "<%=work.getClient().getStrName()%>";
    c_selectlist.mobile = "<%=work.getClient().getStrMobile()%>";
    c_selectlist.company = {
        'seq' : <%=work.getCompany().getIntSeq()%>,
        'comname' : "<%=work.getCompany().getStrCompanyname()%>",
        'tel' : "<%=work.getCompany().getStrTelnum()%>",
        'zip' : "<%=work.getCompany().getStrZipcode()%>",
        'address' :  "<%=work.getCompany().getStrAddress()%>"
    };
    <%
    if(work.getInflist() != null) {
        for(int i = 0; i < work.getInflist().size(); i ++) {
            User field = (User) work.getInflist().get(i);
    %>
    i_selectlist.push({
        'seq' : <%=field.getIntSeq()%>,
        <% if(field.getCompany() != null) { %>
        'company': {
            'seq': <%=field.getCompany().getIntSeq()%>,
            'address': "<%=field.getCompany().getStrAddress()%>",
            'comname': "<%=field.getCompany().getStrCompanyname()%>",
            'tel': "<%=field.getCompany().getStrTelnum()%>",
            'zip': "<%=field.getCompany().getStrZipcode()%>"
        },
        <% } %>
        'comseq': <%=field.getIntCompanySeq().toString()%>,
        'email': "<%=field.getStrEmail()%>",
        'level': <%=field.getIntLevel()%>,
        'mobile': "<%=field.getStrMobile()%>",
        'name': "<%=field.getStrName()%>",
        'nik': "<%=field.getStrNikname()%>"
    });

    i_selectlist[<%=i%>].media = new Array();
    <%      if(field.getMedia() != null) {
                for(int j = 0; j < field.getMedia().size(); j++) {
                    Boolean mcheck = false;
                    Media mdata = field.getMedia().get(j);
                    int mprice = 0;
                    int mstatus = 0;
                    int istatus = 0;
                    int cstatus = 0;
                    String murl = "";
                    int wiseq = 0;

                    for(int k = 0; k < work.getInfos().size(); k++) {
                        if(mdata.getIntSeq().toString().equals(work.getInfos().get(k).getIntMediaSeq().toString())) {
                            mcheck = true;
                            mprice = work.getInfos().get(k).getIntPrice();
                            istatus = work.getInfos().get(k).getIntUserStatus();
                            cstatus = work.getInfos().get(k).getIntClientStatus();
                            mstatus = work.getInfos().get(k).getIntStatus();
                            murl = work.getInfos().get(k).getStrURL();
                            break;
                        }
                    }
    %>
    i_selectlist[<%=i%>].media.push({
        'seq' : <%=mdata.getIntSeq()%>,
        'type' : <%=mdata.getIntType()%>,
        'url' : "<%=mdata.getStrURL()%>",
        'usertype' : 2,
        'userseq' : <%=field.getIntSeq()%>,
        'iurl' : "<%=murl%>",
        'price': <%=mprice%>,
        'status': <%=mstatus%>,
        'istatus': <%=istatus%>,
        'cstatus': <%=cstatus%>,
        'checked' : <%=(mcheck ? "true" : "false")%>
    });
    <%
                }
            }
        }
    }
    %>
    <% } %>
</script>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_searchclient.jsp"/>
<jsp:include page="inc_searchinf.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

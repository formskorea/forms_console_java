<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.data.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
    User userinfo = (User) request.getAttribute("fmcuser");

    User client = (User) request.getAttribute("client");

    String keyword = (String) request.getAttribute("keyword");
    String ppage = (String) request.getAttribute("page");
    String status = (String) request.getAttribute("status");

    Boolean isEdit = false;
    Boolean isCompany = false;

    Integer infStatus = 0;
    String[] infCorpAddress = new String[2];
    infCorpAddress[0] = "";
    infCorpAddress[1] = "";
    String tagsv = "";

    if(client.getIntSeq() != null) {
        isEdit = true;

        if(client.getIntStatus() != null && client.getIntStatus() > 0) {
            infStatus = client.getIntStatus();
        }

        if(client.getCompany() != null) {
            isCompany = true;
            infCorpAddress = client.getCompany().getStrAddress().split("\\|");
        }

        if(client.getTags() != null && client.getTags().size() > 0) {
            for (int i = 0; i < client.getTags().size(); i++) {
                tagsv += (i > 0 ? "," : "") + client.getTags().get(i).getStrTag();
            }
        }
    }

%>
<jsp:include page="inc_header.jsp">
    <jsp:param name="styles" value="${arrCss}"/>
</jsp:include>
<jsp:include page="inc_menu.jsp">
    <jsp:param name="fmcuser" value="${userinfo}"/>
    <jsp:param name="nowmenu" value="4"/>
</jsp:include>
<main id="main" class="main">

    <div class="pagetitle">
        <% if(isEdit) { %>
        <h1><%=client.getStrName()%>(<%=client.getStrNikname()%>) 수정</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item">협력사</li>
                <li class="breadcrumb-item active">수정</li>
            </ol>
        </nav>
        <% } else { %>
        <h1>등록</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item">협력사</li>
                <li class="breadcrumb-item active">등록</li>
            </ol>
        </nav>
        <% } %>
    </div><!-- End Page Title -->

    <section class="section">
        <form id="form_editinfo" method="post" action="#">
            <div class="row work-add">
                <div class="card">
                    <h5 class="card-title"><strong>담당자 정보</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <label for="cl_name" class="col-md-2 col-form-label">성명</label>
                            <div class="col-md-4">
                                <input name="cl_name" type="text" class="form-control"
                                       id="cl_name" placeholder="성명을 입력해주세요." value="<%=(isEdit && !client.getStrName().isBlank() ? client.getStrName() : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="cl_email" class="col-md-2 col-form-label">이메일</label>
                            <div class="col-md-4">
                                <div class="row">
                                    <span class="col-md-8">
                                        <input name="cl_email" type="text" class="form-control "
                                               id="cl_email" placeholder="이메일을 입력해주세요." value="<%=(isEdit && !client.getStrEmail().isBlank() ? client.getStrEmail() : "")%>">
                                    </span>
                                    <span class="col-md-4 text-center">
                                        <% if(isEdit && !client.getStrEmail().isBlank()) { %>
                                        <button class="btn btn-success" type="button" id="cl_email_check" rdata="<%=client.getStrEmail()%>">이메일 확인</button>
                                        <% } else { %>
                                        <button class="btn btn-primary" type="button" id="cl_email_check"><i
                                                class="bi bi-check"></i> 중복확인</button>
                                        <% } %>
                                    </span>
                                </div>
                            </div>
                            <label for="cl_mobile" class="col-md-2 col-form-label">연락처</label>
                            <div class="col-md-4">
                                <input name="cl_mobile" type="text" class="form-control"
                                       id="cl_mobile" placeholder="연락처를 입력해주세요." value="<%=(isEdit && !client.getStrMobile().isBlank() ? client.getStrMobile() : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="cl_pass" class="col-md-2 col-form-label">비밀번호</label>
                            <div class="col-md-4">
                                <input name="cl_pass" type="password" class="form-control"
                                       id="cl_pass" placeholder="<%=(isEdit ? "비밀번호 변경시에만 비밀번호를 입력해주세요." : "비밀번호를 입력해주세요.")%>">
                            </div>
                            <label for="cl_pass2" class="col-md-2 col-form-label">비밀번호 확인</label>
                            <div class="col-md-4">
                                <input name="cl_pass2" type="password" class="form-control"
                                       id="cl_pass2" placeholder="비밀번호를 다시 입력해주세요.">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="cl_pass" class="col-md-2 col-form-label">관련 키워드</label>
                            <div class="col-md-10">
                                <input name="hashtag" type="text" class="form-control" id="hashtag"
                                       value="<%=tagsv%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="cl_status1" class="col-md-2 col-form-label">상태</label>
                            <div class="col-md-10">
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="cl_status"
                                           id="cl_status1" value="0" <%=(infStatus == 0 ? "checked" : "")%>>
                                    <label class="form-check-label" for="cl_status1">
                                        대기
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="cl_status"
                                           id="cl_status2" value="1" <%=(infStatus == 1 ? "checked" : "")%>>
                                    <label class="form-check-label" for="cl_status2">
                                        정상
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="cl_status"
                                           id="cl_status3" value="5" <%=(infStatus == 5 ? "checked" : "")%>>
                                    <label class="form-check-label" for="cl_status3">
                                        탈퇴
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="cl_status"
                                           id="cl_status4" value="9" <%=(infStatus == 9 ? "checked" : "")%>>
                                    <label class="form-check-label" for="cl_status4">
                                        차단
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <h5 class="card-title"><strong>회사 정보</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-10">
                            </div>
                            <div class="col-md-2 text-end">
                                <button class="btn btn-primary" type="button" id="cl_company_searchgo"><i
                                        class="bi bi-search"></i> 회사 검색</button>
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked ">
                            <label for="cl_company_name" class="col-md-2 col-form-label">회사명</label>
                            <div class="col-md-4">
                                <input name="cl_company_name" type="text" class="form-control"
                                       id="cl_company_name" placeholder="회사명을 입력해주세요." value="<%=(isEdit && isCompany && !client.getCompany().getStrCompanyname().isBlank() ? client.getCompany().getStrCompanyname() : "")%>">
                            </div>
                            <label for="cl_company_tel" class="col-md-2 col-form-label">회사 연락처</label>
                            <div class="col-md-4">
                                <input name="cl_company_tel" type="text" class="form-control"
                                       id="cl_company_tel" placeholder="회사 연락처를 입력해주세요." value="<%=(isEdit && isCompany && !client.getCompany().getStrTelnum().isBlank() ? client.getCompany().getStrTelnum() : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked ">
                            <label for="cl_company_zipcode" class="col-md-2 col-form-label">주소</label>
                            <div class="col-md-3">
                                <input name="cl_company_zipcode" type="text" class="form-control"
                                       id="cl_company_zipcode" disabled placeholder="우편번호" value="<%=(isEdit && isCompany && !client.getCompany().getStrZipcode().isBlank() ? client.getCompany().getStrZipcode() : "")%>">
                            </div>
                            <div class="col-md-5">
                                <input name="cl_company_address1" type="text" class="form-control"
                                       id="cl_company_address1" disabled placeholder="주소를 검색해주세요." value="<%=(isEdit && isCompany && infCorpAddress[0] != null && !infCorpAddress[0].isBlank() ? infCorpAddress[0] : "")%>">
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-primary" type="button" id="cl_company_addressgo"><i
                                        class="bi bi-search"></i> 주소검색</button>
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked ">
                            <div class="col-md-2"></div>
                            <div class="col-md-10">
                                <input name="cl_company_address2" type="text" class="form-control"
                                       id="cl_company_address2" placeholder="상세주소를 입력해주세요." value="<%=(isEdit && isCompany && infCorpAddress[1] != null && !infCorpAddress[1].isBlank() ? infCorpAddress[1] : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked ">
                            <label for="cl_company_number" class="col-md-2 col-form-label">사업자 등록번호</label>
                            <div class="col-md-4">
                                <input name="cl_company_number" type="text" class="form-control"
                                       id="cl_company_number" placeholder="사업자 등록번호를 입력해주세요." value="<%=(isEdit && isCompany && client.getCompany().getStrCompanynum() != null && !client.getCompany().getStrCompanynum().isBlank() ? client.getCompany().getStrCompanynum() : "")%>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mb-3 align-center text-center">
                    <button class="btn-lg btn-primary" type="submit"><i class="bx bx-user-plus"></i> 협력사 <%=(isEdit ? "수정" : "등록")%></button>
                    <button class="btn-lg btn-outline-primary ms-3" type="button" id="cl_listgo">목록으로</button>
                    <% if(isEdit) { %>
                    <button class="btn-lg btn-outline-primary ms-3" type="button" id="cl_readgo">상세내용</button>
                    <% } %>
                </div>
            </div>
        </form>
    </section>
</main>
<script>
    var isEmailCheck = <%=(isEdit && !client.getStrEmail().isBlank()  ? "true" : "false")%>;
    var saveEmail = "<%=(isEdit && !client.getStrEmail().isBlank()  ? client.getStrEmail() : "")%>";
    var keyword = "<%=keyword%>";
    var page = "<%=ppage%>";
    var status = "<%=status%>";
    var infno = "<%=client.getIntSeq()%>";
    var isEdit = <%=(isEdit ? "true" : "false")%>;
    var isCompany = <%=(isCompany ? "true" : "false")%>;
    var c_selectlist = {};
    <% if(isCompany) { %>
        c_selectlist.seq = <%=client.getCompany().getIntSeq()%>;
    <% } %>
    var infStatus = <%=infStatus%>;
</script>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_searchcompany.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

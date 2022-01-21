<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.data.model.User" %>
<%@ page import="com.formskorea.console.data.model.Media" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    List<String> arrCss = (List<String>) request.getAttribute("styles");
    User userinfo = (User) request.getAttribute("fmcuser");


    User influencer = (User) request.getAttribute("influencer");

    String keyword = (String) request.getAttribute("keyword");
    String ppage = (String) request.getAttribute("page");
    String status = (String) request.getAttribute("status");

    Boolean isEdit = false;
    Boolean isCompany = false;

    String[] Urls = new String[5];
    Urls[1] = "";
    Urls[2] = "";
    Urls[3] = "";
    Urls[4] = "";
    Integer infStatus = 0;
    String[] infCorpAddress = new String[2];
    infCorpAddress[0] = "";
    infCorpAddress[1] = "";
    String tagsv = "";

    if(influencer.getIntSeq() != null) {
        isEdit = true;

        if(influencer.getMedia() != null && influencer.getMedia().size() > 0) {
            for (int i = 0; i < influencer.getMedia().size(); i++) {
                Media field = influencer.getMedia().get(i);
                if (field.getStrURL() != null && !field.getStrURL().isBlank()) {
                    Urls[field.getIntType()] = field.getStrURL();
                }
            }
        }

        if(influencer.getIntStatus() != null && influencer.getIntStatus() > 0) {
            infStatus = influencer.getIntStatus();
        }

        if(influencer.getCompany() != null) {
            isCompany = true;
            infCorpAddress = influencer.getCompany().getStrAddress().split("\\|");
        }

        if(influencer.getTags() != null && influencer.getTags().size() > 0) {
            for (int i = 0; i < influencer.getTags().size(); i++) {
                tagsv += (i > 0 ? "," : "") + influencer.getTags().get(i).getStrTag();
            }
        }
    }

%>
<jsp:include page="inc_header.jsp">
    <jsp:param name="styles" value="${arrCss}"/>
</jsp:include>
<jsp:include page="inc_menu.jsp">
    <jsp:param name="fmcuser" value="${userinfo}"/>
    <jsp:param name="nowmenu" value="3"/>
</jsp:include>
<main id="main" class="main">

    <div class="pagetitle">
        <% if(isEdit) { %>
        <h1><%=influencer.getStrName()%>(<%=influencer.getStrNikname()%>) 수정</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item">인플루언서</li>
                <li class="breadcrumb-item active">수정</li>
            </ol>
        </nav>
        <% } else { %>
        <h1>등록</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <li class="breadcrumb-item">인플루언서</li>
                <li class="breadcrumb-item active">등록</li>
            </ol>
        </nav>
        <% } %>
    </div><!-- End Page Title -->

    <section class="section">
        <form id="form_influencer" method="post" action="#">
            <div class="row work-add">
                <div class="card">
                    <h5 class="card-title"><strong>회원정보</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <label for="inf_name" class="col-md-2 col-form-label">성명</label>
                            <div class="col-md-4">
                                <input name="inf_name" type="text" class="form-control"
                                       id="inf_name" placeholder="성명을 입력해주세요." value="<%=(isEdit && !influencer.getStrName().isBlank() ? influencer.getStrName() : "")%>">
                            </div>
                            <label for="inf_nik" class="col-md-2 col-form-label">활동명</label>
                            <div class="col-md-4">
                                <input name="inf_nik" type="text" class="form-control"
                                       id="inf_nik" placeholder="활동명을 입력해주세요." value="<%=(isEdit && !influencer.getStrNikname().isBlank() ? influencer.getStrNikname() : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_email" class="col-md-2 col-form-label">이메일</label>
                            <div class="col-md-4">
                                <div class="row">
                                    <span class="col-md-8">
                                        <input name="inf_email" type="text" class="form-control "
                                               id="inf_email" placeholder="이메일을 입력해주세요." value="<%=(isEdit && !influencer.getStrEmail().isBlank() ? influencer.getStrEmail() : "")%>">
                                    </span>
                                    <span class="col-md-4 text-center">
                                        <% if(isEdit && !influencer.getStrEmail().isBlank()) { %>
                                        <button class="btn btn-success" type="button" id="inf_email_check" rdata="<%=influencer.getStrEmail()%>">이메일 확인</button>
                                        <% } else { %>
                                        <button class="btn btn-primary" type="button" id="inf_email_check"><i
                                                class="bi bi-check"></i> 중복확인</button>
                                        <% } %>
                                    </span>
                                </div>
                            </div>
                            <label for="inf_mobile" class="col-md-2 col-form-label">연락처</label>
                            <div class="col-md-4">
                                <input name="inf_mobile" type="text" class="form-control"
                                       id="inf_mobile" placeholder="연락처를 입력해주세요." value="<%=(isEdit && !influencer.getStrMobile().isBlank() ? influencer.getStrMobile() : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_pass" class="col-md-2 col-form-label">비밀번호</label>
                            <div class="col-md-4">
                                <input name="inf_pass" type="password" class="form-control"
                                       id="inf_pass" placeholder="<%=(isEdit ? "비밀번호 변경시에만 비밀번호를 입력해주세요." : "비밀번호를 입력해주세요.")%>">
                            </div>
                            <label for="inf_pass2" class="col-md-2 col-form-label">비밀번호 확인</label>
                            <div class="col-md-4">
                               <input name="inf_pass2" type="password" class="form-control"
                                       id="inf_pass2" placeholder="비밀번호를 다시 입력해주세요.">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_pass" class="col-md-2 col-form-label">관련 키워드</label>
                            <div class="col-md-10">
                                <input name="hashtag" type="text" class="form-control" id="hashtag"
                                       value="<%=tagsv%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_status1" class="col-md-2 col-form-label">상태</label>
                            <div class="col-md-10">
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="inf_status"
                                           id="inf_status1" value="0" <%=(infStatus == 0 ? "checked" : "")%>>
                                    <label class="form-check-label" for="inf_status1">
                                        대기
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="inf_status"
                                           id="inf_status2" value="1" <%=(infStatus == 1 ? "checked" : "")%>>
                                    <label class="form-check-label" for="inf_status2">
                                        정상
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="inf_status"
                                           id="inf_status3" value="5" <%=(infStatus == 5 ? "checked" : "")%>>
                                    <label class="form-check-label" for="inf_status3">
                                        탈퇴
                                    </label>
                                </div>
                                <div class="form-check-inline">
                                    <input class="form-check-input" type="radio" name="inf_status"
                                           id="inf_status4" value="9" <%=(infStatus == 9 ? "checked" : "")%>>
                                    <label class="form-check-label" for="inf_status4">
                                        차단
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <h5 class="card-title"><strong>매체정보</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <label for="inf_media1" class="col-md-2 col-form-label">Instagram</label>
                            <div class="col-md-10">
                                <input name="inf_media1" type="text" class="form-control"
                                       id="inf_media1" placeholder="Instagram URL을 입력해주세요." value="<%=Urls[1]%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_media2" class="col-md-2 col-form-label">Youtube</label>
                            <div class="col-md-10">
                                <input name="inf_media2" type="text" class="form-control"
                                       id="inf_media2" placeholder="Youtube URL을 입력해주세요." value="<%=Urls[2]%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_media3" class="col-md-2 col-form-label">Blog</label>
                            <div class="col-md-10">
                                <input name="inf_media3" type="text" class="form-control"
                                       id="inf_media3" placeholder="Blog URL을 입력해주세요." value="<%=Urls[3]%>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label for="inf_media4" class="col-md-2 col-form-label">Shopping mall</label>
                            <div class="col-md-10">
                                <input name="inf_media4" type="text" class="form-control"
                                       id="inf_media4" placeholder="Shopping mall URL을 입력해주세요." value="<%=Urls[4]%>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <h5 class="card-title"><strong>소속사 정보</strong></h5>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-10">
                                <div class="form-check-inline">
                                    <input name="inf_company_type" type="radio" class="form-check-input"
                                           id="inf_company_type1" value="1" <%=(isCompany ? "checked" : "")%>>
                                    <label for="inf_company_type1" class="form-check-label">소속사 있음</label>
                                </div>
                                <div class="form-check-inline">
                                    <input name="inf_company_type" type="radio" class="form-check-input"
                                           id="inf_company_type2" value="0" <%=(!isCompany ? "checked" : "")%>>
                                    <label for="inf_company_type2" class="form-check-label">소속사 없음</label>
                                </div>
                            </div>
                            <div class="col-md-2 text-end">
                                <button class="btn btn-primary <%=(!isCompany ? "d-none" : "")%>" type="button" id="inf_company_searchgo"><i
                                        class="bi bi-search"></i> 소속사 검색</button>
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked <%=(!isCompany ? "d-none" : "")%>">
                            <label for="inf_company_name" class="col-md-2 col-form-label">소속사명</label>
                            <div class="col-md-4">
                                <input name="inf_company_name" type="text" class="form-control"
                                       id="inf_company_name" placeholder="소속사명을 입력해주세요." value="<%=(isEdit && isCompany && !influencer.getCompany().getStrCompanyname().isBlank() ? influencer.getCompany().getStrCompanyname() : "")%>">
                            </div>
                            <label for="inf_company_tel" class="col-md-2 col-form-label">소속사 연락처</label>
                            <div class="col-md-4">
                                <input name="inf_company_tel" type="text" class="form-control"
                                       id="inf_company_tel" placeholder="소속사 연락처를 입력해주세요." value="<%=(isEdit && isCompany && !influencer.getCompany().getStrTelnum().isBlank() ? influencer.getCompany().getStrTelnum() : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked <%=(!isCompany ? "d-none" : "")%>">
                            <label for="inf_company_zipcode" class="col-md-2 col-form-label">주소</label>
                            <div class="col-md-3">
                                <input name="inf_company_zipcode" type="text" class="form-control"
                                       id="inf_company_zipcode" disabled placeholder="우편번호" value="<%=(isEdit && isCompany && !influencer.getCompany().getStrZipcode().isBlank() ? influencer.getCompany().getStrZipcode() : "")%>">
                            </div>
                            <div class="col-md-5">
                                <input name="inf_company_address1" type="text" class="form-control"
                                       id="inf_company_address1" disabled placeholder="주소를 검색해주세요." value="<%=(isEdit && isCompany && infCorpAddress[0] != null && !infCorpAddress[0].isBlank() ? infCorpAddress[0] : "")%>">
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-primary" type="button" id="inf_company_addressgo"><i
                                        class="bi bi-search"></i> 주소검색</button>
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked <%=(!isCompany ? "d-none" : "")%>">
                            <div class="col-md-2"></div>
                            <div class="col-md-10">
                                <input name="inf_company_address2" type="text" class="form-control"
                                       id="inf_company_address2" placeholder="상세주소를 입력해주세요." value="<%=(isEdit && isCompany && infCorpAddress[1] != null && !infCorpAddress[1].isBlank() ? infCorpAddress[1] : "")%>">
                            </div>
                        </div>
                        <div class="row mb-3 inf_comapy_checked <%=(!isCompany ? "d-none" : "")%>">
                            <label for="inf_company_number" class="col-md-2 col-form-label">사업자 등록번호</label>
                            <div class="col-md-4">
                                <input name="inf_company_number" type="text" class="form-control"
                                       id="inf_company_number" placeholder="사업자 등록번호를 입력해주세요." value="<%=(isEdit && isCompany && influencer.getCompany().getStrCompanynum() != null && !influencer.getCompany().getStrCompanynum().isBlank() ? influencer.getCompany().getStrCompanynum() : "")%>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mb-3 align-center text-center">
                    <button class="btn-lg btn-primary" type="submit"><i class="bx bx-user-plus"></i> 인플루언서 <%=(isEdit ? "수정" : "등록")%></button>
                    <button class="btn-lg btn-outline-primary ms-3" type="button" id="inf_listgo">목록으로</button>
                    <% if(isEdit) { %>
                        <button class="btn-lg btn-outline-primary ms-3" type="button" id="inf_readgo">상세내용</button>
                    <% } %>
                </div>
            </div>
        </form>
    </section>
</main>
<script>
    var isEmailCheck = <%=(isEdit && !influencer.getStrEmail().isBlank()  ? "true" : "false")%>;
    var saveEmail = "<%=(isEdit && !influencer.getStrEmail().isBlank()  ? influencer.getStrEmail() : "")%>";
    var keyword = "<%=keyword%>";
    var page = "<%=ppage%>";
    var status = "<%=status%>";
    var infno = "<%=influencer.getIntSeq()%>";
    var isEdit = <%=(isEdit ? "true" : "false")%>;
    var isCompany = <%=(isCompany ? "true" : "false")%>;
    var c_selectlist = {};
    <% if(isCompany) { %>
        c_selectlist.seq = <%=influencer.getCompany().getIntSeq()%>;
    <% } %>
    var infStatus = <%=infStatus%>;
</script>
<!-- End #main -->
<jsp:include page="inc_footer.jsp"/>
<jsp:include page="inc_searchcompany.jsp"/>
<jsp:include page="inc_bottom.jsp">
    <jsp:param name="scripts" value="${arrScript}"/>
</jsp:include>

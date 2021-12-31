<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal fade" id="fmc_searchclient" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">협력사/담당자 검색</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3" id="search_box">
                    <div class="row col-md-10 mb-3">
                        <div class="input-group">
                            <span class="input-group-text">키워드 검색</span>
                            <input type="text" class="form-control" id="cl_search_text" name="cl_search_text" aria-describedby="basic-addon3"
                                   placeholder="예)뷰티, 아모레">
                        </div>
                    </div>
                    <div class="row col-md-2 mb-3 text-center">
                        <button class="btn btn-primary" id="cl_search_button"><i class="bi bi-search"></i> 검색하기</button>
                    </div>
                </div>
                <div class="row g-0 mb-3" id="cl_item_box">
                    <div class="card mb-3 cl_item_row">
                        <div class="row g-0">
                            <div class="col-md-12">
                                <div class="card-body">
                                    <div class="row">
                                        <h5 class="card-title cl_item_name col-md-3 text-1em">활동명 (성명)</h5>
                                        <span class="cl_item_tel col-md-3 card-title text-secondary text-center text-1em">010-0000-0000</span>
                                        <span class="cl_item_email col-md-3 card-title text-secondary text-center text-1em">email@email.com</span>
                                        <span class="cl_item_level col-md-2 card-title text-secondary text-center text-1em">lv1</span>
                                        <span class="cl_item_status col-md-1 card-title text-secondary text-center text-1em"><input type="radio" name="cl_select" class="cl_item_select"> <label>선택</label></span>
                                    </div>
                                    <div class="row item_company_box">
                                        <h5 class="card-title cl_item_companyname col-md-3 pt-md-0 text-1em">회사명</h5>
                                        <span class="cl_item_companytel col-md-3 card-title text-secondary pt-md-0 text-center text-1em">010-0000-0000</span>
                                        <span class="cl_item_companyaddr col-md-6 card-title text-secondary pt-md-0 text-center text-1em">주소주소</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row g-0 mb-3 d-none" id="cl_loading_box">
                    <div class="loader col-md-12 text-center">Loading...</div>
                </div>
                <div class="row g-0 mb-3 d-none" id="cl_empty_box">
                    <div class="text-center">
                        <i class="bi bi-trash2" style="font-size: 6em;"></i><br />
                        <span>협력사 정보가 없습니다.</span>
                    </div>
                </div>
                <div class="row g-0 mb-3 d-none" id="cl_additem_box">
                    <button type="button" class="btn btn-outline-primary" id="cl_item_add">더보기</button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="cl_item_selectgo">선택하기</button>
            </div>
        </div>
    </div>
</div>
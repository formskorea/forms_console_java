<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal fade" id="fmc_searchcompany" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">소속사 검색</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3" id="search_box">
                    <div class="row col-md-10 mb-3">
                        <div class="input-group">
                            <span class="input-group-text">키워드 검색</span>
                            <input type="text" class="form-control" id="com_search_text" name="com_search_text" aria-describedby="basic-addon3"
                                   placeholder="예)뷰티, 아모레">
                        </div>
                    </div>
                    <div class="row col-md-2 mb-3 text-center">
                        <button class="btn btn-primary" id="com_search_button"><i class="bi bi-search"></i> 검색하기</button>
                    </div>
                </div>
                <div class="row g-0 mb-3" id="com_item_box">
                    <div class="card mb-3 com_item_row">
                        <div class="row g-0">
                            <div class="col-md-12">
                                <div class="card-body">
                                    <div class="row mt-md-3 item_company_box">
                                        <h5 class="card-title com_item_companyname col-md-3 pt-md-0 text-1em">회사명</h5>
                                        <span class="com_item_companytel col-md-3 card-title text-secondary pt-md-0 text-center text-1em">010-0000-0000</span>
                                        <span class="com_item_companyaddr col-md-5 card-title text-secondary pt-md-0 text-center text-1em">주소주소</span>
                                        <span class="com_item_status col-md-1 card-title text-secondary text-center text-1em"><input type="radio" name="cl_select" class="com_item_select"> <label>선택</label></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row g-0 mb-3 d-none" id="com_loading_box">
                    <div class="loader col-md-12 text-center">Loading...</div>
                </div>
                <div class="row g-0 mb-3 d-none" id="com_empty_box">
                    <div class="text-center">
                        <i class="bi bi-trash2" style="font-size: 6em;"></i><br />
                        <span>소속사 정보가 없습니다.</span>
                    </div>
                </div>
                <div class="row g-0 mb-3 d-none" id="com_additem_box">
                    <button type="button" class="btn btn-outline-primary" id="com_item_add">더보기</button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="com_item_selectgo">선택하기</button>
            </div>
        </div>
    </div>
</div>
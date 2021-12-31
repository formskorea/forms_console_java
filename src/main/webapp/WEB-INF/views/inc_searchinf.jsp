<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="modal fade" id="fmc_searchinf" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">인플루언서 검색</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3" id="search_box">
                    <div class="row col-md-10 mb-3">
                        <div class="input-group">
                            <span class="input-group-text">키워드 검색</span>
                            <input type="text" class="form-control" id="inf_search_text" name="inf_search_text" aria-describedby="basic-addon3"
                                   placeholder="예)뷰티, 아모레">
                        </div>
                    </div>
                    <div class="row col-md-2 mb-3 text-center">
                        <button class="btn btn-primary" id="inf_search_button"><i class="bi bi-search"></i> 검색하기</button>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <input class="form-check-input" type="checkbox" name="work_inf_select"
                               id="work_media_select1" value="option1" checked>
                        <label class="form-check-label" for="work_media_select1">
                            <i class="bi bi-instagram"></i> 인스타그램
                        </label>
                    </div>
                    <div class="col-md-4">
                        <input class="form-check-input" type="checkbox" name="work_inf_select"
                               id="work_media_select2" value="option2" checked>
                        <label class="form-check-label" for="work_media_select2">
                            <i class="bi bi-play-btn-fill"></i> 유튜브
                        </label>
                    </div>
                    <div class="col-md-4">
                        <input class="form-check-input" type="checkbox" name="work_inf_select"
                               id="work_media_select3" value="option3" checked>
                        <label class="form-check-label" for="work_media_select3">
                            <i class="bi bi-bootstrap"></i> 블로그
                        </label>
                    </div>
                </div>
                <div class="row g-0 mb-3" id="inf_item_box">
                    <div class="card mb-3 inf_item_row">
                        <div class="row g-0">
                            <div class="col-md-12">
                                <div class="card-body">
                                    <div class="row">
                                        <h5 class="card-title inf_item_name col-md-3 text-1em">활동명 (성명)</h5>
                                        <span class="inf_item_tel col-md-3 card-title text-secondary text-center text-1em">010-0000-0000</span>
                                        <span class="inf_item_email col-md-3 card-title text-secondary text-center text-1em">email@email.com</span>
                                        <span class="inf_item_level col-md-2 card-title text-secondary text-center text-1em">lv1</span>
                                        <span class="inf_item_status col-md-1 card-title text-secondary text-center text-1em"><input type="checkbox" class="inf_item_select"> <label>선택</label></span>
                                    </div>
                                    <div class="row mb-1 inf_item_instagram_box">
                                        <label class="col-md-6 "><a href="#" target="_blank" class="inf_item_media_link text-1em"
                                                                      data-bs-toggle="tooltip" data-bs-placement="top"
                                                                      data-bs-original-title="인스타그램 링크"><i
                                                class="bi bi-instagram"></i> <span
                                                class="  inf_item_media_link">-</span></a></label>
                                        <div class="col-md-2 "><i class="ri-user-received-2-fill" data-bs-toggle="tooltip"
                                                                    data-bs-placement="top" data-bs-original-title="팔로워"></i>
                                            <span class="inf_item_follower">-</span></div>
                                        <div class="col-md-2  text-1em"><i class="ri-user-shared-2-fill" data-bs-toggle="tooltip"
                                                                    data-bs-placement="top" data-bs-original-title="팔로우"></i>
                                            <span class="inf_item_follow">-</span></div>
                                        <div class="col-md-2  text-1em"><i class="bi bi-image" data-bs-toggle="tooltip"
                                                                    data-bs-placement="top" data-bs-original-title="게시물"></i>
                                            <span class="inf_item_upcount">-</span></div>
                                    </div>
                                    <div class="row mb-1 inf_item_youtube_box">
                                        <label class="col-md-6 "><a href="#" target="_blank" class="inf_item_media_link text-1em"
                                                                      data-bs-toggle="tooltip" data-bs-placement="top"
                                                                      data-bs-original-title="유튜브 링크"><i
                                                class="bi bi-play-btn-fill"></i> <span
                                                class="  inf_item_media_link">-</span></a></label>
                                        <div class="col-md-2  text-1em"><i class="ri-user-received-2-fill" data-bs-toggle="tooltip"
                                                                    data-bs-placement="top" data-bs-original-title="구독자"></i>
                                            <span class="inf_item_follower">-</span></div>
                                        <div class="col-md-2  text-1em"><i class="bi bi-play-btn-fill" data-bs-toggle="tooltip"
                                                                    data-bs-placement="top" data-bs-original-title="조회수"></i>
                                            <span class="inf_item_follow">-</span></div>
                                        <div class="col-md-2  text-1em"><i class="bi bi-camera-video" data-bs-toggle="tooltip"
                                                                    data-bs-placement="top" data-bs-original-title="동영상"></i>
                                            <span class="inf_item_upcount">-</span></div>
                                    </div>
                                    <div class="row mb-1 inf_item_blog_box">
                                        <label class="col-md-6 "><a href="#" target="_blank" class="inf_item_media_link text-1em"
                                                                      data-bs-toggle="tooltip" data-bs-placement="top"
                                                                      data-bs-original-title="블로그 링크"><i
                                                class="bi bi-bootstrap"></i> <span
                                                class="  inf_item_media_link">-</span></a></label>
                                        <div class="col-md-2 text-1em"><i class="ri-user-received-2-fill" data-bs-toggle="tooltip"
                                                                    data-bs-placement="top" data-bs-original-title="방문자"></i>
                                            <span class="inf_item_follower">-</span></div>
                                        <div class="col-md-2 text-1em"><i class="ri-stack-overflow-fill" data-bs-toggle="tooltip"
                                                                    data-bs-placement="top" data-bs-original-title="게시물"></i>
                                            <span class="inf_item_follow">-</span></div>
                                    </div>
                                    <div class="row mb-1 inf_item_shopping_box">
                                        <label class="col-md-12"><a href="#" target="_blank" class="inf_item_media_link text-1em"
                                                                       data-bs-toggle="tooltip" data-bs-placement="top"
                                                                       data-bs-original-title="쇼핑몰 링크"><i
                                                class="bi bi-cart3"></i> <span class="  item_media_link">-</span></a></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row g-0 mb-3 d-none" id="inf_loading_box">
                    <div class="loader col-md-12 text-center">Loading...</div>
                </div>
                <div class="row g-0 mb-3 d-none" id="inf_empty_box">
                    <div class="text-center">
                        <i class="bi bi-trash2" style="font-size: 6em;"></i><br />
                        <span>인플루언서 정보가 없습니다.</span>
                    </div>
                </div>
                <div class="row g-0 mb-3 d-none" id="inf_additem_box">
                    <button type="button" class="btn btn-outline-primary" id="inf_item_add">더보기</button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary" id="inf_item_selectgo">선택하기</button>
            </div>
        </div>
    </div>
</div>
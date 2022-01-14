<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="row">
    <div class="col-lg-8">
        <div class="row">
            <div class="col-xxl-3 col-md-3">
                <div class="card info-card works-card">
                    <div class="filter">
                        <a class="icon" href="/work/list" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>협업</strong> <span>| 당일</span></h5>
                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-journals"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_works_count">-</h6>
                                <span class="text-success small pt-1 fw-bold" id="admin_dh_works_percent">-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xxl-3 col-md-3">
                <div class="card info-card instagram-card">
                    <div class="filter">
                        <a class="icon" href="/work/list" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>인스타그램</strong> <span>| 당일</span></h5>
                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-instagram"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_instagram_count">-</h6>
                                <span class="text-success small pt-1 fw-bold" id="admin_dh_instagram_percent">-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xxl-3 col-md-3">
                <div class="card info-card youtube-card">
                    <div class="filter">
                        <a class="icon" href="/work/list" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>유튜브</strong> <span>| 당일</span></h5>

                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-youtube"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_youtube_count">-</h6>
                                <span class="text-success small pt-1 fw-bold" id="admin_dh_youtube_percent">-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xxl-3 col-md-3">
                <div class="card info-card blog-card">
                    <div class="filter">
                        <a class="icon" href="/work/list" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>블로그</strong> <span>| 당일</span></h5>

                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-bootstrap"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_blog_count">-</h6>
                                <span class="text-success small pt-1 fw-bold" id="admin_dh_blog_percent">-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><strong>협업 진행현황</strong> <span>| 당일</span></h5>
                    <!-- Line Chart -->
                    <div id="reportsChart"></div>
                </div>
<%--                <div class="filter">--%>
<%--                    <a class="icon" href="/work/list" aria-expanded="false"><i--%>
<%--                            class="bi bi-three-dots"></i></a>--%>
<%--                </div>--%>
            </div>
        </div>
        <div class="row">
            <div class="col-xxl-6 col-md-6">
                <div class="card info-card influencer-card">
                    <div class="filter">
                        <a class="icon" href="/influencer/list" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>인플루언서 회원</strong> <span>| 당일</span></h5>
                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-instagram"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_influencer_count">-</h6>
                                <span class="text-primary pt-1 fw-bold" id="admin_dh_influencer_percent">-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xxl-6 col-md-6">
                <div class="card info-card client-card">
                    <div class="filter">
                        <a class="icon" href="/client/list" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>협력사</strong> <span>| 당일</span></h5>

                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-building"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_client_count">-</h6>
                                <span class="text-danger pt-1 fw-bold" id="admin_dh_client_percent">-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title"><strong>가입현황</strong> <span>| 당일</span></h5>
                    <!-- Line Chart -->
                    <div id="reportsChart2"></div>
                    <!-- End Line Chart -->
                </div>
<%--                <div class="filter">--%>
<%--                    <a class="icon" href="#" aria-expanded="false"><i--%>
<%--                            class="bi bi-three-dots"></i></a>--%>
<%--                </div>--%>
            </div>
        </div>
    </div>
    <div class="col-lg-4">
        <div class="card">
            <div class="filter">
                <a class="icon" href="#"><i class="bi bi-three-dots"></i></a>
            </div>

            <div class="card-body">
                <h5 class="card-title"><strong>최근 알림내역</strong> <span>| 당일</span></h5>
                <div class="activity">
                    <div class="activity-item d-flex">
                        <div class="activite-label">32분전</div>
                        <i class="bi bi-circle-fill activity-badge text-success align-self-start"></i>
                        <div class="activity-content">
                            협업 <a href="/work/read/2">No. 2</a>가 한상민님에 의해 등록되었습니다.
                        </div>
                    </div><!-- End activity item-->

                    <div class="activity-item d-flex">
                        <div class="activite-label">56분전</div>
                        <i class="bi bi-circle-fill activity-badge text-danger align-self-start"></i>
                        <div class="activity-content">
                            협업 <a href="/work/read/1">No. 1</a>이 관리자님에 의해 취소되었습니다.
                        </div>
                    </div><!-- End activity item-->

                    <div class="activity-item d-flex">
                        <div class="activite-label">2시간전</div>
                        <i class="bi bi-circle-fill activity-badge text-primary align-self-start"></i>
                        <div class="activity-content">
                            협업 <a href="/work/read/1">No. 1</a>이 관리자님에 의해 수정되었습니다.
                        </div>
                    </div><!-- End activity item-->

                    <div class="activity-item d-flex">
                        <div class="activite-label">1일전</div>
                        <i class="bi bi-circle-fill activity-badge text-info align-self-start"></i>
                        <div class="activity-content">
                            인플루언서 신규회원 <a href="/influencer/list">북극곰(김연자)</a>님이 가입하셨습니다.
                        </div>
                    </div><!-- End activity item-->

                    <div class="activity-item d-flex">
                        <div class="activite-label">2일전</div>
                        <i class="bi bi-circle-fill activity-badge text-warning align-self-start"></i>
                        <div class="activity-content">
                            12건의 협업이 종료되었습니다.
                        </div>
                    </div><!-- End activity item-->

                </div>

            </div>
        </div>
        <div class="row">
            <div class="col-lg-6">
                <div class="card">
                    <div class="filter">
                        <a class="icon" href="/trend"><i class="bi bi-three-dots"></i></a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>네이버 트랜드</strong> <span>| 어제</span></h5>
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
            <div class="col-lg-6">
                <div class="card">
                    <div class="filter">
                        <a class="icon" href="/trend"><i class="bi bi-three-dots"></i></a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>구글 트랜드</strong> <span>| 어제</span></h5>
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
        <div class="col-lg-12">
            <div class="card">
                <div class="filter">
                    <a class="icon" href="/trend"><i class="bi bi-three-dots"></i></a>
                </div>
                <div class="card-body">
                    <h5 class="card-title"><strong>키워드 언급</strong> <span>| 당일</span></h5>
                    <div class="row">
                        <div id="polarAreaChart"></div>
                        <script>
                            document.addEventListener("DOMContentLoaded", () => {
                                new ApexCharts(document.querySelector("#polarAreaChart"), {
                                    series: [30, 27, 21, 10, 8, 6],
                                    chart: {
                                        type: 'polarArea',
                                        height: 400,
                                        toolbar: {
                                            show: false
                                        }
                                    },
                                    labels: ['뷰티', '미용', '립', '통닭', '구도로', '양념통닭'],
                                    stroke: {
                                        colors: ['#fff']
                                    },
                                    fill: {
                                        opacity: 0.8
                                    }
                                }).render();
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
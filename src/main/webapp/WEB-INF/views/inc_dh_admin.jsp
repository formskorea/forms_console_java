<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="row">
    <div class="col-lg-8">
        <div class="row">
            <div class="col-xxl-4 col-md-4">
                <div class="card info-card instagram-card">
                    <div class="filter">
                        <a class="icon" href="#" data-bs-toggle="dropdown" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" style="">
                            <li class="dropdown-header text-start">
                                <h6>정렬필터</h6>
                            </li>
                            <li><a class="dropdown-item" href="#" mc-data="1,| 당일">당일</a></li>
                            <li><a class="dropdown-item" href="#" mc-data="2,| 당월">당월</a></li>
                        </ul>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>인스타그램</strong> <span>| 당일</span></h5>
                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-instagram"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_instagram_count">12건</h6>
                                <span class="text-success small pt-1 fw-bold" id="admin_dh_instagram_percent">5%</span>
                                <span
                                        class="text-muted small pt-2 ps-1">참여율</span>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xxl-4 col-md-4">
                <div class="card info-card youtube-card">
                    <div class="filter">
                        <a class="icon" href="#" data-bs-toggle="dropdown" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" style="">
                            <li class="dropdown-header text-start">
                                <h6>정렬필터</h6>
                            </li>
                            <li><a class="dropdown-item" href="#" mc-data="1,| 당일">당일</a></li>
                            <li><a class="dropdown-item" href="#" mc-data="2,| 당월">당월</a></li>
                        </ul>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>유튜브</strong> <span>| 당일</span></h5>

                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-youtube"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_youtube_count">10건</h6>
                                <span class="text-success small pt-1 fw-bold" id="admin_dh_youtube_percent">1%</span>
                                <span
                                        class="text-muted small pt-2 ps-1">참여율</span>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xxl-4 col-md-4">
                <div class="card info-card blog-card">
                    <div class="filter">
                        <a class="icon" href="#" data-bs-toggle="dropdown" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" style="">
                            <li class="dropdown-header text-start">
                                <h6>정렬필터</h6>
                            </li>
                            <li><a class="dropdown-item" href="#" mc-data="1,| 당일">당일</a></li>
                            <li><a class="dropdown-item" href="#" mc-data="2,| 당월">당월</a></li>
                        </ul>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>블로그</strong> <span>| 당일</span></h5>

                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-bootstrap"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_blog_count">1건</h6>
                                <span class="text-success small pt-1 fw-bold" id="admin_dh_blog_percent">12%</span>
                                <span
                                        class="text-muted small pt-2 ps-1">참여율</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="card">
                <div class="filter">
                    <a class="icon" href="#" data-bs-toggle="dropdown" aria-expanded="false"><i
                            class="bi bi-three-dots"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" style="">
                        <li class="dropdown-header text-start">
                            <h6>정렬필터</h6>
                        </li>
                        <li><a class="dropdown-item" href="#" mc-data="1,| 당일">당일</a></li>
                        <li><a class="dropdown-item" href="#" mc-data="2,| 당월">당월</a></li>
                    </ul>
                </div>
                <div class="card-body">
                    <h5 class="card-title"><strong>협업 진행현황</strong> <span>| 당일</span></h5>

                    <!-- Line Chart -->
                    <div id="reportsChart"></div>

                    <script>
                        document.addEventListener("DOMContentLoaded", () => {
                            new ApexCharts(document.querySelector("#reportsChart"), {
                                series: [{
                                    name: '인스타그램',
                                    data: [31, 40, 28, 51, 42, 82, 12],
                                }, {
                                    name: '유튜브',
                                    data: [11, 32, 45, 32, 34, 52, 10]
                                }, {
                                    name: '블로그',
                                    data: [15, 11, 32, 18, 9, 24, 1]
                                }],
                                chart: {
                                    height: 350,
                                    type: 'area',
                                    toolbar: {
                                        show: false
                                    },
                                },
                                markers: {
                                    size: 4
                                },
                                colors: ['#FF0000', '#F29661', '#1DDB16'],
                                fill: {
                                    type: "gradient",
                                    gradient: {
                                        shadeIntensity: 1,
                                        opacityFrom: 0.3,
                                        opacityTo: 0.4,
                                        stops: [0, 90, 100]
                                    }
                                },
                                dataLabels: {
                                    enabled: false
                                },
                                stroke: {
                                    curve: 'smooth',
                                    width: 2
                                },
                                xaxis: {
                                    type: 'date',
                                    categories: ["2021-12-31", "2022-01-01", "2022-01-02", "2022-01-03", "2022-01-04", "2022-01-05", "2022-01-06"]
                                },
                                tooltip: {
                                    x: {
                                        format: 'yy-MM-dd'
                                    },
                                }
                            }).render();
                        });
                    </script>
                    <!-- End Line Chart -->

                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xxl-6 col-md-6">
                <div class="card info-card influencer-card">
                    <div class="filter">
                        <a class="icon" href="#" data-bs-toggle="dropdown" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" style="">
                            <li class="dropdown-header text-start">
                                <h6>정렬필터</h6>
                            </li>
                            <li><a class="dropdown-item" href="#" mc-data="1,| 당일">당일</a></li>
                            <li><a class="dropdown-item" href="#" mc-data="2,| 당월">당월</a></li>
                        </ul>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>인플루언서 회원</strong> <span>| 당일</span></h5>
                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-instagram"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_influencer_count">30명</h6>
                                <span class="text-primary pt-1 fw-bold" id="admin_dh_influencer_percent"><i class="bx bxs-arrow-from-bottom"></i> 5명</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xxl-6 col-md-6">
                <div class="card info-card client-card">
                    <div class="filter">
                        <a class="icon" href="#" data-bs-toggle="dropdown" aria-expanded="false"><i
                                class="bi bi-three-dots"></i></a>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" style="">
                            <li class="dropdown-header text-start">
                                <h6>정렬필터</h6>
                            </li>
                            <li><a class="dropdown-item" href="#" mc-data="1,| 당일">당일</a></li>
                            <li><a class="dropdown-item" href="#" mc-data="2,| 당월">당월</a></li>
                        </ul>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>협력사</strong> <span>| 당일</span></h5>

                        <div class="d-flex align-items-center">
                            <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                <i class="bi bi-building"></i>
                            </div>
                            <div class="ps-3">
                                <h6 id="admin_dh_client_count">13명</h6>
                                <span class="text-danger pt-1 fw-bold" id="admin_dh_client_percent"><i class="bx bxs-arrow-from-top"></i> 1명</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="card">
                <div class="filter">
                    <a class="icon" href="#" data-bs-toggle="dropdown" aria-expanded="false"><i
                            class="bi bi-three-dots"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow" style="">
                        <li class="dropdown-header text-start">
                            <h6>정렬필터</h6>
                        </li>
                        <li><a class="dropdown-item" href="#" mc-data="1,| 당일">당일</a></li>
                        <li><a class="dropdown-item" href="#" mc-data="2,| 당월">당월</a></li>
                    </ul>
                </div>
                <div class="card-body">
                    <h5 class="card-title"><strong>가입현황</strong> <span>| 당일</span></h5>

                    <!-- Line Chart -->
                    <div id="reportsChart2"></div>

                    <script>
                        document.addEventListener("DOMContentLoaded", () => {
                            new ApexCharts(document.querySelector("#reportsChart2"), {
                                series: [{
                                    name: '인플루언서',
                                    data: [15, 20, 19, 25, 27, 25, 30],
                                }, {
                                    name: '협력사',
                                    data: [4, 5, 8, 10, 12, 14, 13]
                                }],
                                chart: {
                                    height: 350,
                                    type: 'area',
                                    toolbar: {
                                        show: false
                                    },
                                },
                                markers: {
                                    size: 4
                                },
                                colors: ['#BC30F7', '#11cccc'],
                                fill: {
                                    type: "gradient",
                                    gradient: {
                                        shadeIntensity: 1,
                                        opacityFrom: 0.3,
                                        opacityTo: 0.4,
                                        stops: [0, 90, 100]
                                    }
                                },
                                dataLabels: {
                                    enabled: false
                                },
                                stroke: {
                                    curve: 'smooth',
                                    width: 2
                                },
                                xaxis: {
                                    type: 'date',
                                    categories: ["2021-12-31", "2022-01-01", "2022-01-02", "2022-01-03", "2022-01-04", "2022-01-05", "2022-01-06"]
                                },
                                tooltip: {
                                    x: {
                                        format: 'yy-MM-dd'
                                    },
                                }
                            }).render();
                        });
                    </script>
                    <!-- End Line Chart -->

                </div>
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
                        <a class="icon" href="#"><i class="bi bi-three-dots"></i></a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>네이버 트랜드</strong> <span>| 어제</span></h5>
                        <div class="row">
                            <ol class="list-group list-group-numbered">
                                <li class="list-group-item">트랜드1</li>
                                <li class="list-group-item">트랜드2</li>
                                <li class="list-group-item">트랜드3</li>
                                <li class="list-group-item">트랜드4</li>
                                <li class="list-group-item">트랜드5</li>
                                <li class="list-group-item">트랜드6</li>
                                <li class="list-group-item">트랜드7</li>
                                <li class="list-group-item">트랜드8</li>
                                <li class="list-group-item">트랜드9</li>
                                <li class="list-group-item">트랜드10</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="card">
                    <div class="filter">
                        <a class="icon" href="#"><i class="bi bi-three-dots"></i></a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><strong>구글 트랜드</strong> <span>| 어제</span></h5>
                        <div class="row">
                            <ol class="list-group list-group-numbered">
                                <li class="list-group-item">트랜드1</li>
                                <li class="list-group-item">트랜드2</li>
                                <li class="list-group-item">트랜드3</li>
                                <li class="list-group-item">트랜드4</li>
                                <li class="list-group-item">트랜드5</li>
                                <li class="list-group-item">트랜드6</li>
                                <li class="list-group-item">트랜드7</li>
                                <li class="list-group-item">트랜드8</li>
                                <li class="list-group-item">트랜드9</li>
                                <li class="list-group-item">트랜드10</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="card">
                <div class="filter">
                    <a class="icon" href="#"><i class="bi bi-three-dots"></i></a>
                </div>
                <div class="card-body">
                    <h5 class="card-title"><strong>키워드 언급</strong> <span>| 당일</span></h5>
                    <div class="row">
                        <div id="polarAreaChart"></div>
                        <script>
                            document.addEventListener("DOMContentLoaded", () => {
                                new ApexCharts(document.querySelector("#polarAreaChart"), {
                                    series: [30, 27, 21, 10, 8, 6, 3, 3, 2, 1],
                                    chart: {
                                        type: 'polarArea',
                                        height: 400,
                                        toolbar: {
                                            show: false
                                        }
                                    },
                                    labels: ['키워드1', '키워드2', '키워드3', '키워드4', '키워드5', '키워드6', '키워드7', '키워드8', '키워드9', '키워드10'],
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
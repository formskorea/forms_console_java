/**
 * Template Name: NiceAdmin - v2.1.0
 * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
 * Author: BootstrapMade.com
 * License: https://bootstrapmade.com/license/
 */
(function () {
    "use strict";

    /**
     * Easy selector helper function
     */
    const select = (el, all = false) => {
        el = el.trim()
        if (all) {
            return [...document.querySelectorAll(el)]
        } else {
            return document.querySelector(el)
        }
    }

    /**
     * Easy event listener function
     */
    const on = (type, el, listener, all = false) => {
        if (all) {
            select(el, all).forEach(e => e.addEventListener(type, listener))
        } else {
            select(el, all).addEventListener(type, listener)
        }
    }

    /**
     * Easy on scroll event listener
     */
    const onscroll = (el, listener) => {
        el.addEventListener('scroll', listener)
    }

    /**
     * Sidebar toggle
     */
    if (select('.toggle-sidebar-btn')) {
        on('click', '.toggle-sidebar-btn', function (e) {
            select('body').classList.toggle('toggle-sidebar')
        })
    }

    /**
     * Search bar toggle
     */
    if (select('.search-bar-toggle')) {
        on('click', '.search-bar-toggle', function (e) {
            select('.search-bar').classList.toggle('search-bar-show')
        })
    }

    /**
     * Navbar links active state on scroll
     */
    let navbarlinks = select('#navbar .scrollto', true)
    const navbarlinksActive = () => {
        let position = window.scrollY + 200
        navbarlinks.forEach(navbarlink => {
            if (!navbarlink.hash) return
            let section = select(navbarlink.hash)
            if (!section) return
            if (position >= section.offsetTop && position <= (section.offsetTop + section.offsetHeight)) {
                navbarlink.classList.add('active')
            } else {
                navbarlink.classList.remove('active')
            }
        })
    }
    window.addEventListener('load', navbarlinksActive)
    onscroll(document, navbarlinksActive)

    /**
     * Toggle .header-scrolled class to #header when page is scrolled
     */
    let selectHeader = select('#header')
    if (selectHeader) {
        const headerScrolled = () => {
            if (window.scrollY > 100) {
                selectHeader.classList.add('header-scrolled')
            } else {
                selectHeader.classList.remove('header-scrolled')
            }
        }
        window.addEventListener('load', headerScrolled)
        onscroll(document, headerScrolled)
    }

    /**
     * Back to top button
     */
    let backtotop = select('.back-to-top')
    if (backtotop) {
        const toggleBacktotop = () => {
            if (window.scrollY > 100) {
                backtotop.classList.add('active')
            } else {
                backtotop.classList.remove('active')
            }
        }
        window.addEventListener('load', toggleBacktotop)
        onscroll(document, toggleBacktotop)
    }

    /**
     * Initiate tooltips
     */
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })

    /**
     * Initiate quill editors
     */
    if (select('.quill-editor-default')) {
        new Quill('.quill-editor-default', {
            theme: 'snow'
        });
    }

    if (select('.quill-editor-bubble')) {
        new Quill('.quill-editor-bubble', {
            theme: 'bubble'
        });
    }

    if (select('.quill-editor-full')) {
        new Quill(".quill-editor-full", {
            modules: {
                toolbar: [
                    [{
                        font: []
                    }, {
                        size: []
                    }],
                    ["bold", "italic", "underline", "strike"],
                    [{
                        color: []
                    },
                        {
                            background: []
                        }
                    ],
                    [{
                        script: "super"
                    },
                        {
                            script: "sub"
                        }
                    ],
                    [{
                        list: "ordered"
                    },
                        {
                            list: "bullet"
                        },
                        {
                            indent: "-1"
                        },
                        {
                            indent: "+1"
                        }
                    ],
                    ["direction", {
                        align: []
                    }],
                    ["link", "image", "video"],
                    ["clean"]
                ]
            },
            theme: "snow"
        });
    }

    /**
     * Initiate Bootstrap validation check
     */
    var needsValidation = document.querySelectorAll('.needs-validation')

    Array.prototype.slice.call(needsValidation)
        .forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }

                form.classList.add('was-validated')
            }, false)
        })

    /**
     * Initiate Datatables
     */
    const datatables = select('.datatable', true)
    datatables.forEach(datatable => {
        new simpleDatatables.DataTable(datatable);
    })

    /**
     * Autoresize echart charts
     */
    const mainContainer = select('#main');
    if (mainContainer) {
        setTimeout(() => {
            new ResizeObserver(function () {
                select('.echart', true).forEach(getEchart => {
                    echarts.getInstanceByDom(getEchart).resize();
                })
            }).observe(mainContainer);
        }, 200);
    }

})();

//model make
function showModal(info, title = "") {
    if (title == "") {
        $("#fmc-alert h5").html("알림");
    }
    $("#fmc-alert .modal-body").html(info);

    $("#fmc-alert-ok").removeClass("d-none");
    $("#fmc-alert-cancel").removeClass("d-none");
    $("#fmc-alert-ok").addClass("d-none");

    $("#fmc-alert-ok").unbind("click");
    $("#fmc-alert-cancel").unbind("click");

    $("#fmc-alert-cancel").click(function (e) {
        $("#fmc-alert").modal("hide");
    });
    $("#fmc-alert").modal("show");

    $("#fmc-alert-cancel").html("확인");
}

//confilm make
function showConfilm(info, funok, funcancel, title = "", oktitle = "예", canceltitle = "아니오") {
    if (title == "") {
        $("#fmc-alert h5").html("확인");
    }
    $("#fmc-alert .modal-body").html(info);

    $("#fmc-alert-ok").removeClass("d-none");
    $("#fmc-alert-cancel").removeClass("d-none");
    $("#fmc-alert-ok").unbind("click");
    $("#fmc-alert-cancel").unbind("click");

    $("#fmc-alert-ok").click(function (e) {
        funok();
        $("#fmc-alert").modal("hide");
    });

    $("#fmc-alert-cancel").click(function (e) {
        funcancel();
        $("#fmc-alert").modal("hide");
    });

    $("#fmc-alert-ok").html(oktitle);
    $("#fmc-alert-cancel").html(canceltitle);

    $("#fmc-alert").modal("show");
}

function setCookie(key, value, expiredays = 0) {
    var todayDate = new Date();
    todayDate.setDate(todayDate.getDate() + expiredays);
    if (expiredays > 0) {
        document.cookie = key + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";";
    } else {
        document.cookie = key + "=" + escape(value) + "; path=/; ";
    }
}

function checkPass(password) {
    var rtnvalue = {};
    rtnvalue.message = "";
    rtnvalue.error = false;

    var num = password.search(/[0-9]/g);
    var eng = password.search(/[a-z]/ig);
    var spe = password.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

    if (password.length < 10 || password.length > 20) {
        rtnvalue.message = "10자리 ~ 20자리 이내로 입력해주세요.";
        rtnvalue.error = true;
    } else if (pw.search(/\s/) != -1) {
        rtnvalue.message = "비밀번호는 공백 없이 입력해주세요.";
        rtnvalue.error = true;
    } else if (num < 0 || eng < 0 || spe < 0) {
        rtnvalue.message = "영문,숫자, 특수문자 중 2가지 이상을 혼합하여 입력해주세요.";
        rtnvalue.error = true;
    }

    return rtnvalue;
}

function checkEmail(value) {
    var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
    return regEmail.test(value);
}

function priceToString(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

function comma(str) {
    str = uncomma(String(str));
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = str.replace(/[^\d]+/g, '');
    return String(str *= 1);
}

function changeDateToString(dates = new Date()) {
    var date = new Date(dates);
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2);
    var day = ('0' + date.getDate()).slice(-2);

    return year + '-' + month + '-' + day;
}

function changeStringToDate(string_date) {
    var date = string_date.replaceAll("-", "");
    console.log(date);
    return new Date(Number(date.substring(0, 4)), Number(date.substring(4, 6)) - 1, Number(date.substring(6, 8)));
}

function addDate(add, type, date) {
    var rtnvalue = new Date();
    console.log("add : " + add + " / type : " + type);
    switch (type) {
        case "year" :
            rtnvalue = date.setFullYear(date.getFullYear() + add);
            break;
        case "month" :
            rtnvalue = date.setMonth(date.getMonth() + add);
            break;
        default :
            rtnvalue = date.setDate(date.getDate() + add);
            break;
    }

    return rtnvalue;
}

function addDateString(add, type = "day", date = null) {
    var dates = date == null ? new Date : changeStringToDate(date);
    var adddate = addDate(add, type, dates);
    return changeDateToString(adddate);
}

function makeLineChart(id, series, labels, format) {
    var ac = new ApexCharts(document.querySelector(id), {
        series: series,
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
            categories: labels
        },
        tooltip: {
            x: {
                format: format
            },
        }
    });
    ac.render();
    return ac;
}
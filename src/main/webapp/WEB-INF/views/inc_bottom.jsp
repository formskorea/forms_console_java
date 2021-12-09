<%@ page import="java.util.List" %>
<%@ page import="com.formskorea.console.config.DefaultConfig" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<String> arrScript = (List<String>) request.getAttribute("scripts");
    String TOKEN = (String) request.getAttribute("token");
%>
<script>
    var fmctk = "<%=DefaultConfig.TOKEN_ISSUER%>";
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
<script src="//cdn.quilljs.com/1.3.6/quill.min.js"></script>
<script src="/vendor/simple-datatables/simple-datatables.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.6.0/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts@3.29.0/dist/apexcharts.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/echarts@5.2.2/dist/echarts.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="/js/main.js"></script>
<%
    if (arrScript != null && arrScript.size() > 0) {
        for (int i = 0; i < arrScript.size(); i++) {
            out.println("<script src=\"" + arrScript.get(i) + "\"></script>");
        }
    }
%>
<div class="modal fade" id="fmc-alert" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Vertically Centered</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
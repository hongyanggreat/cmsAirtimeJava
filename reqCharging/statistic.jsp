<%@page import="com.htc.airtime.model.AirtimeReq"%>
<%@page import="com.htc.airtime.components.Tool"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.htc.airtime.dao.ChargeDAO"%>
<%@page import="com.htc.airtime.components.MyDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<!--close-Header-part--> 

<!--top-Header-menu-->
<%@include file="../includes/topMenu.jsp" %>
<!--close-top-Header-menu--> 
<!--left-menu-stats-sidebar-->
<%@include file="../includes/mainMenu.jsp" %>
<!--close-left-menu-stats-sidebar-->
<%@include file="../includes/airTime/dataAcc.jsp" %>
<%    String actionName = "Thống kê charging";

%>
<%    // THIET LAP GIA TRI MAC DINH
    String msisdn = "";
//    String formDate = "01/" + MyDate.createDate("MM") + "/" + MyDate.createDate("yyyy");
    String formDate = MyDate.createDate("dd/MM/yyyy");
    String toDate = MyDate.createDate("dd/MM/yyyy");
    String user = "";
    String cpCode = "";
    String cpGame = "";
    String price = "";
    String status = "";
    int limit = 100;
    int offset = 0;
    int totalItem = 0;
    int pages = 1;
    int totalPage = 1;

    //LAY GIA TRI TU REQUESR 
    if (!Tool.checkNull(request.getParameter("msisdn"))) {
        msisdn = request.getParameter("msisdn");
    }
    if (!Tool.checkNull(request.getParameter("formDate"))) {
        formDate = request.getParameter("formDate");
    }
    if (!Tool.checkNull(request.getParameter("toDate"))) {
        toDate = request.getParameter("toDate");
    }
    if (!Tool.checkNull(request.getParameter("user")) && !request.getParameter("user").equals("all")) {
        user = request.getParameter("user");
    }
    if (!Tool.checkNull(request.getParameter("cpCode")) && !request.getParameter("cpCode").equals("all")) {
        cpCode = request.getParameter("cpCode");
    }
    if (!Tool.checkNull(request.getParameter("cpGame")) && !request.getParameter("cpGame").equals("all")) {
        cpGame = request.getParameter("cpGame");
    }
    if (!Tool.checkNull(request.getParameter("price")) && !request.getParameter("price").equals("0")) {
        price = request.getParameter("price");
    }
    if (!Tool.checkNull(request.getParameter("status")) && !request.getParameter("status").equals("all")) {
        status = request.getParameter("status");
    }
%>
<%  // LAY DANH SACH THONG KE CHARGE
    ChargeDAO chargeDAO = new ChargeDAO();
    ArrayList<AirtimeReq> datas = chargeDAO.getListStatistic(msisdn, formDate, toDate, user, cpCode, cpGame, price, status, arrAcc);
    session.removeAttribute("chargingStatisticExport");
    String linkExport = "";
    if (datas.size() > 0) {
        session.setAttribute("chargingStatisticExport", datas);
        linkExport = baseUrl + "/" + moduleSourse + "/exportStatistic.jsp?"
                + "msisdn=" + msisdn
                + "&formDate=" + formDate
                + "&toDate=" + toDate
                + "&user=" + user
                + "&cpCode=" + cpCode
                + "&cpGame=" + cpGame
                + "&price=" + price
                + "&status=" + status;
    }
%>
<div id="content">
    <div id="content-header">
        <%@include file="../includes/breadcrumb.jsp" %>
    </div>
    <div class="container-fluid">

        <div class="row-fluid">
            <div class="span12">
                <!-- //FORM SEARCH -->
                <%
                    String buttonSubmit = "Thống kê";
                %>
                <%@include file="../includes/airTime/_formSearch.jsp" %>
                <!-- //FORM SEARCH -->
            </div>
        </div>


        <div class="row-fluid">
            <div class="widget-box search">
                <div class="widget-content ">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <% // show du lieu 
                                    int totalSuccess = 0;
                                    int totalFail = 0;
                                    int totalAmount = 0;
                                    int totalAmountSuccess = 0;
                                    int totalAmountFail = 0;
                                    for (AirtimeReq one : datas) {
                                        String rsMps = one.getRsMps();
                                        if (!rsMps.equals("0")) {
                                            totalFail += (int) one.getTotalReq();
                                            totalAmountFail += (int) one.getTotalAmount();
                                        } else {
                                            totalSuccess += (int) one.getTotalReq();
                                            totalAmountSuccess = (int) one.getTotalAmount();

                                        }
                                        totalAmount += (int) one.getTotalAmount();

                                    }
                                %>
                                <th colspan="10" style="text-align: left">
                                    <button  class="btn ">Thống kê</button>
                                    <button  class="btn btn-success">Thành công : <%= totalSuccess%></button>
                                    <button  class="btn btn-danger">Thất bại : <%= totalFail%></button>
                                    <button  class="btn btn-success">Tổng Số tiền Success: <%= Helper.formatNumber(totalAmountSuccess)%> vnđ</button>
                                    <button  class="btn btn-danger">Tổng Số tiền Fail: <%= Helper.formatNumber(totalAmountFail)%> vnđ</button>
                                    <button  class="btn btn-primary">Tổng Số tiền : <%= Helper.formatNumber(totalAmount)%> vnđ</button>

                                </th>
                            </tr>
                            <tr>
                                <th>Stt</th>
                                <th>Tên CP</th>
                                <th>Mã CP</th>
                                <th>Game CP</th>
                                <th>Kết Quả</th>
                                <th>Tổng Số tiển</th>
                                <th>Số Request</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Stt</th>
                                <th>Tên CP</th>
                                <th>Mã CP</th>
                                <th>Game CP</th>
                                <th>Kết Quả</th>
                                <th>Tổng Số tiển</th>
                                <th>Số Request</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <% // show du lieu   
                                int i = 0;
                                for (AirtimeReq one : datas) {
                                    i++;
                                    String stt = "Thành công";
                                    String rsMps = one.getRsMps();
                                    if (!rsMps.equals("0")) {
                                        stt = "Thất bại";
                                    }
                                    String errorMess = "";
                                    if (!Tool.checkNull(one.getRsAhp())) {
                                        JSONObject errorMessObj = JSONObject.fromObject(one.getRsAhp());
                                        errorMess = errorMessObj.getString("message");
                                    }
                            %>
                            <tr class="gradeX">
                                <td style="width:30px;text-align:center"><%= i%></td>
                                <td style="text-align:center"><%= one.getUserName()%></td>
                                <td style="text-align:center"><%= one.getCpCode()%></td>
                                <td style="text-align:center"><%= one.getGameCode()%></td>
                                <td style="text-align:left" title="<%= errorMess%>"><%= stt %></td>
                                <td style="text-align:center"><%= Helper.formatNumber(one.getTotalAmount())%> VNĐ</td>
                                <td style="text-align:center"><%= Helper.formatNumber(one.getTotalReq())%></td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
</div>
</div>

<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>
<script>
    $(document).ready(function () {
        $("body").on('click', '#user', function (event) {
            event.preventDefault();
            var cpCode = $('option:selected', this).attr("cpCode");
            console.log(cpCode);
            $("#cpCode").val(cpCode).trigger('change');
            getCpGame(cpCode);
        });
        $("body").on('click', '#cpCode', function (event) {
            event.preventDefault();
            var cpCode = $(this).val();
            var user = $('option:selected', this).attr("user");
            $("#user").val(user).trigger('change');
            getCpGame(cpCode);
        });
        $("body").on('click', '#cpGame', function (event) {
            event.preventDefault();
            var cpGame = $(this).val();
            if (cpGame != "all") {
                var user = $('option:selected', this).attr("user");
                var cpCode = $('option:selected', this).attr("cpCode");
                $("#user").val(user).trigger('change');
                $("#cpCode").val(cpCode).trigger('change');
            }
        });

        function getCpGame(cpCode) {

            var l = window.location;
//            var base_url = l.protocol + "//" + l.host + "/" + l.pathname.split('/')[1];
            var base_url = l.protocol + "//" + l.host;
            var url = base_url + "/ajaxFile/cpGame.jsp";
            console.log(url);
            $.ajax({
                url: url,
                type: "post",
                dataType: "html",
                data: {cpCode: cpCode},
                beforeSend: function () {
//                    //lAM GI DE KHONG CHO DUPLEX
                },
                success: function (response) {
//                    console.log(response);
                    $("#cpGame").html(response).trigger("change");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus, errorThrown);
                }
            });
        }
    });
</script>
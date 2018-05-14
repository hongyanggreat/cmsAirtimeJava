<%@page import="com.htc.airtime.model.AirtimeReq"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.htc.airtime.dao.AirTimeDAO"%>
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
<%  //  
    String actionName = "Tất cả giao dịch";

%>
<%    // THIET LAP GIA TRI MAC DINH
    String msisdn = "";
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
    if (!Tool.checkNull(request.getParameter("pages"))) {
        String possibleNumber = request.getParameter("pages");
        boolean isNumber = Pattern.matches("[0-9]+", possibleNumber);
        if (isNumber && (Integer.parseInt(possibleNumber) > 0)) {
            pages = Integer.parseInt(possibleNumber);
        }
    }
    offset = (pages - 1) * limit;
%>
<%  // LAY DANH SACH REQ OTP    
    AirTimeDAO airTimeDAO = new AirTimeDAO();
    totalItem = airTimeDAO.countAllSearch(msisdn, formDate, toDate, user, cpCode, cpGame, price, status, arrAcc);
    totalPage = (int) Math.ceil((double) totalItem / limit);
    ArrayList<AirtimeReq> datas = airTimeDAO.getListSearch(msisdn, formDate, toDate, user, cpCode, cpGame, price, status, arrAcc, limit, offset);

    String actionPage = baseUrl + "/" + moduleSourse + "?pages=";
    String paramPage
            = "&msisdn=" + msisdn
            + "&formDate=" + formDate
            + "&toDate=" + toDate
            + "&user=" + user
            + "&cpCode=" + cpCode
            + "&cpGame=" + cpGame
            + "&price=" + price
            + "&status=" + status
            + "&offset=" + offset;
    session.removeAttribute("reqAllHistoryExport");
    String linkExport = "";
    if (datas.size() > 0) {
        session.setAttribute("reqAllHistoryExport", datas);
        linkExport = baseUrl + "/" + moduleSourse + "/exportData.jsp?"
                + "pages=" + pages
                + "&msisdn=" + msisdn
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
                    String buttonSubmit = "Tìm kiếm";
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
                            <%
                                int totalPrice = 0;
                                int totalSucces = 0;
                                int totalFail = 0;

                                for (AirtimeReq one : datas) {
                                    if (!Tool.checkNull(one.getPrice())) {
                                        totalPrice += one.getPrice();
                                    }
                                    if (!one.getRsMps().equals("4")) {
                                        totalFail += 1;
                                    } else {
                                        totalSucces += 1;
                                    }
                                }
                            %>

                            <tr>
                                <th>Stt</th>
                                <th>ID</th>
                                <th>ReqId</th>
                                <th>Thời gian</th>
                                <th>Số điện thoại</th>
                                <th>Số tiền</th>
                                <th>Mã OTP</th>
                                <th>Mã OTP CHARGE</th>
                                <th>
                                    Trạng thái:
                                    Lấy mã/Charging
                                </th>
                                <th>Mã CP</th>
                                <th>Tên CP</th>
                                <th>Mã Game</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <th>Stt</th>
                                <th>ID</th>
                                <th>ReqId</th>
                                <th>Thời gian</th>
                                <th>Số điện thoại</th>
                                <th>Số tiền</th>
                                <th>Mã OTP</th>
                                <th>Mã OTP CHARGE</th>
                                <th>
                                    Trạng thái:
                                    Lấy mã/Charging
                                </th>
                                <th>Mã CP</th>
                                <th>Tên CP</th>
                                <th>Mã Game</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <%    //
                                int i = 0;
                                for (AirtimeReq one : datas) {
                                    i++;
                                    int idService = one.getId();

                                    String stt = "Lấy mã OTP Thành công";
                                    String sttCharge = "Charging Thành công";
                                    String rsMps = one.getRsMps();
                                    System.out.println("rsMps:" + rsMps);
                                    if (!rsMps.equals("4")) {
                                        stt = "Lấy mã OTP Thất bại";
                                    }
                                    String otherInfo = one.getOtherInfo();
//                                    otherInfo = "004|034556|42";
//                                    String otherInfo = "parts0|parts1|parts2";
                                    String[] parts = otherInfo.split("#");
                                    //OTP_CHARGE
                                    String otpCharge = parts[0];
                                    //RS_MPS_CHARGE
                                    String rsMpsCharge = parts[1];
                                    //REQUEST_TIME_CHARGE
                                    String reqTimeCharge = parts[2];
                                    if (!rsMpsCharge.equals("0")) {
                                        if (Tool.checkNull(rsMpsCharge)) {
                                            sttCharge = "Không charge";
                                        }else{
                                            sttCharge = "Charging Thất bại";
                                        }
                                    }
                                    int priceRequest = 0;
                                    String priceNumber = "null";
                                    if (!Tool.checkNull(one.getPrice())) {
                                        priceRequest = one.getPrice();
                                        priceNumber = Helper.formatNumber(priceRequest) + " VNĐ";

                                    }
                                    String errorMess = "";
                                    if (!Tool.checkNull(one.getRsAhp())) {
                                        JSONObject errorMessObj = JSONObject.fromObject(one.getRsAhp());
                                        errorMess = errorMessObj.getString("message");
                                    }


                            %>
                            <tr class="gradeX">
                                <td style="width:30px;text-align:center"><%= i%></td>
                                <td style="text-align:center"><%= one.getId()%></td>
                                <td style="text-align:center"><%= one.getSysReqId()%></td>
                                <td style="text-align:center"><%= one.getReqTime()%></td>
                                <td style="text-align:left"><%= one.getMsisdn()%></td>
                                <td style="text-align:left"><%= priceNumber%></td>
                                <td style="text-align:center" title="MÃ CODE <%= one.getOtp()%>"><%= one.getOtp()%></td>
                                <td style="text-align:center" title="MÃ CODE <%= otpCharge%>"><%= otpCharge%></td>
                                <td style="text-align:left" title="<%= errorMess%>"><%= stt + "/" + sttCharge%></td>
                                <td style="text-align:center"><%= one.getCpCode()%></td>
                                <td style="text-align:center"><%= one.getUserName()%></td>
                                <td style="text-align:center"><%= one.getGameCode()%></td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
                <div class="pagination alternate" style="text-align: center">
                    <ul>
                        <%@include file="../includes/paginator.jsp" %>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>
<script src ="<%= baseUrl%>/resource/myJs/myScript.js?v=1.0.1"></script> 
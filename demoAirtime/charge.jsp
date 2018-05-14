<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.htc.airtime.model.AirTimeRequest"%>
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
<%    String actionName = "Demo charge dịch vụ Air Time";
%>
<%
    String cpCode = "";
    String user = "";
    String accesskey = "";
    String cpGame = "";
    String msisdn = "";
    String price = "";
    String cpRequestId = "";
    String code = "";
    String message = "";
    AirTimeRequest airTimeRequest = (AirTimeRequest) session.getAttribute("dataGet");
    if (airTimeRequest != null) {
        System.out.println("CO DU LIEU NHA");
        cpCode = airTimeRequest.getCpCode();
        user = airTimeRequest.getUser();
        accesskey = airTimeRequest.getAccesskey();
        cpGame = airTimeRequest.getCpGame();
        msisdn = airTimeRequest.getMsisdn();
        price = airTimeRequest.getPrice();
        cpRequestId = airTimeRequest.getCpRequestId();
        try {
            JSONObject rsJson = JSONObject.fromObject(airTimeRequest.getResult());
            code = rsJson.getString("code");
            message = rsJson.getString("message");

        } catch (Exception e) {
            System.out.println("KHONG PHAI CHUOI JSON");
        }
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
                <form action="<%= baseUrl%>/processChargeAirTime" name="myform" method="get" class="form-horizontal">
                    <div class="widget-box search">
                        <div class="widget-content ">
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <%
                                        String mess = "Vui lòng lấy Mã Otp trước!";
                                        if (!Tool.checkNull(session.getAttribute("mess"))) {
                                            mess = (String) session.getAttribute("mess");
                                            session.removeAttribute("mess");
                                        }

                                    %>
                                    <tr>
                                        <td style="text-align: center;">
                                            <%= mess%>
                                            <br/>
                                            <%= code + " - " + message%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">
                                            Nhập Mã cpRequestId: <input type="text" name="cpRequestId" value="<%= cpRequestId%>" placeholder="Nhập Mã cpRequestId">
                                            Nhập Mã OTP: <input type="text" name="otp" value="" placeholder="Nhập Mã Otp">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">
                                            Nhập CP Code: <input type="text" name="cpCode" value="<%= cpCode%>" placeholder="Nhập cpCode">
                                            Nhập User Name : <input type="text" name="user" value="<%= user%>" placeholder="Nhập user">
                                            Nhập Mã Truy Cập: <input type="text" name="accesskey" value="<%= accesskey%>" placeholder="Nhập Mat khau">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">
                                            Nhập cpGame : <input type="text" name="cpGame" value="<%= cpGame%>" placeholder="Nhập cpGame">
                                            Nhập Sdt :<input type="text" name="msisdn" value="<%= msisdn%>" placeholder="Nhập số điện thoại">
                                            Nhập giá :<input type="text" name="price" value="<%= price%>" placeholder="Nhập Giá">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <button type="submit" name="charge" class="btn btn-success">Charge</button>
                                        </th>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </form>
                <!-- //FORM SEARCH -->
            </div>
        </div>
    </div>
</div>
</div>
<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>

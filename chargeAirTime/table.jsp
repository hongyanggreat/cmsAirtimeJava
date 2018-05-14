<%-- 
    Document   : table
    Created on : Sep 18, 2017, 12:39:25 AM
    Author     : Admin
--%>

<%@page import="com.htc.airtime.components.Tool"%>
<%@page import="com.htc.airtime.components.Helper"%>
<%@page import="com.htc.airtime.model.ChargeAirTime"%>
<%@page import="com.htc.airtime.dao.ChargeAirTimeDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table class="table table-bordered data-table">
    <thead>
        <tr>
            <th>Stt</th>
            <th>ID</th>
            <th>Thời gian</th>
            <th>Số điện thoại</th>
            <th>Số tiền</th>
            <th>Mã OTP</th>
            <th>Trạng thái</th>
            <th>Mã CP</th>
            <th>Tên CP</th>
            <th>Mã Game</th>
        </tr>
    </thead>
    <tbody>
        <%
            int i = 0;
            for (ChargeAirTime dt : dts) {
                i++;
                int idService = dt.getID();

                String status = "Thành công";
                String rsMps = dt.getRS_MPS();
                if (!rsMps.equals("0")) {
                    status = "Thất bại";
                }
                int priceRequest = 0;
                String priceNumber = "null";
                if (!Tool.checkNull(dt.getPRICE())) {
                    priceRequest = dt.getPRICE();
                    priceNumber = Helper.formatNumber(priceRequest)+ " VNĐ";
                    
                }
        %>
        <tr class="gradeX">
            <td style="width:30px;text-align:center"><%= i%></td>
            <td style="width:30px;text-align:center"><%= dt.getID()%></td>
            <td style="width:30px;text-align:center"><%= dt.getREQUEST_TIME()%></td>
            <td style="width:30px;text-align:center"><%= dt.getMSISDN()%></td>
            <td style="width:30px;text-align:center"><%= priceNumber%></td>
            <td style="width:30px;text-align:center" title="Mã KH nhập vào <%= dt.getOTP()%>"><%= dt.getOTP()%></td>
            <td style="width:30px;text-align:center"><%= status%></td>
            <td style="width:30px;text-align:center"><%= dt.getCP_CODE()%></td>
            <td style="width:30px;text-align:center"><%= dt.getUSER_NAME()%></td>
            <td style="width:30px;text-align:center"><%= dt.getGAME_CODE()%></td>
        </tr>
        <% }%>
    </tbody>
</table>
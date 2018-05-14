<%-- 
    Document   : table
    Created on : Sep 18, 2017, 12:39:25 AM
    Author     : Admin
--%>

<%@page import="com.htc.airtime.components.Helper"%>
<%@page import="com.htc.airtime.model.ChargeAirTime"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<table class="table table-bordered data-table">
    <thead>
        <tr>
            <th>Stt</th>
            <th>Mã CP</th>
            <th>Tên CP</th>
            <th>Game CP</th>
            <th>Kết Quả</th>
            <th>Tổng Số tiển</th>
            <th>Số Request</th>
        </tr>
    </thead>
    <tbody>
        <%
            int i = 0;
            for (ChargeAirTime dt : dts) {
                i++;
        %>
        <tr class="gradeX">
            <td style="width:30px;text-align:center"><%= i%></td>
            <td style="wtext-align:center"><%= dt.getCP_CODE() %></td>
            <td style="wtext-align:center"><%= dt.getUSER_NAME()%></td>
            <td style="wtext-align:center"><%= dt.getGAME_CODE()%></td>
            <td style="wtext-align:center" title="Mã code <%= dt.getRS_MPS()%>">Thành công</td>
            
            <%
                int totalAmount = Integer.parseInt(dt.getTOTAL_AMOUNT());
                int totalReq = Integer.parseInt(dt.getTOTAL_REQUEST());
            %>
            <td style="wtext-align:center"><%= Helper.formatNumber(totalAmount) %> VNĐ</td>
            <td style="wtext-align:center"><%= Helper.formatNumber(totalReq)%></td>
        </tr>
        <% }%>
    </tbody>
</table>
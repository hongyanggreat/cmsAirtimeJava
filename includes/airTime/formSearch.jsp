<%-- 
    Document   : formSearch
    Created on : Sep 15, 2017, 11:56:57 AM
    Author     : Admin
--%>

<%@page import="com.htc.airtime.model.Account"%>
<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.model.UserServices"%>
<%@page import="com.htc.airtime.dao.UserServicesDAO"%>
<%@page import="com.htc.airtime.components.Tool"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<form action="<%= action%>" name="myform" method="get" class="form-horizontal">
    <div class="widget-box search">
        <div class="widget-content ">
            <table class="table table-bordered table-striped">
                <tbody>
                    <tr>
                        <td style="text-align: center;">
                            <% 
//                                String formatDate = "mm/dd/yyyy";
                                String formatDate = "dd/mm/yyyy";
                            %>
                            Số điện thoại:<input type="text" name="msisdn"  value="<%= msisdn%>" class="span2" placeholder="Nhập Số điện thoại" />
                            Từ ngày: <input type="text" name="formDate" value="<%= formDate%>" data-date-format="<%= formatDate%>" value="" class="datepicker span2" placeholder="Nhập ngày bắt đầu">
                            Đến ngày: <input type="text" name="toDate" value="<%= toDate%>" data-date-format="<%= formatDate%>" value="" class="datepicker span2" placeholder="Nhập ngày kết thúc">
                        </td>

                    </tr>
                    <tr>
                        <td style="text-align: center;">
                            <select class="span2 offset1 " name="price" >
                                <%
                                    LinkedHashMap<String, String> arrayPrice = new LinkedHashMap<String, String>();
                                    String[] prices = {"5", "15", "30", "50", "100"};
                                    arrayPrice.put("0", "Chọn giá tiền");
                                    for (int i = 0; i < prices.length; i++) {
                                        arrayPrice.put(prices[i], "Mệnh giá " + prices[i] + ".000 đ");
                                        //                        System.out.println("GIA TRI "+i+" Là :"+prices[i]);
                                    }
                                    System.out.println("prices arr Lenght : " + prices.length);
                                    //                        arrayResultCode.forEach((k,v) -> System.out.println("key: "+k+" =>  value:"+v));

                                    Iterator it2 = arrayPrice.entrySet().iterator();
                                    String selectedPrice = "";
                                    while (it2.hasNext()) {
                                        Map.Entry pair = (Map.Entry) it2.next();
                                        //                            System.out.println(pair.getKey() + " = " + pair.getValue());
                                        selectedPrice = "";
                                        if (pair.getKey().equals(price)) {
                                            selectedPrice = "selected";
                                        }
                                        out.println("<option value='" + pair.getKey() + "' " + selectedPrice + ">" + pair.getValue() + "</option>");
                                        it2.remove(); // avoids a ConcurrentModificationException
                                    }
                                %>
                            </select>

                            <select class="span2" name="cpCode">
                                <option value="all" selected>Chọn mã tài khoản</option>
                                <%
                                    if (dtsAccSearch != null) {
                                        for (Account dt : dtsAccSearch) {
                                            String selectedCpCode = "";
                                            if (dt.getCpCode().equals(cpCode)) {
                                                selectedCpCode = "selected";
                                            }
                                %>
                                <option value="<%= dt.getCpCode()%>" <%= selectedCpCode%>><%= dt.getCpCode()%></option>
                                <% }%>   
                                <% }%>   
                            </select>
                            <select class="span2 " name="cpName" >
                                <option value="all">Chọn Tài khoản</option>
                                <%
                                    if (dtsAccSearch != null) {
                                        for (Account dt : dtsAccSearch) {
                                            String selectedCpName = "";
                                            if (dt.getUserName().equals(cpName)) {
                                                selectedCpName = "selected";
                                            }
                                %>
                                <option value="<%= dt.getUserName()%>" <%= selectedCpName%>><%= dt.getUserName()%></option>
                                <% }%>   
                                <% }%>   
                            </select>

                            <select class="span2 " name="cpGame" >
                                <option value="all">Chọn Mã game</option>
                                <%
                                    if (dtsCodeGameSearch != null) {
                                        for (UserServices dt : dtsCodeGameSearch) {
                                            String selectedCpGame = "";
                                            if (dt.getCodeGame().equals(cpGame)) {
                                                selectedCpGame = "selected";
                                            }
                                %>
                                <option value="<%= dt.getCodeGame()%>" <%= selectedCpGame%>><%= dt.getCodeGame()%></option>
                                <% }%>   
                                <% }%>   
                            </select>
                            <select class="span2 " name="numberLimit" >
                                <%
                                    for (int i = 0; i <= 1000; i += 10) {
                                        String selectedLimit = "";
                                        if (i > 0) {
                                            if (i == limit) {
                                                selectedLimit = "selected";
                                            }

                                %>  
                                <option value="<%= i%>" <%= selectedLimit%>><%= i%> bản ghi</option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <button type="submit" name="searchResponseAirTime" class="btn btn-success">Thống kê / Tìm kiếm</button>
                            <button type="button" name="searchResponseAirTime" class="btn" style="float:none">
                                <span class="icon"><a class="" href="<%= actionExp%>" target="_blank" title="Xuất File excel" style="padding:0 2px;">
                                        <img  width="20" src="<%= baseUrl%>/resource/images/icon/download.png" alt=""> Download</a>
                                </span>
                            </button>
                        </th>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</form>
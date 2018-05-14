<%-- 
    Document   : formSearch
    Created on : Sep 15, 2017, 11:56:57 AM
    Author     : Admin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    .table.search{
        border: 0px;
    }
    .table.search th{
        border: 0px;
        background-color: #f9f9f9;
    }
    .widget-box.search {
        border: 0px;
    }
</style>

<%
    AccountDAO accSearch = new AccountDAO();
    ArrayList<Account> dtsSearch = accSearch.getListByField("STATUS", 1);
%>
<form action="<%= action%>" name="myform" method="post" class="form-horizontal">
<table class="table table-bordered table-striped">
    <tbody>
        <tr>
            <td style="text-align: center;">
                Số điện thoại:<input type="text" name="msisdn"  value="<%= msisdn%>" class="span2" placeholder="Nhập Số điện thoại" />
                Từ ngày: <input type="text" name="formDate" value="<%= toDate%> data-date-format="dd-mm-yyyy" value="" class="datepicker span2" placeholder="Nhập ngày bắt đầu">
                Đến ngày: <input type="text" name="toDate" value="<%= toDate%>"  data-date-format="dd-mm-yyyy" class="span2" >

            </td>

        </tr>
        <tr>
            <td>
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

                <select class="span2" name="cp_code">
                    <option value="">Chọn mã tài khoản</option>
                    <%
                        int ii = 0;
                        for (Account dt : dtsSearch) {
                            ii++;
                    %>
                    <option value="<%= dt.getCpCode()%>"><%= dt.getCpCode()%></option>
                    <% }%>   
                </select>
                <select class="span2 " name="cp_name" >
                    <option value="">Chọn Tài khoản</option>
                    <%
                        int ij = 0;
                        for (Account dt : dtsSearch) {
                            ij++;
                    %>
                    <option value="<%= dt.getUserName()%>"><%= dt.getUserName()%></option>
                    <% }%>   
                </select>
                <select class="span2 " name="cpGame" >
                    <option value="">Chọn Mã game</option>
                    <%
                        int ik = 0;
                        for (Account dt : dtsSearch) {
                            ik++;
                    %>
                    <option value="<%= dt.getUserName()%>"><%= dt.getUserName()%></option>
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
            </th>
        </tr>
    </tbody>
</table>
</form>
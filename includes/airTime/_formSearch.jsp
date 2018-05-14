<%-- 
    Document   : formSearch
    Created on : Sep 15, 2017, 11:56:57 AM
    Author     : Admin
--%>

<%@page import="com.htc.airtime.dao.OtpDAO"%>
<%@page import="com.htc.airtime.thread.AccountCacheManager"%>
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

<style>
    .visibility{
        visibility: hidden;
    }
</style>
<form action="" name="myform" method="get" class="form-horizontal">
    <div class="widget-box search">
        <div class="widget-content ">
            <table class="table table-bordered table-striped">
                <tbody>
                    <%
                        if (!Tool.checkNull(session.getAttribute("mess"))) {
                    %>
                    <tr>
                        <td style="text-align: center;">
                            <%= session.getAttribute("mess")%>
                        </td>
                    </tr>
                    <% //
                            session.removeAttribute("mess");
                        }

                    %>
                    <% //LAY TAI ACC CACHE
                        String selected = "";
                        String formatDate = "dd/mm/yyyy";
                    %>
                    <tr>
                        <td style="text-align: center;">
                            Nhập số điện thoại :<input type="text" name="msisdn" value="<%= msisdn%>" placeholder="Nhập số điện thoại">
                            Từ ngày: <input type="text" name="formDate" value="<%= formDate%>" data-date-format="<%= formatDate%>" value="" class="datepicker span2" placeholder="Nhập ngày bắt đầu">
                            Đến ngày: <input type="text" name="toDate" value="<%= toDate%>" data-date-format="<%= formatDate%>" value="" class="datepicker span2" placeholder="Nhập ngày kết thúc">
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center;">
                            <select class="span2 invisible" name="cpCode" id="cpCode">
                                <option value="all" user="all" >Chọn Mã Tài khoản</option>
                                <%
                                    if (arrAcc != null) {
                                        for (Account one : arrAcc) {
                                            selected = "";
                                            if (cpCode.equals(one.getCpCode())) {
                                                selected = "selected";
                                            }
                                %>
                                <option <%= selected%> value="<%= one.getCpCode()%>" user="<%= one.getUserName()%>"  ><%= one.getCpCode()%></option>
                                <% }
                                    } %>
                            </select>
                            <select class="span2" name="user" id="user">
                                <option value="all" cpCode="all">Chọn Tài khoản</option>
                                <%
                                    if (arrAcc != null) {
                                        for (Account one : arrAcc) {
                                            selected = "";
                                            if (user.equals(one.getUserName())) {
                                                selected = "selected";
                                            }
                                %>
                                <option <%= selected%> value="<%= one.getUserName()%>" cpCode="<%= one.getCpCode()%>"><%= one.getUserName()%></option>
                                <% }
                                    } %>
                            </select>
                            <select class="span3" name="cpGame" id="cpGame">
                                <%
                                    UserServicesDAO userSv = new UserServicesDAO();
                                    ArrayList<UserServices> dts = null;
//                                    dts = userSv.getListByField("STATUS", 1);
                                    dts = userSv.getListByField("STATUS", "1", arrAcc);
                                    if (dts != null && dts.size() > 0) {
                                %>
                                <option value="all" user="all" cpCode="all" >Chọn mã game</option>
                                <%
                                    for (UserServices dt : dts) {

                                        selected = "";
                                        if (cpGame.equals(dt.getCodeGame())) {
                                            selected = "selected";
                                        }
                                %>
                                <option <%= selected%> value="<%= dt.getCodeGame()%>" user="<%= dt.getUserName()%>" cpCode="<%= dt.getCpCode()%>"><%= dt.getCodeGame()%> - <%= dt.getGameName()%></option>
                                <%        }
                                } else {

                                %>
                                <option value="all">Không có dữ liệu</option>
                                <%    }
                                %>
                            </select>
                            <select class="span2" name="price" id="price">
                                <%  //
                                    LinkedHashMap<String, String> arrayPrice = new LinkedHashMap<String, String>();
                                    String[] prices = {"5", "15", "30", "50", "100"};
                                    arrayPrice.put("0", "Chọn mệnh giá tiền");
                                    for (int i = 0; i < prices.length; i++) {
                                        arrayPrice.put(prices[i], "Mệnh giá " + prices[i] + ".000 đ");
                                        //                        System.out.println("GIA TRI "+i+" Là :"+prices[i]);
                                    }
                                    System.out.println("prices arr Lenght : " + prices.length);
                                    System.out.println("arrayPrice Lenght : " + arrayPrice.size());
                                    //                        arrayResultCode.forEach((k,v) -> System.out.println("key: "+k+" =>  value:"+v));

                                    Iterator it2 = arrayPrice.entrySet().iterator();
                                    String selectedPrice = "";
                                    while (it2.hasNext()) {
                                        Map.Entry pair = (Map.Entry) it2.next();
                                        //                            System.out.println(pair.getKey() + " = " + pair.getValue());
                                        selectedPrice = "";
                                        System.out.println("GIA TIEN :" + price);
                                        if ((pair.getKey()).equals(price)) {
                                            selectedPrice = "selected";
                                        }
                                        out.println("<option value='" + pair.getKey() + "' " + selectedPrice + ">" + pair.getValue() + "</option>");
                                        it2.remove(); // avoids a ConcurrentModificationException
                                    }
                                %>
                            </select>
                            <select class="span2" name="status" id="status">
                                <option value="all">Trạng thái charge</option>
                                <option value="SUCCESS" <%
                                    if ("SUCCESS".equals(status)) {
                                        out.print("selected='selected'");
                                    }
                                        %>>Thành công</option>
                                <option value="FAIL" <%
                                    if ("FAIL".equals(status)) {
                                        out.print("selected='selected'");
                                    }
                                        %>>Thất bại</option>
                            </select>

                        </td>
                    </tr>

                    <tr>
                        <td style="text-align: center;">
                            <button type="submit" class="btn btn-success"><%= buttonSubmit%></button>
                            <%
                                if (!Tool.checkNull(linkExport)) {
                            %>
                            <a href="<%= linkExport%>" class="btn btn-success" target="_blank">Xuất Excel</a>
                            <%}%>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
    </div>

</form>
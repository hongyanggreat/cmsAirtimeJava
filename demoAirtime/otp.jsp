<%@page import="com.htc.airtime.dao.UserServicesDAO"%>
<%@page import="com.htc.airtime.model.UserServices"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.htc.airtime.thread.AccountCacheManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Iterator"%>
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
<%    String actionName = "Demo Lấy Mã OTP dịch vụ AirTime";

%>
<%//    String cpCode = "";
//    String user = "";
//    String accesskey = "";
//    String cpGame = "";
//    String msisdn = "";
//    String price = "";
    String cpCode = "PFFC3";
    String user = "ahp";
    String accesskey = "FYp7acheY9uCMxbVyv";
    String cpGame = "PS3";
    String msisdn = "8496493366";
    String price = "5000";
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
                <form action="<%= baseUrl%>/processOtpAirTime" name="myform" method="get" class="form-horizontal">
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
                                            <br/>
                                            <%= code + " - " + message%>
                                            <br/>
                                            <%= airTimeRequest.getResult()%>
                                        </td>
                                    </tr>
                                    <% //
                                            session.removeAttribute("mess");
                                        }

                                    %>
                                    <% //LAY TAI ACC CACHE
                                        String selected = "";
                                    %>
                                    <%@include file="../includes/airTime/dataAcc.jsp" %>
                                    <tr>
                                        <td style="text-align: center;">
                                            <select class="span2" name="user" id="user">
                                                <option value="all" cpCode="all">Chọn Tài khoản</option>
                                                <%                                                    if (arrAcc != null) {
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
                                            <select class="span2" name="cpCode" id="cpCode">
                                                <option value="all" user="all">Chọn Mã Tài khoản</option>
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
                                            <select class="span2" name="cpGame" id="cpGame">
                                                <%
                                                    UserServicesDAO userSv = new UserServicesDAO();
                                                    ArrayList<UserServices> dts = null;
                                                    dts = userSv.getListByField("STATUS", 1);
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
                                                        if ((pair.getKey() + "000").equals(price)) {
                                                            selectedPrice = "selected";
                                                        }
                                                        out.println("<option value='" + pair.getKey() + "' " + selectedPrice + ">" + pair.getValue() + "</option>");
                                                        it2.remove(); // avoids a ConcurrentModificationException
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">
                                            Nhập số điện thoại :<input type="text" name="msisdn" value="<%= msisdn%>" placeholder="Nhập số điện thoại">
                                            Nhập Mã Truy Cập: <input type="text" name="accesskey" value="<%= accesskey%>" placeholder="Nhập Mat khau">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;">
                                            <button type="submit" name="getOtp" class="btn btn-success">Lấy mã OTP</button>
                                        </td>
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
<script src ="<%= baseUrl%>/resource/myJs/myScript.js?v=1.0.1"></script> 
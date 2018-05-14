<%@page import="com.htc.airtime.model.ChargeOnline"%><%@page import="com.htc.airtime.dao.ChargeOnlineDAO"%><%@page import="com.htc.airtime.dao.UserServicesDAO"%><%@page import="com.htc.airtime.model.UserServices"%><%@page import="net.sf.json.JSONArray"%><%@page import="java.util.ArrayList"%><%@page import="com.htc.airtime.thread.AccountCacheManager"%><%@page import="java.util.Map"%><%@page import="java.util.LinkedHashMap"%><%@page import="java.util.Iterator"%><%@page import="java.util.Iterator"%><%@page import="net.sf.json.JSONObject"%><%@page import="com.htc.airtime.model.AirTimeRequest"%><%@page contentType="text/html" pageEncoding="UTF-8"%><%@include file="../includes/head.jsp" %><%@include file="common.jsp" %>
<!--close-Header-part--> 
<style>
    .visibility{
        visibility: hidden;
    }
    .dataTables_length,.dataTables_filter{
        top: 165px;
    }
    .dataTables_length{
        right: 25px;
    }
    .dataTables_filter{
        left: 35px;
    }
    .table-bordered th, .table-bordered td{
        border-left: 0px;
        border-top: 0px;
    }
</style>
<!--top-Header-menu-->
<%@include file="../includes/topMenu.jsp" %>
<!--close-top-Header-menu--> 
<!--left-menu-stats-sidebar-->
<%@include file="../includes/mainMenu.jsp" %>
<!--close-left-menu-stats-sidebar-->
<%    String actionName = "Demo Lấy Mã OTP dịch vụ AirTime";

%>
<%//   
    String user = "";
    String cpCode = "";
    String accesskey = "";
    String cpGame = "";
    String msisdn = "";
    String price = "";

    //LAY DU LIEU MAC DINH KHI TK LOGIN : idUser
    UserServicesDAO userServices = new UserServicesDAO();
    UserServices dtAccReg = userServices.viewByField("USERNAME", nameUser);
    System.out.println("====================START: CHO NAY LA NOI BAT DAU CUA DU LIEU TK LOGIN");

//    if (!Tool.checkNull(dtAccReg.getGameName())) {
//        accesskey = dtAccReg.getGameName();
//    }
//    String cpCode = "PFFC3";
//    String user = "ahp";
//    String accesskey = "FYp7acheY9uCMxbVyv";
//    String cpGame = "PS3";
//    String msisdn = "8496493366";
//    String price = "5000";
//    String code = "";
//    String message = "";
    System.out.println("====================END: CHO NAY LA NOI BAT DAU CUA DU LIEU TK LOGUIN");
//    AirTimeRequest airTimeRequest = (AirTimeRequest) session.getAttribute("dataGet");
//    if (airTimeRequest != null) {
//        System.out.println("CO DU LIEU NHA");
//        cpCode = airTimeRequest.getCpCode();
//        user = airTimeRequest.getUser();
//        accesskey = airTimeRequest.getAccesskey();
//        cpGame = airTimeRequest.getCpGame();
//        msisdn = airTimeRequest.getMsisdn();
//        price = airTimeRequest.getPrice();
//        try {
//            JSONObject rsJson = JSONObject.fromObject(airTimeRequest.getResult());
//            code = rsJson.getString("code");
//            message = rsJson.getString("message");
//
//        } catch (Exception e) {
//            System.out.println("KHONG PHAI CHUOI JSON");
//        }
//
//    }
%>

<%
    ChargeOnlineDAO chargeOnlineDAO = new ChargeOnlineDAO();
    int limit = 100;
    //    ArrayList<ChargeOnline> datas = chargeOnlineDAO.getListSearch(limit);
    ArrayList<ChargeOnline> datas = chargeOnlineDAO.getListSearch(idUser, limit);
%>
<div id="content">
    <div id="content-header">
        <%@include file="../includes/breadcrumb.jsp" %>
    </div>
    <div class="container-fluid">

        <div class="row-fluid">
            <div class="span12">
                <!-- //FORM SEARCH -->

                <form action="<%= baseUrl%>/uploadFilePhone" name="myform" id="myform" method="post" class="form-horizontal" enctype="multipart/form-data">
                    <div class="widget-box search">
                        <div class="widget-content ">
                            <div style="text-align: center;display: none" id="notification">
                                <% String mess = (String) session.getAttribute("mess"); %>
                                <% if (!Tool.checkNull(mess)) {
                                        out.println(mess);
                                    } %>
                            </div>
                            <table class="table table-bordered table-striped">
                                <tbody>
                                    <%
                                        int colspan = 4;
                                        if (!Tool.checkNull(session.getAttribute("mess"))) {
                                    %>
                                    <tr>
                                        <td style="text-align: center;" colspan="<%=colspan%>">
                                            <%= session.getAttribute("mess")%>
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
                                        <td style="text-align: center;" colspan="<%=colspan%>">
                                            <input type="hidden" class="visibility" id="deleteDataOld" name="deleteDataOld">
                                            <select class="span2 invisible" name="cpCode" id="cpCode">
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
                                            <select class="span2" name="cpGame" id="cpGame">
                                                <%
                                                    UserServicesDAO userSv = new UserServicesDAO();
                                                    ArrayList<UserServices> dts = null;
                                                    dts = userSv.getListByField("STATUS", "1",arrAcc);
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
                                                <option <%= selected%> value="<%= dt.getCodeGame()%>"   user="<%= dt.getUserName()%>" cpCode="<%= dt.getCpCode()%>" ak="<%= dt.getAccessKey()%>"><%= dt.getCodeGame()%> - <%= dt.getGameName()%></option>
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
                                            <!--Nhập Mã Truy Cập:--> 
                                            <input class="invisible" type="text" name="accesskey" value="<%= accesskey%>" id="accesskey" placeholder="Nhập Mat khau" class="">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center;" colspan="<%=colspan%>">
                                            Nhập lên từ 1 số điện thoại: <input type="text" id="phoneNumber" name="phoneNumber" value="" placeholder="Nhập vào 1 số điện thoại">
                                            ::::
                                            Nhập lên từ 1 danh sách: <input type="file" id="fileUpload" name="fileUpload">
                                            <p id="errorAddPhoneNumber"></p>
                                            <!--<button type="button"  name="delelePhone" id="delelePhone" class="btn btn-danger" >Thêm Mới</button>-->
                                            <button type="button"  name="importFile" id="importFile" class="btn btn-danger" >Thêm Mới</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <table class="table table-bordered data-table">
                                <thead>
                                    <tr>
                                        <th style="height: 30px;">
                                        </th>
                                        <th>

                                        </th>
                                        <th class="hide"></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (ChargeOnline one : datas) {
                                            int priceRequest = 0;
                                            String priceNumber = "null";
                                            if (!Tool.checkNull(one.getPrice())) {
                                                priceRequest = Integer.parseInt(one.getPrice() + "000");
                                                priceNumber = Helper.formatNumber(priceRequest) + " VNĐ";

                                            }
                                    %>
                                    <tr>
                                        <td style="text-align: right;">
                                            <!--<button type="button" name="delPhone" id="delPhone" currentId="<%= one.getId()%>" class="btn btn-small btn-primary" msisdn="<%= one.getMisidn()%>" user="<%= one.getUserName()%>" cpCode="<%= one.getCpCode()%>" cpGame="<%= one.getGameCode()%>" accesskey="<%= one.getAccessKey()%>" price="<%= one.getPrice()%>" reqId="<%= "cms_" + Tool.getRandomString(11)%>">Xóa</button>-->
                                            Nhập số điện thoại :
                                            <input type="text" name="msisdn" value="<%= one.getMisidn()%>" placeholder="Nhập số điện thoại" title="Số điện thoại" readonly>
                                            <button type="button" name="getOtp" id="getOtp" currentId="<%= one.getId()%>" class="btn btn-small btn-primary" msisdn="<%= one.getMisidn()%>" user="<%= one.getUserName()%>" cpCode="<%= one.getCpCode()%>" cpGame="<%= one.getGameCode()%>" accesskey="<%= one.getAccessKey()%>" price="<%= one.getPrice()%>" reqId="<%= "cms_" + Tool.getRandomString(11)%>">Lấy mã</button>
                                            <p id="error<%= one.getMisidn()%>">
                                                <!--Noi dung loi hien thi o day duoc khong-->
                                            </p>
                                        </td>
                                        <td class="hide"><%= one.getMisidn()%></td>
                                        <td>

                                            <button type="button" class="btn btn-small btn-danger" > Giá tiền : <%= priceNumber%></button>
                                            <button type="button" name="loading" id="loading<%= one.getMisidn()%>" class="btn btn-small btn-warning visibility" >Đang chờ</button>
                                        </td>
                                        <td style="text-align: left;">
                                            <input type="text" name="otpCode"  id="otpCode<%= one.getMisidn()%>" class="visibility" value="" placeholder="Nhập mã OTP" readonly title="Nhập mã OTP">
                                            <button type="button" name="chargeOtp" id="chargeOtp<%= one.getMisidn()%>" class="btn btn-small btn-primary visibility" disabled="" >Charge</button>
                                            <p id="errorCharge<%= one.getMisidn()%>" class="visibility">
                                                <!--Thông báo cho nguo dung trang thai charge-->
                                            </p>    
                                        </td>

                                    </tr>
                                    <%}%>
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
<script src ="<%= baseUrl%>/resource/myJs/myScript.js?v=1.0.3"></script> 

<script>

    $(document).ready(function () {
        /* Act on the event */
        var l = window.location;
        var base_url = l.protocol + "//" + l.host;
        var url = base_url + "/sendOtp";

        function builPhone84(phone) {
            var firstLetter = "";
            var strPhone = "";
            firstLetter = phone.substring(0, 1);
            firstLetter = phone.substring(0, 1);
            if (firstLetter == "0") {
                strPhone = "84";
                strPhone += phone.substring(1);
            } else {
                strPhone = phone;
            }
            return strPhone;
        }
        $('body').on('click', '#importFile', function (event) {
            event.preventDefault();
//            if (confirm("Bạn có muốn xóa dữ liệu cũ không?")) {
//                // your deletion code
//                $('#deleteDataOld').prop('type', 'radio').prop('checked', true);
//            }
            $('#deleteDataOld').prop('type', 'radio');
            if (!confirm("Bạn có muốn giữ lại dữ liệu cũ không?")) {
                // your deletion code
                $('#deleteDataOld').prop('checked', true);
            }else{
                $('#deleteDataOld').prop('checked', false);
            }
            $('#myform').submit();
        });
        $('body').on('click', 'button[name="getOtp"]', function (event) {
            event.preventDefault();

            var event = $(this).attr("event");
            if (event === "on") {
                console.log("Khong thuc hien");
                return;
            }
            console.log("thuc hien");
            var currentid = $(this).attr("currentid");
            var msisdn = $(this).attr("msisdn");
            var user = $(this).attr("user");
            var cpCode = $(this).attr("cpCode");
            var cpGame = $(this).attr("cpGame");
            var accesskey = $(this).attr("accesskey");
            var price = $(this).attr("price");
            var cpRequestId = $(this).attr("reqId");
            var otp = 1;
//            console.log(user);
//            console.log(cpCode);
//            console.log(cpgame);
//            console.log(price);
//            console.log(accesskey);
//            console.log(msisdn);
//            console.log(cpRequestId);
//            console.log(otp);
//            console.log(url);
            var myMisidn = $('button[msisdn="' + msisdn + '"]');
            $.ajax({
                url: url,
                type: "post",
                //                dataType: "html",
                dataType: "json",
                data: {currentid: currentid, user: user, cpCode: cpCode, cpGame: cpGame, price: price, accesskey: accesskey, msisdn: msisdn, cpRequestId: cpRequestId, otp: otp},
                beforeSend: function () {
                    myMisidn.attr("event", "on").html("loading...");
                },
                success: function (response) {
                    console.log(response);
                    console.log("response.code:" + response.code);
                    if (response.code === "04") {
                        myMisidn.html("Lấy mã thành công");
                        myMisidn.removeClass("btn-primary").addClass("btn-success").siblings("input").attr('readonly', "readonly");
                        $('#error' + msisdn).html("Bạn đã gửi yêu cầu lấy mã Otp thành công");
                        //CENTER
                        $('#loading' + msisdn).removeClass("visibility").html("Nhập mã OTP");
                        $('#otpCode' + msisdn).removeClass("visibility").removeAttr("readonly");
                        $('#chargeOtp' + msisdn).removeClass("visibility").removeAttr("disabled").attr("event", "on");
                    } else {
                        myMisidn.html("Thất bại/Lấy lại");
                        myMisidn.removeAttr("event")
                        $('#error' + msisdn).html(response.message);
                        $(this).removeAttr("event");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus, errorThrown);
                }
            });
        });
//        =========================== CHARGE ===========================
        $('body').on('click', 'button[name="chargeOtp"]', function (event) {
            event.preventDefault();

            var event = $(this).attr("event");
            if (event !== "on") {
                console.log("Khong thuc hien");
                return;
            }
            console.log("thuc hien");
            var msisdn = $(this).parent().siblings().children("button").attr("msisdn");
            var myMisidn = $('button[msisdn="' + msisdn + '"]');
            console.log("msisdn:" + msisdn);

            var currentid = myMisidn.attr("currentid");
            var user = myMisidn.attr("user");
            var cpCode = myMisidn.attr("cpCode");
            var cpGame = myMisidn.attr("cpGame");
            var accesskey = myMisidn.attr("accesskey");
            var price = myMisidn.attr("price");
            var cpRequestId = myMisidn.attr("reqId");
            var otp = $(this).siblings('input[name="otpCode"]').val();

            var mybtncharge = $('button#chargeOtp' + msisdn);
            if (otp === "") {
                $('#errorCharge' + msisdn).removeClass("visibility").html("Vui lòng nhập mã Otp!");
                return;
            }
//            console.log(user);
//            console.log(cpcode);
//            console.log(cpgame);
//            console.log(price);
//            console.log(accesskey);
//            console.log(msisdn);
//            console.log(cpRequestId);
//            console.log(otp);
//            console.log(url);
            $.ajax({
                url: url,
                type: "post",
                //                dataType: "html",
                dataType: "json",
                data: {currentid: currentid, user: user, cpCode: cpCode, cpGame: cpGame, price: price, accesskey: accesskey, msisdn: msisdn, cpRequestId: cpRequestId, otp: otp},
                beforeSend: function () {
                    $('#errorCharge' + msisdn).addClass("visibility")
                    mybtncharge.removeAttr("event").html("Process...");
                },
                success: function (response) {
                    console.log(response);
                    if (response.code === "00") {
                        mybtncharge.html("Charge thành công");
                        $('#errorCharge' + msisdn).removeClass("visibility").html("Charge thành công cho số điện thoại " + msisdn);
                        mybtncharge.removeClass("btn-primary").addClass("btn-success").siblings("input").attr('readonly', "readonly");
//                        mybtncharge.removeClass("btn-primary").addClass("btn-success").siblings("input").attr('readonly', "readonly");
//                        //CENTER
//                        $('#loading' + msisdn).removeClass("visibility").html("Nhập mã OTP");
//                        $('#otpCode' + msisdn).removeClass("visibility").removeAttr("readonly");
//                        $('#chargeOtp' + msisdn).removeClass("visibility").removeAttr("disabled");
                    } else {
                        mybtncharge.html("Charge Thất bại/Charge lại");
                        $('#errorCharge' + msisdn).removeClass("visibility").html(response.message);
                        mybtncharge.attr("event", "on");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus, errorThrown);
                }
            });
        });
//        setInterval(function(){
//            var notification = $('#notification').html();
//            notification = $.trim(notification);
//            console.log(notification);
//            if(notification !== ""){
//        	$('#notification').html('');
//                alert(notification);
//            }
//    	}, 1000);
    });
</script>

<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.components.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<!--top-Header-menu-->
<%@include file="../includes/topMenu.jsp" %>
<!--close-top-Header-menu--> 
<!--left-menu-stats-sidebar-->
<%@include file="../includes/mainMenu.jsp" %>
<!--close-left-menu-stats-sidebar-->

<!--close-Header-part--> 
<%    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkList(request, session);
    Helper.cPermission(response, checkPermission);
    String actionName = "Thêm mới";
%>
<style>
    .showNotification{
        text-align: center;
        color: #d70404;
        padding: 10px;
    }
</style>

<div id="content">
    <div id="content-header">
        <%@include file="../includes/breadcrumb.jsp" %>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span7 offset2">
                <div class="widget-box">

                    <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5><%= actionName%></h5>
                        <%
                            if (account.checkList(request, session)) {
                        %>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>" title="Danh sách tài khoản" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl)%> Danh sách</a>
                        </span>
                        <%}%>


                        <%
                            String username = "";
                            String password = "";
                            String email = "";
                            String phone = "";
                            String address = "";
                            String fullname = "";
                            String description = "";
                            int userType = 0;
                            int status = 0;
                            if (session.getAttribute("accSs") != null) {
                                System.out.println("ss : " + session.getAttribute("accSs"));
                                Account dt = (Account) session.getAttribute("accSs");
                                username = dt.getUserName();
                                password = dt.getPassword();
                                email = dt.getEmail();
                                phone = dt.getPhone();
                                address = dt.getAddress();
                                description = dt.getDescription();
                                fullname = dt.getFullName();
                                status = dt.getStatus();
                                userType = dt.getUserType();
                                session.removeAttribute("accSs");
                            }
                        %>
                    </div>
                    <div class="widget-content nopadding">
                        <%
                            if (session.getAttribute("notification") != null) {
                        %>
                        <div class="showNotification" style="">
                            <% out.println(session.getAttribute("notification"));
                                session.removeAttribute("notification");

                            %>
                        </div>
                        <% }%>
                        <form action="<%= baseUrl%>/addAcc" name="myform" method="post" class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label">Tài khoản :(*)</label>
                                <div class="controls">
                                    <input type="text" name="username" value="<%= username%>" onchange="checkUserName(this)" class="span11" placeholder="Nhập tài khoản" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Mật khẩu :(*)</label>
                                <div class="controls">
                                    <input type="password" name="password" value="<%= password%>"  class="span11" placeholder="Nhập mật khẩu"  />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Họ Tên :</label>
                                <div class="controls">
                                    <input type="text" name="fullname" value="<%= fullname%>" class="span11" placeholder="Nhập họ tên" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Miêu tả:</label>
                                <div class="controls">
                                    <textarea class="span11" name="description" placeholder="Nhập miêu tả." ><%= description%></textarea>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Địa chỉ :</label>
                                <div class="controls">
                                    <input type="text" name="address" value="<%= address%>" class="span11" placeholder="Nhập địa chỉ" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Điện thoại :</label>
                                <div class="controls">
                                    <input type="text" name="phone" value="<%= phone%>" class="span11" placeholder="Nhập số điện thoại" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Email :</label>
                                <div class="controls">
                                    <input type="text" name="email" value="<%= email%>" class="span11" placeholder="Nhập số email" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Loại tài khoản</label>
                                <div class="controls">

                                    <%    //                                    
                                        if (checkTypeUser.equals("ADMIN")) {

                                    %>
                                    <label>
                                        <input type="radio" name="userType" value="<%=AccountDAO.TYPE.ADMIN.val%>" <%
                                            if (userType == AccountDAO.TYPE.ADMIN.val) {
                                                out.print("checked");
                                            }
                                               %> />
                                        <%= AccountDAO.TYPE.getname(AccountDAO.TYPE.ADMIN.val) %>
                                    </label>
                                    <label>
                                        <input type="radio" name="userType" value="<%=AccountDAO.TYPE.AGENCY_MANAGER.val%>"  <%
                                            if (userType == AccountDAO.TYPE.AGENCY_MANAGER.val) {
                                                out.print("checked");
                                            }
                                               %> />
                                        <%= AccountDAO.TYPE.getname(AccountDAO.TYPE.AGENCY_MANAGER.val) %>
                                    </label>
                                    <%}%>
                                    <%
                                        if (checkTypeUser.equals("ADMIN") || checkTypeUser.equals("AGENCY_MANAGER")) {
                                    %>
                                    <label>
                                        <input type="radio" name="userType" value="<%=AccountDAO.TYPE.AGENCY.val%>"  <%
                                            if (userType == AccountDAO.TYPE.AGENCY.val) {
                                                out.print("checked");
                                            }
                                               %> />
                                        <%= AccountDAO.TYPE.getname(AccountDAO.TYPE.AGENCY.val) %>
                                    </label>
                                    <label>
                                        <input type="radio" name="userType" value="<%=AccountDAO.TYPE.USER.val%>"  <%
                                            if (userType == AccountDAO.TYPE.USER.val) {
                                                out.print("checked");
                                            }
                                               %> />
                                        <%= AccountDAO.TYPE.getname(AccountDAO.TYPE.USER.val)%>

                                    </label>
                                    <%}%>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Trạng thái</label>
                                <div class="controls">
                                    <label>
                                        <input type="radio" name="status" value="1" <%
                                            if (status == 1) {
                                                out.print("checked");
                                            }
                                               %> />
                                        Kích hoạt</label>
                                    <label>
                                        <input type="radio" name="status" value="0" <%
                                            if (status == 0) {
                                                out.print("checked");
                                            }
                                               %> />
                                        Không kích hoạt</label>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" name="addAccount" class="btn btn-success">Lưu</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>

    </div>
</div>
</div>
<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>

<!--<script>
    function checkUserName(input) {
//   var x = document.forms["myform"]["username"].value;
//    if (x == null || x == "") {
//        alert("username cannot be empty..!!");
//        return false;
//    }
        var username = input.value;
        $.ajax({
            type: "post",
            url: "http://localhost:8084/DemoAirTime/Modules/accounts/validate/accounts.jsp", //this is my servlet
            data: "username="+username,
            success: function(msg){      
                $('#myModal').modal('show');
                $('.modal-body').html(msg);
            }
        });
    }
    function checkPassWord(input) {
//   var x = document.forms["myform"]["username"].value;
//    if (x == null || x == "") {
//        alert("username cannot be empty..!!");
//        return false;
//    }
        var password = input.value;
        $.ajax({
            type: "post",
            url: "http://localhost:8084/DemoAirTime/Modules/accounts/validate/accounts.jsp", //this is my servlet
            data: "password="+password,
            success: function(msg){      
                $('#myModal').modal('show');
                $('.modal-body').html(msg);
            }
        });
    }
    
</script>-->
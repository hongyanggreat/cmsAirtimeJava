<%-- 
    Document   : mainMenu
    Created on : Sep 5, 2017, 11:00:42 AM
    Author     : Admin
--%>

<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    AccountDAO accountPermission = new AccountDAO();

    boolean checkAccounts = true;
    boolean checkUserPermission = true;
    boolean checkModules = true;
    boolean checkServices = true;
    boolean checkAirtimeManager = true;
    boolean checkOtpAirTime = true;
    boolean checkChargeAirTime = true;
    boolean checkErrorOtpAirTime = true;
    boolean checkErrorChargeAirTime = true;

//    checkAccounts = accountPermission.checkList(request, session, "accounts");
//    checkUserPermission = accountPermission.checkList(request, session, "userPermission");
//    checkModules = accountPermission.checkList(request, session, "modules");
//    checkServices = accountPermission.checkList(request, session, "services");
//    checkAirtimeManager = accountPermission.checkList(request, session, "airtimeManager");
//    checkOtpAirTime = accountPermission.checkList(request, session, "otpAirTime");
//    checkChargeAirTime = accountPermission.checkList(request, session, "chargeAirTime");
//    checkErrorOtpAirTime = accountPermission.checkList(request, session, "errorOtpAirTime");
//    checkErrorChargeAirTime = accountPermission.checkList(request, session, "errorChargeAirTime");
%>
<div id="sidebar">
    <a href="#" class="visible-phone"><i class="icon icon-th-list"></i> Common Elements</a><ul>
        <li class="active"><a href="/"><i class="icon icon-home"></i> <span>Trang chủ</span></a> </li>
        <% if (checkTypeUser.equals("ADMIN") || checkTypeUser.equals("AGENCY_MANAGER") ) {%>
        <li class="submenu"> <a href="#"><i class="icon icon-th-list"></i> <span>Quản lý</span></a>
            <ul>
               <% if (checkTypeUser.equals("ADMIN") ) {%>
                <li class=""><a href="<%= baseUrl%>/accounts"><i class="icon icon-th-list"></i> <span>Tài khoản</span></a> </li>
               <%}%>
               <% if (checkTypeUser.equals("AGENCY_MANAGER") ) {%>
                <li class=""><a href="<%= baseUrl%>/accounts"><i class="icon icon-th-list"></i> <span>Tài khoản</span></a> </li>
               <%}%>
               <% if (checkTypeUser.equals("ADMIN") ) {%>
                <li class=""><a href="<%= baseUrl%>/modules"><i class="icon icon-th-list"></i> <span>Module</span></a> </li>
                <li class=""><a href="<%= baseUrl%>/services"><i class="icon icon-th-list"></i> <span>Dịch vụ</span></a> </li>
                <li class=""><a href="<%= baseUrl%>/airtimeManager"><i class="icon icon-th-list"></i> <span>Đăng ký dịch vụ airtime</span></a> </li>
                <li class=""><a href="<%= baseUrl%>/userPermission"><i class="icon icon-th-list"></i> <span>Phân quyền tài khoản</span></a> </li>
               <%}%>
               <% if (checkTypeUser.equals("AGENCY_MANAGER") ) {%>
                <!--//DANH CHO DAI LY-->
                <li class=""><a href="<%= baseUrl%>/userPermissionChild"><i class="icon icon-th-list"></i> <span>Phân quyền tài khoản</span></a> </li>
               <%}%>
            </ul>
        </li>
        <%}%>

        <li class=""> <a href="<%= baseUrl%>/reqAll"><i class="icon icon-th-list"></i> <span>Lịch sử Charging</span> </a>
            <ul>
                <li><a href="<%= baseUrl%>/reqOtp">OTP</a></li>
                <li><a href="<%= baseUrl%>/reqCharging">Charging</a></li>
            </ul>
        </li>
        <li class="submenu"> <a href="#"><i class="icon icon-th-list"></i> <span>Thống kê Charging</span> </a>
            <ul>
                <li><a href="<%= baseUrl%>/reqCharging/statistic.jsp">Charging</a></li>
            </ul>
        </li>
        <li class=""> <a href="<%= baseUrl%>/charging"><i class="icon icon-th-list"></i> <span>Charging</span> </a>
        </li>
    </ul>
</div>
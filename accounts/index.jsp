<%@page import="java.util.ArrayList"%>
<%@page import="com.htc.airtime.components.Tool"%>
<%@page import="com.htc.airtime.components.Helper"%>
<%@page import="com.htc.airtime.model.Account"%>
<%@page import="com.htc.airtime.dao.AccountDAO"%>

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

<%    //check LIST
    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkList(request, session);
   Helper.cPermission(response, checkPermission);

    String actionName = "Danh sách";

    ArrayList<Account> dts = null;
//    USER(0, "Người dùng"),
//        ADMIN(1, "Quyền quản trị"),
//        AGENCY(2, "Đại lý"),
//        AGENCY_MANAGER(3, "Quản lý Đại lý");
    switch (checkTypeUser) {
        case "USER":
            break;
        case "ADMIN":
            dts = account.getList();
            break;
        case "AGENCY":
            break;
        case "AGENCY_MANAGER":
            if (idUser > 0) {
                dts = account.getListAgency(idUser);
            }
            break;
        default:
            break;
    }
%>
<div id="content">
    <div id="content-header">
        <%@include file="../includes/breadcrumb.jsp" %>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title">
                        <span class="icon"><i class="icon-th"></i></span> 
                        <h5>Data table</h5>
                        <%
                            if (account.checkAdd(request, session)) {
                        %>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>/add.jsp" title="Thêm mới" style="padding:0 2px;">
                                <%= Helper.getImageIcon("add", baseUrl)%> Thêm mới</a>
                        </span>
                        <%}%>
                    </div>
                    <div class="widget-content nopadding">
                        <table class="table table-bordered data-table">
                            <thead>
                                <tr>
                                    <th>Stt</th>
                                    <th>Tài khoản</th>
                                    <th>Email</th>
                                    <th>Họ tên</th>
                                    <th>Địa chỉ</th>
                                    <th>Trạng thái</th>                  
                                    <th>Kiểu</th>                  
                                    <th>Tạo ngày</th>                  
                                    <th>Chức năng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int i = 0;
                                    int accId = 0;
                                    int parentId = 0;
                                    int userType = 0;
                                    int status = 0;
                                    String username ="";
                                    boolean checkButton = true;
                                    if (dts != null) {
                                        for (Account dt : dts) {
                                            i++;
                                            accId = dt.getAccId();
                                            parentId = dt.getParentId();
                                            userType = dt.getUserType();
                                            status = dt.getStatus();
                                            username = dt.getUserName();
                                            String imgStatus = "";
                                            if (status == 0) {
                                                imgStatus = Helper.getImageIcon("inActive", baseUrl);
                                            } else if (status == 1) {
                                                imgStatus = Helper.getImageIcon("active", baseUrl);
                                            } else {
                                                imgStatus = Helper.getImageIcon("disable", baseUrl);
                                            }
                                %>
                                <%
                                    int useType = dt.getUserType();

                                %>
                                <tr class="gradeX">
                                    <td><%= i%></td>
                                    <td><%= username%></td>
                                    <td><%= dt.getEmail()%></td>
                                    <td><%= dt.getFullName()%></td>
                                    <td><%= dt.getAddress()%></td>
                                    <td style="width:70px;text-align:center">
                                        <%= imgStatus%>
                                    </td>
                                    <td style="width:70px;text-align:center"><%= AccountDAO.TYPE.getname(useType)%></td>
                                    <td style="width:150px;text-align:center"><%= dt.getCreateDate()%></td>
                                    <%
                                        // O DAY LA CHECK XEM CO QUYEN THUC THI THEO PHAN HANG HAY KHONG
                                        System.out.println("-----------------------------------");
//                                        if ((checkTypeUser.equals("ADMIN") && ((idUser == accId) || !AccountDAO.TYPE.getType(userType).toString().equals("ADMIN"))) || (checkTypeUser.equals("AGENCY_MANAGER") && ((idUser == accId) || (idUser == parentId)))) {
                                        if ((checkTypeUser.equals("ADMIN")) || (checkTypeUser.equals("AGENCY_MANAGER") && ((idUser == accId) || (idUser == parentId)))) {
                                            System.out.println("********TAI KHOAN CUA BAN -DUOC PHEP CAP NHAT TAI KHOAN "+username);
                                        } else {
                                            System.out.println("idUser : " + idUser);
                                            System.out.println("accId : " + accId);
                                            System.out.println("parentId : " + parentId);
                                            System.out.println("***********TAI KHOAN CUA BAN - KHONG PHEP CAP NHAT TAI KHOAN "+username);
                                            checkButton = false;
                                        }
                                    %>
                                    <td style="width:200px;text-align:center">

                                        <% if (account.checkView(request, session) && checkButton) {%>
                                        <a href="<%= baseUrl%>/<%= moduleSourse%>/view.jsp?id=<%= dt.getAccId()%>"><%= Helper.getImageIcon("view-details", baseUrl)%> Xem</a></a>
                                        <%}%>
                                        <% if (account.checkEdit(request, session) && checkButton) {%>
                                        <a href="<%= baseUrl%>/<%= moduleSourse%>/update.jsp?id=<%= dt.getAccId()%>"><%= Helper.getImageIcon("update", baseUrl)%> Cập nhật</a></a>
                                        <%}%>
                                        <% if (account.checkDelete(request, session) && checkButton) {%>
                                        <a href="<%= baseUrl%>/<%= moduleSourse%>/delete?id=<%= dt.getAccId()%>" onclick="return confirm('Bạn có chắc muốn xóa?')"  ><%= Helper.getImageIcon("delete", baseUrl)%> Xóa</a></a>
                                        <%}%>
                                    </td>
                                </tr>
                                <% }%>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>

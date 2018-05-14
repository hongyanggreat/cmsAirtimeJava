<%@page import="com.htc.airtime.model.Account"%>
<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--close-Header-part--> 

<!--top-Header-menu-->
<%@include file="../includes/topMenu.jsp" %>
<!--close-top-Header-menu--> 
<!--left-menu-stats-sidebar-->
<%@include file="../includes/mainMenu.jsp" %>
<!--close-left-menu-stats-sidebar-->
<%
    //check VIEW
    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkView(request, session);
    Helper.cPermission(response, checkPermission);
    String actionName = "Chi tiết";
    int id = 0;
    int accId = 0;
    int parentId = 0;
    String username = "";
    String fullname = "";
    String description = "";
    String address = "";
    String phone = "";
    String email = "";
    int userType = 0;
    int status = 0;
    id = Integer.parseInt(request.getParameter("id"));

    Account dt = new Account();
//    dt = account.view(id); 
//    dt = account.viewByField("ACC_ID", id,"*"); 
    dt = account.viewByField("ACC_ID", id, "ACC_ID,USERNAME,FULL_NAME,DESCRIPTION,ADDRESS,PHONE,EMAIL,STATUS,USER_TYPE,PARENT_ID");

    accId = dt.getAccId();
    parentId = dt.getParentId();
    username = dt.getUserName();
    fullname = dt.getFullName();
    description = dt.getDescription();
    address = dt.getAddress();
    phone = dt.getPhone();
    email = dt.getEmail();
    userType = dt.getUserType();
    status = dt.getStatus();
    String imgStatus = "";
    if (status == 0) {
        imgStatus = Helper.getImageIcon("inActive", baseUrl);
    } else if (status == 1) {
        imgStatus = Helper.getImageIcon("active", baseUrl);
    } else {
        imgStatus = Helper.getImageIcon("disable", baseUrl);
    }

    if ((checkTypeUser.equals("ADMIN")) || (checkTypeUser.equals("AGENCY_MANAGER") && ((idUser == accId) || (idUser == parentId)))) {
        System.out.println("********TAI KHOAN CUA BAN -DUOC PHEP XEM TAI KHOAN NAY");
    } else {
        if (checkPermission) {
            response.sendRedirect("/cmsAirTime");
            return;
        }
    }
%>




<div id="content">
    <div id="content-header">
        <%@include file="../includes/breadcrumb.jsp" %>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span7 offset2">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-ok-sign"></i> </span>
                        <h5>Chi tiết tài khoản : <b><%= username%></b></h5>
                        <% if (account.checkList(request, session)) {%>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>" title="Danh sách" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl)%> Danh sách</a>
                        </span>
                        <%}%>
                        <% if (account.checkAdd(request, session)) {%>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>/add.jsp" title="Thêm mới" style="padding:0 2px;">
                                <%= Helper.getImageIcon("add", baseUrl)%> Thêm mới</a>
                        </span>
                        <%}%>
                        <% if (account.checkEdit(request, session)) {%>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>/update.jsp?id=<%=accId%>" title="Cập nhật" style="padding:0 2px;">
                                <%= Helper.getImageIcon("update", baseUrl)%> Cập nhật</a>
                        </span>
                        <%}%>
                    </div>
                    <div class="widget-content">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th style="width: 100px"></th>
                                    <th>Chi tiết</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="width: 100px"><span class="">Tài khoản</span></td>
                                    <td><%=username%></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"><span class="">Email</span></td>
                                    <td><%=email%></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"><span class="">Số điện thoại</span></td>
                                    <td><%=phone%></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"><span class="">Họ tên</span></td>
                                    <td><%=fullname%></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"><span class="">Địa chỉ</span></td>
                                    <td><%=address%></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"><span class="">Trạng thái</span></td>
                                    <td><%= imgStatus%></td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>
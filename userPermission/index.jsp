<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.model.UserPermission"%>
<%@page import="com.htc.airtime.dao.UserPermissionDAO"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<%    

    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkList(request, session);
    Helper.cPermission(response, checkPermission);

    String actionName = "Danh sách";
    UserPermissionDAO userPermission = new UserPermissionDAO();

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!--close-Header-part--> 

<!--top-Header-menu-->
<%@include file="../includes/topMenu.jsp" %>
<!--close-top-Header-menu--> 
<!--left-menu-stats-sidebar-->
<%@include file="../includes/mainMenu.jsp" %>
<!--close-left-menu-stats-sidebar-->

<div id="content">
    <div id="content-header">
        <%@include file="../includes/breadcrumb.jsp" %>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span6 offset3">
                <div class="widget-box">
                    <div class="widget-title">
                        <span class="icon"><i class="icon-th"></i></span> 
                        <h5>Danh sách tài khoản</h5>


                    </div>
                    <div class="widget-content nopadding">
                        <table class="table table-bordered data-table">
                            <thead>
                                <tr>
                                    <th>Stt</th>
                                    <th>Tài khoản</th>
                                    <th>Chức năng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int i = 0;
                                    for (UserPermission dt : userPermission.getListUserPermission()) {
                                        i++;

                                %>
                                <tr class="gradeX">
                                    <td style="width:30px;text-align:center"><%= i%></td>
                                    <td><%= dt.getUSERNAME()%></td>
                                    <td style="width:150px;text-align:center">
                                        <%
                                            int total = dt.getTOTAL_PERMISSION();
                                            if (total > 0) {
                                                //if (account.checkView(request, session)) {
                                        %> 

                                        <a href="<%= baseUrl + '/' + moduleSourse%>/list.jsp?id=<%= dt.getACC_ID()%>"><%= Helper.getImageIcon("view-details", baseUrl)%> Xem quyền</a></a>
                                        <% //}
                                        } else {
                                            //if (account.checkAdd(request, session)) {
                                        %>
                                        <a href="<%= baseUrl + '/' + moduleSourse%>/list.jsp?id=<%= dt.getACC_ID()%>"><%= Helper.getImageIcon("view-details", baseUrl)%> Thêm quyền</a></a>
                                        <% //}
                                            } %>
                                    </td>
                                </tr>
                                <% }%>
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
<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.model.Modules"%>
<%@page import="com.htc.airtime.dao.ModulesDAO"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<%    Helper.cLogin(response, session);
    //check LIST
    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkList(request, session);
    Helper.cPermission(response, checkPermission);
    String actionName = "Danh sách";

    ModulesDAO modules = new ModulesDAO();
//    ArrayList dts = new ArrayList();
//    dts = account.getList();
//    out.println(dts);
//        int total = account.countAll();

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
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title">
                        <span class="icon"><i class="icon-th"></i></span> 
                        <h5><%= actionName%></h5>
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
                                    <th>ID module</th>
                                    <th>Tên module</th>
                                    <th>Resourse</th>
                                    <th>Miêu tả</th>
                                    <th>Type</th>
                                    <th>Trạng thái</th>                  
                                    <th>Chức năng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int i = 0;
                                    for (Modules dt : modules.getList()) {
                                        i++;
                                        int idModule = dt.getMODULE_ID();
                                        String desciption = dt.getDESCRIPTION();
                                        int status = dt.getSTATUS();
                                        String imgStatus = "";
                                        if (status == 0) {
                                            imgStatus = Helper.getImageIcon("inActive", baseUrl);
                                        } else if (status == 1) {
                                            imgStatus = Helper.getImageIcon("active", baseUrl);
                                        } else {
                                            imgStatus = Helper.getImageIcon("disable", baseUrl);
                                        }

                                        int type = dt.getTYPE();
                                        String strType = "";
                                        if (type == 0) {
                                            strType = "Sub";
                                        } else if (type == 1) {
                                            strType = "Admin";
                                        } else {
                                            strType = "---";
                                        }
                                %>
                                <tr class="gradeX">
                                    <td><%= i%></td>
                                    <td><%= idModule%></td>
                                    <td><%= dt.getNAME()%></td>
                                    <td><%= dt.getRESOURCE()%></td>
                                    <td style="text-align: left;max-width:300px;">
                                        <div style="overflow:hidden;max-height: 20px;" title="<%= desciption%>"><%= desciption%></div>
                                    <td>
                                        <%= strType%>
                                    </td>
                                    <td style="width:70px;text-align:center">
                                        <%= imgStatus%>
                                    </td>
                                    <td style="width:150px;text-align:center">
                                        <%
                                            if (account.checkAdd(request, session)) {
                                        %>
                                        <a href="<%= baseUrl%>/<%= moduleSourse%>/view.jsp?id=<%= idModule%>"> <%= Helper.getImageIcon("view-details", baseUrl)%> Xem </a>
                                        <%}%>
                                        <%
                                            if (account.checkEdit(request, session)) {
                                        %>
                                        <a href="<%= baseUrl%>/<%= moduleSourse%>/update.jsp?id=<%= idModule%>"> <%= Helper.getImageIcon("update", baseUrl)%> Cập nhật </a>
                                        <%}%>
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
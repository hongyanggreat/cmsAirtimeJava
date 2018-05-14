<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.htc.airtime.model.UserServices"%>
<%@page import="com.htc.airtime.dao.UserServicesDAO"%>
<%@page import="com.htc.airtime.model.Services"%>
<%@page import="com.htc.airtime.dao.ServicesDAO"%>
<%@page import="com.htc.airtime.components.Helper"%>
<%@page import="java.util.Arrays"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>

<%    Helper.cLogin(response, session);
    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkList(request, session);
    Helper.cPermission(response, checkPermission);
    String actionName = "Danh sách";

    String aliasService = "airtime";

    ServicesDAO service = new ServicesDAO();
    Services dtService = new Services();
    dtService = service.serviceByAlias(aliasService);
    int idService = 0;
    if (dtService != null) {
        idService = dtService.getID();
    }
    UserServicesDAO userServices = new UserServicesDAO();
%>

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
                        <h5>Data table</h5>
                        <%
                            if (account.checkList(request, session)) {
                        %>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>" title="Danh sách dịch vụ" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl)%> Danh sách</a>
                        </span>
                        <%}%>
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
                                    <th>ID</th>
                                    <th>Tài khoản</th>
                                    <th>CP code</th>
                                    <th>Mã GAME</th>                  
                                    <th>Tên GAME</th>                  
                                    <th>Mã Bảo mật</th>                  
                                    <th>Ip Access</th>                  
                                    <th>Trạng thái</th>                  
                                    <th>Chức năng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    int i = 0;
                                    System.out.println("idService:" + idService);
                                    if (idService > 0) {
                                        ArrayList<UserServices> list = userServices.getListByIdService(idService);
                                        if (list != null) {

                                            for (UserServices dt : list) {
                                                i++;
                                                String serviceName = dt.getUserName();
                                                String ipAllow = dt.getIpAllow();
                                                int id = dt.getId();
                                                int status = dt.getStatus();
                                                String imgStatus = "";
                                                if (status == 0) {
                                                    imgStatus = Helper.getImageIcon("inActive", baseUrl);
                                                } else if (status == 1) {
                                                    imgStatus = Helper.getImageIcon("active", baseUrl);
                                                } else {
                                                    imgStatus = Helper.getImageIcon("disable", baseUrl);
                                                }
                                %>
                                <tr class="gradeX">
                                    <td style="width:30px;text-align:center"><%= i%></td>
                                    <td style="text-align:center"><%= dt.getId()%></td>
                                    <td style="text-align:center"><%= dt.getUserName()%></td>
                                    <td><%= dt.getCpCode()%></td>
                                    <td><%= dt.getCodeGame()%></td>
                                    <td><%= dt.getGameName()%></td>
                                    <td>
                                        <b>SERVICE_PIN :</b> <%= dt.getServicePin()%><br/> 
                                        <b>ACCESS_KEY :</b> <%= dt.getAccessKey()%><br/> 
                                        <b>SECRET_KEY :</b> <%= dt.getSecretKey()%><br/> 
                                    </td>
                                    <td style="text-align: left;max-width:300px;">
                                        <div style="overflow:hidden;max-height: 50px;">
                                            <%
                                                if(!Tool.checkNull(ipAllow)){
                                                    String[] words = ipAllow.split(",");
                                                    System.out.println("words"+words);
                                                    for (String w : words) {
                                                        out.println("<div>" + w + "</div>");
                                                    }
                                                }else{
                                                    out.println("--");
                                                }
                                            %>

                                        </div>
                                    </td>
                                    <td style="width:65px;text-align:center">
                                        <%= imgStatus%>
                                    </td>
                                    <td style="width:200px;text-align:left">
                                        <%
                                            if (account.checkList(request, session)) {
                                        %>
                                        <a href="<%= baseUrl%>/<%= moduleSourse%>/view.jsp?id=<%= id%> "> <%= Helper.getImageIcon("view-details", baseUrl)%> Xem </a>
                                        <%}%>
                                        <%
                                            if (account.checkList(request, session)) {
                                        %>
                                        <a href="<%= baseUrl%>/<%= moduleSourse%>/update.jsp?id=<%= id%> "> <%= Helper.getImageIcon("update", baseUrl)%> Cập nhật </a>
                                        <%}%>
                                        <% if (account.checkDelete(request, session)) {%>
                                        <a href="<%= baseUrl%>/<%= moduleSourse%>/delete?id=<%= dt.getId()%>" onclick="return confirm('Bạn có chắc muốn xóa?')"  ><%= Helper.getImageIcon("delete", baseUrl)%> Xóa</a></a>
                                        <%}%>
                                    </td>
                                </tr>
                                <% }%>
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
</div>
<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>
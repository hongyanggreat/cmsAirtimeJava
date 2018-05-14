<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.dao.ServicesDAO"%>
<%@page import="com.htc.airtime.model.Services"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<%    //
    Helper.cLogin(response, session);
    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkView(request, session);
    Helper.cPermission(response, checkPermission);
    String actionName = "Chi tiết";

    int id = 0;
    int idService = 0;
    String name = "";
    String alias = "";
    String description = "";
    int status = 0;
    id = Integer.parseInt(request.getParameter("id"));
    ServicesDAO service = new ServicesDAO();
    Services dt = new Services();
    dt = service.view(id);

    idService = dt.getID();
    name = dt.getNAME();
    alias = dt.getALIAS();
    description = dt.getDESCRIPTION();
    status = dt.getSTATUS();
    String imgStatus = "";
    if (status == 0) {
        imgStatus = Helper.getImageIcon("inActive", baseUrl);
    } else if (status == 1) {
        imgStatus = Helper.getImageIcon("active", baseUrl);
    } else {
        imgStatus = Helper.getImageIcon("disable", baseUrl);
    }
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
            <div class="span7 offset2">
                <div class="widget-box">
                    <div class="widget-title"><span class="icon"> <i class="icon-ok-sign"></i> </span>
                        <h5>Chi tiết <%= moduleName%> : <b><%= name%></b></h5>
                        <span class="icon"><a class="" href="<%= baseUrl%>/services" title="Danh sách" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl)%> Danh sách</a>
                        </span>
                        <span class="icon"><a class="" href="<%= baseUrl%>/services/add.jsp" title="Thêm mới" style="padding:0 2px;">
                                <%= Helper.getImageIcon("add", baseUrl)%> Thêm mới</a>
                        </span>
                        <span class="icon"><a class="" href="<%= baseUrl%>/services/update.jsp?id=<%= idService%>" title="Cập nhật" style="padding:0 2px;">
                                <%= Helper.getImageIcon("update", baseUrl)%> Cập nhật</a>
                        </span>
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
                                    <td style="width: 100px"><span class="">Tên dịch vụ</span></td>
                                    <td><%= name%></td>
                                </tr>

                                <tr>
                                    <td style="width: 100px"><span class="">Tên Định danh</span></td>
                                    <td><%= alias%></td>
                                </tr>

                                <tr>
                                    <td style="width: 100px"><span class="">Miêu tả</span></td>
                                    <td><%= description%></td>
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
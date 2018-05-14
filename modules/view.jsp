<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.model.Modules"%>
<%@page import="com.htc.airtime.dao.ModulesDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<%  
    Helper.cLogin(response, session);
    //check VIEW
    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkView(request,session);
    Helper.cPermission(response, checkPermission);
    
    String actionName = "Chi tiết";
    
    int id = 0;
    int idModule = 0;
    String resourse = "";
    String name = "";
    String description = "";
    int type = 0;
    int status = 0;
    id = Integer.parseInt( request.getParameter("id"));
    ModulesDAO module = new ModulesDAO();
    Modules dt = new Modules();
    dt = module.view(id); 

    idModule = dt.getMODULE_ID();
    resourse = dt.getRESOURCE();
    name = dt.getNAME();
    description = dt.getDESCRIPTION();
    type = dt.getTYPE();
    status = dt.getSTATUS();
    String imgStatus = "";
    if(status == 0){
        imgStatus = Helper.getImageIcon("inActive", baseUrl);
    }else if(status == 1){
        imgStatus = Helper.getImageIcon("active", baseUrl);
    }else{
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
                            <h5>Chi tiết Module : <b><%= name %></b></h5>
                            <span class="icon"><a class="" href="<%= baseUrl %>/<%= moduleSourse %>" title="Danh sách" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl) %> Danh sách</a>
                            </span>
                            <span class="icon"><a class="" href="<%= baseUrl %>/<%= moduleSourse %>/add.jsp" title="Thêm mới" style="padding:0 2px;">
                                <%= Helper.getImageIcon("add", baseUrl) %> Thêm mới</a>
                            </span>
                            <span class="icon"><a class="" href="<%= baseUrl %>/<%= moduleSourse %>/update.jsp?id=<%= idModule %>" title="Cập nhật" style="padding:0 2px;">
                                <%= Helper.getImageIcon("update", baseUrl) %> Cập nhật</a>
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
                                <td style="width: 100px"><span class="">Resourse</span></td>
                                <td><%= resourse %></td>
                              </tr>
                              
                              <tr>
                                <td style="width: 100px"><span class="">Tên Module</span></td>
                                <td><%= name %></td>
                              </tr>
                              
                              <tr>
                                <td style="width: 100px"><span class="">Miêu tả</span></td>
                                <td><%= description %></td>
                              </tr>
                              <tr>
                                <td style="width: 100px"><span class="">Trạng thái</span></td>
                                <td><%= imgStatus %></td>
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
<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.model.Services"%>
<%@page import="com.htc.airtime.dao.ServicesDAO"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<%
    Helper.cLogin(response, session);
    
    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkList(request, session);
    Helper.cPermission(response, checkPermission);
    String actionName = "Danh sách";
    
    ServicesDAO services = new ServicesDAO();
 
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
                          <h5>Danh sách</h5>
                        </div>
                        <div class="widget-content nopadding">
                          <table class="table table-bordered data-table">
                            <thead>
                              <tr>
                                <th>Stt</th>
                                <th>ID</th>
                                <th>Tên Dịch vụ</th>
                                <th>Trạng thái</th>                  
                                <th>Chức năng</th>
                              </tr>
                            </thead>
                            <tbody>
                                <%
                                    int i = 0;
                                    for (Services dt : services.getList()) {
                                        i++;
                                    int idService = dt.getID();
                                    String alias = dt.getALIAS();
                                    String desciption = dt.getDESCRIPTION();
                                    int status = dt.getSTATUS();
                                    String imgStatus = "";
                                    if(status == 0){
                                        imgStatus = Helper.getImageIcon("inActive", baseUrl);
                                    }else if(status == 1){
                                        imgStatus = Helper.getImageIcon("active", baseUrl);
                                    }else{
                                        imgStatus = Helper.getImageIcon("disable", baseUrl);
                                    }
                                %>
                              <tr class="gradeX">
                                <td style="width:30px;text-align:center"><%= i %></td>
                                <td style="width:30px;text-align:center"><%= idService %></td>
                                <td><a href="<%= baseUrl %>/services/view.jsp?id=<%= idService %>"><%= dt.getNAME()%> </a></td>
                                       
                                
                                <td style="width:65px;text-align:center"> <%= imgStatus %> </td>
                                <td style="width:350px;text-align:left">
                                    <%
//                                        alias.substring(0, 1).toUpperCase() + alias.substring(1)
                                    %>
                                    <a href="<%= baseUrl %>/<%= alias %>Manager"> <img  width="20" src="<%= baseUrl %>/resource/images/icon/view-details.png" alt=""> Xem danh sách đăng ký </a>
                                    <!--<a href="list.jsp?serviceName=alias&idService=idService"> <img  width="20" src="baseUrl/resource/images/icon/view-details.png" alt=""> Xem danh sách đăng ký </a>-->
                                    <%
                                        if(status == 1){
                                    %>
                                        <a href="<%= baseUrl+"/"+alias %>Manager/add.jsp"><%= Helper.getImageIcon("addMore", baseUrl) %> Đăng ký</a>
                                    
                                    <% }else{
                                            
                                    } %>
                                </td>
                              </tr>
                              <% } %>
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
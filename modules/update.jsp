<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.model.Modules"%>
<%@page import="com.htc.airtime.dao.ModulesDAO"%>
<%@page import="java.util.Arrays"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<%
   Helper.cLogin(response, session);
    
   //check UPDATE
   AccountDAO account = new AccountDAO();
   boolean checkPermission = account.checkEdit(request,session);
   Helper.cPermission(response, checkPermission);
    
   String actionName = "Cập nhật";
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
                    <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5><%= actionName %></h5>
                        <span class="icon"><a class="" href="<%= baseUrl %>/<%= moduleSourse %>" title="Danh sách" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl) %> Danh sách</a>
                        </span>
                        <span class="icon"><a class="" href="<%= baseUrl %>/<%= moduleSourse %>/add.jsp" title="Thêm mới" style="padding:0 2px;">
                                <%= Helper.getImageIcon("add", baseUrl) %> Thêm mới</a>
                        </span>
                    </div>
                    <div class="widget-content nopadding">
                        <form action="<%= baseUrl %>/updateModule" name="myform" method="post" class="form-horizontal">

                            <input type="hidden" name="idModule" class="span11" value="<%=idModule %>" placeholder="Id Module" />

                            <div class="control-group">
                                <label class="control-label">Tên Resourse:</label>
                                <div class="controls">
                                    <input type="text" name="resouse"  class="span11" value="<%= resourse %>" placeholder="Nhập resouse" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Tên Module:</label>
                                <div class="controls">
                                    <input type="text" name="name"  class="span11" value="<%= name %>" placeholder="Nhập tên module" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Miêu tả:</label>
                                <div class="controls">
                                    <textarea class="span11" name="description" placeholder="Nhập miêu tả." ><%=description %></textarea>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Loại tài khoản</label>
                                <div class="controls">
                                    <label>
                                        <input type="radio" name="type" value="1"<% 
                                            if(type == 1){
                                                out.print("checked");
                                            }
                                               %> />
                                        Admin</label>
                                    <label>
                                        <input type="radio" name="type" value="0" <% 
                                            if(type == 0){
                                                out.print("checked");
                                            }
                                               %>/>
                                        Sub</label>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Trạng thái</label>
                                <div class="controls">
                                    <label>
                                        <input type="radio" name="status" value="1" <% 
                                            if(status == 1){
                                                out.print("checked");
                                            }
                                               %> />
                                        Kích hoạt</label>
                                    <label>
                                        <input type="radio" name="status" value="0"<% 
                                            if(status == 0){
                                                out.print("checked");
                                            }
                                               %> />
                                        Không kích hoạt</label>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" name="addModule" class="btn btn-success">Lưu</button>
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

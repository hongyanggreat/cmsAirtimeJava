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

<div id="content">
    <div id="content-header">
        <%                //
            Helper.cLogin(response, session);

            //check ADD
            AccountDAO account = new AccountDAO();
            boolean checkPermission = account.checkAdd(request, session);
            Helper.cPermission(response, checkPermission);
            String actionName = "Thêm mới";
        %>
        <%@include file="../includes/breadcrumb.jsp" %>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span7 offset2">
                <div class="widget-box">
                    <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5><%= actionName%></h5>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>" title="Danh sách" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl)%> Danh sách</a>
                        </span>
                    </div>
                    <div class="widget-content nopadding">
                        <form action="<%= baseUrl%>/addModule" name="myform" method="post" class="form-horizontal">
                            <div class="control-group">
                                <label class="control-label">Tên Resourse:</label>
                                <div class="controls">
                                    <input type="text" name="resouse"  class="span11" placeholder="Nhập resouse" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Tên Module:</label>
                                <div class="controls">
                                    <input type="text" name="name"  class="span11" placeholder="Nhập tên module" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Miêu tả:</label>
                                <div class="controls">
                                    <textarea class="span11" name="description" placeholder="Nhập miêu tả." ></textarea>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Loại module</label>
                                <div class="controls">
                                    <label>
                                        <input type="radio" name="type" value="1" />
                                        Admin</label>
                                    <label>
                                        <input type="radio" name="type" value="0" />
                                        Sub</label>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Trạng thái</label>
                                <div class="controls">
                                    <label>
                                        <input type="radio" name="status" value="1" />
                                        Kích hoạt</label>
                                    <label>
                                        <input type="radio" name="status" value="0" />
                                        Không kích hoạt</label>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" name="addAccount" class="btn btn-success">Lưu</button>
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

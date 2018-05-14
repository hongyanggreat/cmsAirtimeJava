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
<%
    //check LIST
    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkEdit(request, session);
    Helper.cPermission(response, checkPermission);

    String actionName = "Cập nhật";
    int id = 0;
    int accId = 0;
    int parentId = 0;
    String username = "";
    String fullname = "";
    String description = "";
    String address = "";
    String phone = "";
    String email = "";
    int status = 0;
    
    id = Integer.parseInt(request.getParameter("id"));
    Account dt = new Account();
    dt = account.view(id);

    accId = dt.getAccId();
    username = dt.getUserName();
    fullname = dt.getFullName();
    description = dt.getDescription();
    address = dt.getAddress();
    phone = dt.getPhone();
    email = dt.getEmail();

    status = dt.getStatus();
    parentId = dt.getParentId();

//    if ((checkTypeUser.equals("ADMIN") && ((idUser == accId) || !AccountDAO.TYPE.getType(userType).toString().equals("ADMIN"))) || (checkTypeUser.equals("AGENCY_MANAGER") && ((idUser == accId) || (idUser == parentId)))) {
    if ((checkTypeUser.equals("ADMIN")) || (checkTypeUser.equals("AGENCY_MANAGER") && ((idUser == accId) || (idUser == parentId)))) {
        System.out.println("********TAI KHOAN CUA BAN -DUOC PHEP CAP NHAT TAI KHOAN NAY");
    } else {
        if (checkPermission) {
            response.sendRedirect(request.getContextPath()+'/');
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
                    <div class="widget-title"> <span class="icon"> <i class="icon-align-justify"></i> </span>
                        <h5><%= actionName%></h5>
                        <h5>
                            <%
                                if (!Tool.checkNull(request.getAttribute("err"))) {
                                    out.println(request.getAttribute("err"));
                                }
                            %>
                        </h5>
                        <% if (account.checkList(request, session)) {%>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>" title="Danh sách tài khoản" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl)%> Danh sách</a>
                        </span>
                        <%}%>
                        <% if (account.checkAdd(request, session)) {%>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>/add.jsp" title="Thêm mới tài khoản" style="padding:0 2px;">
                                <%= Helper.getImageIcon("add", baseUrl)%> Thêm mới</a>
                        </span>
                        <%}%>
                    </div>
                    <div class="widget-content nopadding">
                        <form action="<%= baseUrl%>/updateAcc" name="myform" method="post" class="form-horizontal">

                            <input type="hidden" name="accId" class="span11" value="<%=accId%>" placeholder="Id Account" />
                            <input type="hidden" name="parentId" class="span11" value="<%=parentId%>" placeholder="parentId" />
                            <div class="control-group">
                                <label class="control-label">Tài khoản :</label>
                                <div class="controls">
                                    <input type="text" readonly="readonly"  name="username" onchange="checkUserName(this)" class="span11" value="<%=username%>" placeholder="Nhập tài khoản" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Mật khẩu</label>
                                <div class="controls">
                                    <input type="password" name="password"  class="span11" placeholder="Nhập mật khẩu"  />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Họ Tên :</label>
                                <div class="controls">
                                    <input type="text" name="fullname" class="span11" value="<%=fullname%>" placeholder="Nhập họ tên" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Miêu tả:</label>
                                <div class="controls">
                                    <textarea class="span11" name="description" placeholder="Nhập miêu tả." ><%=description%></textarea>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Địa chỉ :</label>
                                <div class="controls">
                                    <input type="text" name="address" class="span11" value="<%=address%>" placeholder="Nhập địa chỉ" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Điện thoại :</label>
                                <div class="controls">
                                    <input type="text" name="phone" class="span11" value="<%=phone%>" placeholder="Nhập số điện thoại" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Email :</label>
                                <div class="controls">
                                    <input type="text" name="email" class="span11" value="<%=email%>" placeholder="Nhập số email" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Loại tài khoản</label>
                                <div class="controls">

                                    <%    //                                    
                                        if (checkTypeUser.equals("ADMIN")) {

                                    %>
                                    <label>
                                        <input type="radio" name="userType" value="<%=AccountDAO.TYPE.ADMIN.val%>" <%
                                            if (dt.getUserType() == AccountDAO.TYPE.ADMIN.val) {
                                                out.print("checked");
                                            }
                                               %> />
                                        <%= AccountDAO.TYPE.getname(AccountDAO.TYPE.ADMIN.val) %>
                                    </label>
                                    <%}%>
                                    <%    //                                    
                                        if (checkTypeUser.equals("ADMIN") || (checkTypeUser.equals("AGENCY_MANAGER") && idUser == accId)) {

                                    %>
                                    <label>
                                        <input type="radio" name="userType" value="<%=AccountDAO.TYPE.AGENCY_MANAGER.val%>" <%
                                            if (dt.getUserType() == AccountDAO.TYPE.AGENCY_MANAGER.val) {
                                                out.print("checked");
                                            }
                                               %> />
                                       <%= AccountDAO.TYPE.getname(AccountDAO.TYPE.AGENCY_MANAGER.val) %>
                                    </label>
                                    <%}%>
                                    <%
                                        if (checkTypeUser.equals("ADMIN") || checkTypeUser.equals("AGENCY_MANAGER")) {
                                    %>
                                    <label>
                                        <input type="radio" name="userType" value="<%=AccountDAO.TYPE.AGENCY.val%>" <%
                                            if (dt.getUserType() == AccountDAO.TYPE.AGENCY.val) {
                                                out.print("checked");
                                            }
                                               %> />
                                        <%= AccountDAO.TYPE.getname(AccountDAO.TYPE.AGENCY.val) %>
                                    </label>
                                    <label>
                                        <input type="radio" name="userType" value="<%=AccountDAO.TYPE.USER.val%>" <%
                                            if (dt.getUserType() == AccountDAO.TYPE.USER.val) {
                                                out.print("checked");
                                            }
                                               %> />
                                        <%= AccountDAO.TYPE.getname(AccountDAO.TYPE.USER.val) %>
                                    </label>
                                    <%}%>
                                </div>
                            </div>        



                            <div class="control-group">
                                <label class="control-label">Trạng thái</label>
                                <div class="controls">
                                    <label>
                                        <input type="radio" name="status" value="1" <%
                                            if (status == 1) {
                                                out.print("checked");
                                            }
                                               %> />
                                        Kích hoạt</label>
                                    <label>
                                        <input type="radio" name="status" value="0"<%
                                            if (status == 0) {
                                                out.print("checked");
                                            }
                                               %> />
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
<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>

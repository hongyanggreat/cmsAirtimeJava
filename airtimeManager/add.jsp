<%@page import="com.htc.airtime.model.Account"%>
<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.model.Services"%>
<%@page import="com.htc.airtime.dao.ServicesDAO"%>
<%@page import="com.htc.airtime.components.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<%  
    
    //check ADD
    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkAdd(request, session);
    Helper.cPermission(response, checkPermission);
    
    String actionName = "Thêm mới";

//    String url = request.getRequestURL().toString();
//    int numArray = 4;//"vi tri lay trong mang khi duoc tách ra"
//    int numberStr = 3;//"resService"
//    String aliasService = Helper.uri(url, numArray, numberStr);
    String aliasService = "airTime";

    ServicesDAO service = new ServicesDAO();
    Services dtService = new Services();
    dtService = service.serviceByAlias(aliasService);
    int idService = dtService.getID();
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
                       <% if (account.checkList(request, session)) {%>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>" title="Danh sách" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl)%> Danh sách</a>
                        </span>
                        <%}%>
                    </div>
                    <div class="widget-content nopadding">
                        <form action="<%= baseUrl%>/addServiceAirtime" name="myform" method="post" class="form-horizontal">
                            <input type="hidden" name="idService"  class="span11" value="<%= idService%>" placeholder="Nhập tên idService" />
                            <div class="control-group">
                                <label class="control-label">Tài khoản:</label>
                                <div class="controls">
                                    <select class="account" name="cp_code">
                                        <%
                                            String username = "";

                                            int i = 0;
                                            for (Account dt : account.getListByField("STATUS", 1)) {
//                                                if(dt.getUSERNAME().equals("duongnh")){
                                                if (i == 0) {
                                                    username = dt.getUserName();
                                                }
                                                i++;
                                        %>
                                        <option value="<%= dt.getCpCode()%>"><%= dt.getUserName()%></option>
                                        <% }%>   
                                    </select>
                                    <input type="hidden" name="username"  class="span11 username" value="<%= username%>" placeholder="Nhập tên tài khoản" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Tên gamge:</label>
                                <div class="controls">
                                    <input type="text" name="gameName"  class="span11" value="" placeholder="Nhập tên game" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Mã gamge:</label>
                                <div class="controls">
                                    <input type="text" name="gameCode"  class="span11" placeholder="Nhập mã game" />
                                </div>
                            </div>
                           
                            <div class="control-group">
                                <label class="control-label">IP access:</label>
                                <div class="controls">
                                    <input type="text" name="ipAllow"  class="span11" value="" placeholder="Nhập địa chỉ IP cho phép" />
                                </div>
                            </div>
                                
                            <div class="control-group">
                                <label class="control-label">Miêu tả:</label>
                                <div class="controls">
                                    <textarea class="span11" name="description" placeholder="Nhập miêu tả." ></textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Option Data:</label>
                                <div class="controls">
                                    <textarea class="span11" name="optionData" placeholder="Nhập option data." ></textarea>
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
                                <button type="submit" name="addService" class="btn btn-success">Lưu</button>
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
<script>
    $(document).ready(function () {
        $('body').on('change', '.account', function (event) {
            event.preventDefault();
            /* Act on the event */
            var username = $(this).find("option:selected").text();
            $('.username').val(username);
        });
    });
</script>
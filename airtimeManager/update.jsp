<%@page import="java.util.ArrayList"%>
<%@page import="com.htc.airtime.dao.UserServicesDAO"%>
<%@page import="com.htc.airtime.model.UserServices"%>
<%@page import="com.htc.airtime.model.Account"%>
<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.model.Services"%>
<%@page import="com.htc.airtime.dao.ServicesDAO"%>
<%@page import="com.htc.airtime.components.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<%    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkEdit(request, session);
    Helper.cPermission(response, checkPermission);

    String actionName = "Cập nhật";
    String redirectURL = baseUrl + "/" + moduleSourse;
//    String url = request.getRequestURL().toString();
//    int numArray = 4;//"vi tri lay trong mang khi duoc tách ra"
//    int numberStr = 3;//"resService"
//    String aliasService = Helper.uri(url, numArray, numberStr);
    String aliasService = "airTime";

    ServicesDAO service = new ServicesDAO();
    Services dtService = new Services();
    dtService = service.serviceByAlias(aliasService);
    int idService = 0;
    idService = dtService.getID();
    UserServicesDAO userServices = new UserServicesDAO();
    int id = 0;
    if (request.getParameter("id") != null) {
        id = Integer.parseInt(request.getParameter("id"));
    }
    UserServices dtUs = new UserServices();
    dtUs = userServices.view(id);

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
                        <h5><%= moduleName%></h5>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>" title="Danh sách" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl)%> Danh sách</a>
                        </span>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>/view.jsp?id=<%= id%>" title="Xem chi tiết" style="padding:0 2px;">
                                <%= Helper.getImageIcon("view-details", baseUrl)%> Xem chi tiết</a>
                        </span>
                    </div>
                    <div class="widget-content nopadding">
                        <%
                            int idUserService = dtUs.getId();
                            String cp_code = "";
                            String username = "";
                            String gameName = "";
                            String gameCode = "";
                            String ipAllow = "";
                            String description = "";
                            String optionData = "";
                            int status = -1;
//                            out.println(idService);
//                            out.println(dtUs.getSERVICE_TYPE());
                            if (idUserService > 0 && idService == dtUs.getServiceType()) {
                                cp_code = dtUs.getCpCode();
                                username = dtUs.getUserName();
                                gameName = dtUs.getGameName();
                                gameCode = dtUs.getCodeGame();
                                ipAllow = dtUs.getIpAllow();
                                description = dtUs.getDescription();
                                optionData = dtUs.getOptionData();
                                status = dtUs.getStatus();

                        %>
                        <form action="<%= baseUrl%>/updateServiceAirtime" name="myform" method="post" class="form-horizontal">
                            <input type="hidden" name="id"  class="span11" value="<%= id%>" placeholder="Nhập tên id" />
                            <div class="control-group">
                                <label class="control-label">Tài khoản:</label>
                                <div class="controls">
                                    <select class="account" name="cp_code">
                                        <%

                                            String selected = "";

                                            int i = 0;
                                            ArrayList<Account> listAcc = account.getList();
                                            if (listAcc.size() <= 0) {
//                                                System.out.println("urlCallback :"+redirectURL);

                                                response.sendRedirect(redirectURL);
                                            }
                                            for (Account dt : listAcc) {
//                                                if(dt.getUSERNAME().equals("duongnh")){
                                                selected = "";
                                                if (dt.getCpCode().equals(cp_code)) {
                                                    selected = "selected";
                                                }
                                                i++;
                                        %>
                                        <option value="<%= dt.getCpCode()%>" <%=  cp_code%>  <%=  selected%> ><%= dt.getUserName()%></option>
                                        <% }%>   
                                    </select>
                                    <input type="hidden"  name="username"  class="span11 username" value="<%= username%>" placeholder="Nhập tên tài khoản" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Tên gamge:</label>
                                <div class="controls">
                                    <input type="text" name="gameName"  class="span11" value="<%= gameName%>" placeholder="Nhập tên game" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Mã gamge:</label>
                                <div class="controls">
                                    <input type="text" name="gameCode"  class="span11" value="<%= gameCode%>" placeholder="Nhập mã game" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">IP access:</label>
                                <div class="controls">
                                    <input type="text" name="ipAllow"  class="span11" value="<%= ipAllow%>" placeholder="Nhập địa chỉ IP cho phép" />
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Miêu tả:</label>
                                <div class="controls">
                                    <textarea class="span11" name="description" placeholder="Nhập miêu tả." ><%= description%></textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Option Data:</label>
                                <div class="controls">
                                    <textarea class="span11" name="optionData" placeholder="Nhập option data." ><%= optionData%></textarea>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">Trạng thái</label>
                                <div class="controls">
                                    <label>
                                        <input type="radio" name="status" value="1" <%

                                            System.out.println("status:" + status);
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
                                <button type="submit" name="addService" class="btn btn-success">Lưu</button>
                            </div>
                        </form>
                        <%} else {
//                            out.print("Du lieu khong co hic hic");

                                response.sendRedirect(redirectURL);
                            }%>
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

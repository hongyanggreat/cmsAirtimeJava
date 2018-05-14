<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.model.Services"%>
<%@page import="com.htc.airtime.dao.ServicesDAO"%>
<%@page import="com.htc.airtime.components.Helper"%>
<%@page import="com.htc.airtime.model.UserServices"%>
<%@page import="com.htc.airtime.dao.UserServicesDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>
<%    //
    Helper.cLogin(response, session);

    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkView(request, session);
    Helper.cPermission(response, checkPermission);

    String actionName = "Chi tiết";

//    String imgActive = "<img width='20' src='" + baseUrl + "/resource/images/icon/active.png' alt='Kích hoạt' title='Kích hoạt'/>";
//    String imgInActive = "<img width='20' src='" + baseUrl + "/resource/images/icon/inActive.png' alt='Không kích hoạt' title='Không kích hoạt'/>";
//    String imgDisable = "<img width='20' src='" + baseUrl + "/resource/images/icon/disable.png' alt='Hủy kích hoạt' title='Hủy kích hoạt'/>";
    int id = 0;
    int idService = 0;
    String cp_code = "";
    String username = "";
    String game_code = "";
    String game_name = "";
    String urlCallback = "";
    String optionData = "";
    String description = "";
    int status = 0;
    id = Integer.parseInt(request.getParameter("id"));

    String aliasService = "airTime";
    ServicesDAO service = new ServicesDAO();
    Services dtService = new Services();
    dtService = service.serviceByAlias(aliasService);
    idService = dtService.getID();

    UserServicesDAO userServices = new UserServicesDAO();
    UserServices dt = new UserServices();

    dt = userServices.view(id);
    int idUserService = dt.getId();

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
                        <h5>Chi tiết Module : <b><%= game_name%></b></h5>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>" title="Danh sách" style="padding:0 2px;">
                                <%= Helper.getImageIcon("home", baseUrl)%> Danh sách</a>
                        </span>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>/add.jsp" title="Thêm mới" style="padding:0 2px;">
                                <%= Helper.getImageIcon("add", baseUrl)%> Thêm mới</a>
                        </span>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>/update.jsp?id=<%= id%>" title="Cập nhật" style="padding:0 2px;">
                                <%= Helper.getImageIcon("update", baseUrl)%> Cập nhật</a>
                        </span>
                    </div>
                    <div class="widget-content">
                        <%
                            if (idUserService != 0 && idService == dt.getServiceType()) {
                                cp_code = dt.getCpCode();
                                username = dt.getUserName();
                                game_code = dt.getCodeGame();
                                game_name = dt.getGameName();
                                urlCallback = dt.getUrlCallback();
                                description = dt.getDescription();
                                optionData = dt.getOptionData();
                                status = dt.getStatus();
                        %>
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th style="width: 100px"></th>
                                    <th>Chi tiết</th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr>
                                    <td style="width: 100px"><span class="">CP code</span></td>
                                    <td><%= cp_code%></td>
                                </tr>

                                <tr>
                                    <td style="width: 100px"><span class="">Tài khoản</span></td>
                                    <td><%= username%></td>
                                </tr>

                                <tr>
                                    <td style="width: 100px"><span class="">Mã game</span></td>
                                    <td><%= game_code%></td>
                                </tr>

                                <tr>
                                    <td style="width: 100px"><span class="">Tên game</span></td>
                                    <td><%= game_name%></td>
                                </tr>

                                <tr>
                                    <td style="width: 100px"><span class="">Url Callback</span></td>
                                    <td><%= urlCallback%></td>
                                </tr>

                                <tr>
                                    <td style="width: 100px"><span class="">option Data/span></td>
                                    <td><%= optionData%></td>
                                </tr>

                                <tr>
                                    <td style="width: 100px"><span class="">Miêu tả</span></td>
                                    <td><%= description%></td>
                                </tr>
                                <tr>
                                    <td style="width: 100px"><span class="">Trạng thái</span></td>
                                    <td>
                                        <%
                                            String imgStatus = "";
                                            if (status == 0) {
                                                imgStatus = Helper.getImageIcon("inActive", baseUrl);
                                            } else if (status == 1) {
                                                imgStatus = Helper.getImageIcon("active", baseUrl);
                                            } else {
                                                imgStatus = Helper.getImageIcon("disable", baseUrl);
                                            }
                                            out.println(imgStatus);
                                        %>
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                        <%
                            } else {
                                String redirectURL = baseUrl + "/" + moduleSourse;
                                response.sendRedirect(redirectURL);
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>
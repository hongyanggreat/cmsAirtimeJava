<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.dao.ChargeAirTimeDAO"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.htc.airtime.components.Tool"%>
<%@page import="com.htc.airtime.components.MyDate"%>
<%@page import="java.util.ArrayList"%>
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
        <%@include file="../includes/airTime/infoSelect.jsp" %>
        <%  //          
            AccountDAO account = new AccountDAO();
            boolean checkPermission = account.checkList(request, session);
            Helper.cPermission(response, checkPermission);
            String actionName = "Tìm kiếm";

            request.setCharacterEncoding("UTF-8");
            String price = "0";
            String cpCode = "";
            String cpName = "";
            String cpGame = "";
            String msisdn = "";
            String formDate = MyDate.createDate("dd/MM/yyyy");
            String toDate = MyDate.createDate("dd/MM/yyyy");
            int limit = 100;
            int offset = 0;
            int pages = 1;

            if (!Tool.checkNull(request.getParameter("price"))) {
                price = request.getParameter("price");
            }
            if (!Tool.checkNull(request.getParameter("cpCode"))) {
                cpCode = request.getParameter("cpCode");
            }
            if (!Tool.checkNull(request.getParameter("cpName"))) {
                cpName = request.getParameter("cpName");
            }
            if (!Tool.checkNull(request.getParameter("cpGame"))) {
                cpGame = request.getParameter("cpGame");
            }
            if (!Tool.checkNull(request.getParameter("msisdn"))) {
                msisdn = request.getParameter("msisdn");
            }
            if (!Tool.checkNull(request.getParameter("formDate"))) {
                formDate = request.getParameter("formDate");
            }
            if (!Tool.checkNull(request.getParameter("toDate"))) {
                toDate = request.getParameter("toDate");
            }
            if (!Tool.checkNull(request.getParameter("numberLimit"))) {
                limit = Integer.parseInt(request.getParameter("numberLimit"));
            }
            if (!Tool.checkNull(request.getParameter("pages"))) {
                String possibleNumber = request.getParameter("pages");
                boolean isNumber = Pattern.matches("[0-9]+", possibleNumber);
                if (isNumber && (Integer.parseInt(possibleNumber) > 0)) {
                    pages = Integer.parseInt(possibleNumber);
                }
            }
            offset = (pages - 1) * limit;
//                System.out.println(resultCode);
//                System.out.println(cpCode);
//                System.out.println(formDate);
//                System.out.println(toDate);
//                System.out.println(limit);
            ChargeAirTimeDAO chargeAirTime = new ChargeAirTimeDAO();

            int totalItem = chargeAirTime.countAllSearch(price, cpCode, cpName, cpGame, msisdn, formDate, toDate,arrAcc);
            ArrayList<ChargeAirTime> dts = chargeAirTime.getListSearch(price, cpCode, cpName, cpGame, msisdn, formDate, toDate, limit, offset,arrAcc);

            int totalPage = (int) Math.ceil((double) totalItem / limit);

            String actionPage = baseUrl + "/" + moduleSourse + "/index.jsp?pages=";
            String paramPage = "&price=" + price
                    + "&cpCode=" + cpCode
                    + "&cpName=" + cpName
                    + "&cpGame=" + cpGame
                    + "&msisdn=" + msisdn
                    + "&formDate=" + formDate
                    + "&toDate=" + toDate
                    + "&numberLimit=" + limit;

            String action = baseUrl + "/" + moduleSourse;
            String statistic = baseUrl + "/" + moduleSourse + "/statistic.jsp";
            String actionExp = baseUrl + "/" + moduleSourse + "/export/data.jsp?page=" + pages + paramPage;

        %> 
        <%@include file="../includes/breadcrumb.jsp" %>
    </div>
    <div class="container-fluid">


        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box collapsible">

                    <div class="widget-title">
                        <%@include file="../includes/airTime/button.jsp" %>
                        <!--// Nut chuc nang-->
                    </div>
                    <div class="" id="collapseOne">
                        <!-- //FORM SEARCH -->
                        <%@include file="../includes/airTime/formSearch.jsp" %>
                        <!-- //FORM SEARCH -->
                    </div>

                    <div class="collapse in" id="collapseTwo">
                        <div class="widget-content" style="padding: 0px" >
                            <div class="widget-box" style="border:0px;margin:0px">
                                <div class="widget-title">

                                    <!-- //Hien thi cac nut chuc nang -->
                                </div>
                                <div class="widget-content nopadding" style="overflow: scroll;">
                                    <%@include file="table.jsp" %>
                                </div>
                            </div>
                            <div class="pagination alternate" style="text-align: center">
                                <ul>
                                    <%@include file="../includes/paginator.jsp" %>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
</div>
<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>

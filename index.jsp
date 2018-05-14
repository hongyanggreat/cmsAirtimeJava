<%@page import="java.util.ArrayList"%>
<%@page import="com.htc.airtime.components.Tool"%>
<%@page import="com.htc.airtime.components.Helper"%>
<%@page import="com.htc.airtime.model.Account"%>
<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="includes/head.jsp" %>
<%@include file="common.jsp" %>

<!--close-Header-part--> 

<!--top-Header-menu-->
<%@include file="includes/topMenu.jsp" %>
<!--close-top-Header-menu--> 
<!--left-menu-stats-sidebar-->
<%@include file="includes/mainMenu.jsp" %>
<!--close-left-menu-stats-sidebar-->
<div id="content">

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12"> 
                <div class="widget-box">
                    <div class="widget-content">
                        CHÀO MỪNG BẠN :  
                       
                        <%= nameUser %>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="includes/topFooter.jsp" %>
<%@include file="includes/footerJs.jsp" %>

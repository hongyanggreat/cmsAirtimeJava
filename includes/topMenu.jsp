<%-- 
    Document   : headMenu
    Created on : Sep 5, 2017, 11:56:03 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
    <ul class="nav">
       
        <li class=" dropdown" id="menu-messages"><a href="#" data-toggle="dropdown" data-target="#menu-messages" class="dropdown-toggle"><i class="icon icon-user"></i> <span class="text"><%= nameUser%> ---
                    <%= checkTypeUser%></span> <span class="label label-important">5</span> <b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a class="sAdd" title="" href="#">Xem thông tin user</a></li>
            </ul>
        </li>
        <li class=""><a title="" href="<%= baseUrl%>/logout" onclick="return confirm('Bạn có chắc muốn thoát?')" ><i class="icon icon-share-alt"></i> <span class="text">Logout</span></a></li>
    </ul>
</div>


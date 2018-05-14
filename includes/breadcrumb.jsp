<%-- 
    Document   : breakc
    Created on : Sep 5, 2017, 11:02:45 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="breadcrumb"> 
    <a href="/" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Trang chủ</a> 
    <!--nameModule ,nameAction được khai báo bên view action-->
    
    <a href="<%= baseUrl +"/"+ moduleSourse %>" class="tip-bottom"><% if(moduleName != ""){out.println(moduleName);
    } %></a> 
    <a href="#" class="current"><% if(actionName != ""){out.println(actionName);
    } %></a> 
</div>

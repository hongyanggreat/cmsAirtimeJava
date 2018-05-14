<%-- 
    Document   : success
    Created on : Nov 20, 2017, 4:10:18 PM
    Author     : Company
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Charge success</h1>
        <!--        hủy phien lam viec-->
        <%
            session.removeAttribute("mess");
            session.removeAttribute("dataGet");

        %>
    </body>
</html>

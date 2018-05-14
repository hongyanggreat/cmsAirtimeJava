<%-- 
    Document   : login
    Created on : Oct 14, 2017, 11:28:25 PM
    Author     : Admin
--%>

<%@page import="com.htc.airtime.components.Tool"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="includes/layoutLogin/header.jsp" %>
<%    if (!Tool.checkNull(session.getAttribute("acc"))) {
        response.sendRedirect(baseUrl+"/");
    }
%>
<style>
    .help-block{
        color: #d81b1b;
        display: inline-block;
    }
</style>
<%    String usename = "";
    String password = "";
    String remember = "";

    if (!Tool.checkNull(request.getParameter("username"))) {
        usename = request.getParameter("username");
    }
    if (!Tool.checkNull(request.getParameter("remember"))) {
        remember = "checked='checked'";
    }

%>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span6 offset3">
            <div class="widget-box">
                <div class="widget-title"  >
                    <h5 style="width: 100%; text-align: center">Đăng nhập</h5>
                </div>
                <div class="widget-content nopadding">

                    <form action="<%= baseUrl%>/login" name="myform" method="post" class="form-horizontal">
                        <div class="control-group">
                            <label class="control-label">Tài khoản :</label>
                            <div class="controls">
                                <input type="text" value="<%= usename%>" name="username" onchange="checkUserName(this)" class="span11" placeholder="Nhập tài khoản" />
                                <div class="help-block">
                                    <%
//                                        if (session.getAttribute("mess") == null || session.getAttribute("mess").equals(""))
                                        if (!Tool.checkNull(session.getAttribute("mess"))) {
                                    %>
                                    <%= session.getAttribute("mess")%>
                                    <%
                                            session.setAttribute("mess", null);
                                        }
                                    %>
                                </div>
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label">Mật khẩu</label>
                            <div class="controls">
                                <input type="password" name="password"  class="span11" placeholder="Nhập mật khẩu"  />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"></label>
                            <div class="controls">
                                <label>
                                    <input type="checkbox" name="remember" <%= remember%>/>
                                    Nhớ mật khẩu</label>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="submit" name="loginForm" class="btn btn-success">Đăng nhập</button>
                            <sapn style="margin-left: 20px;"><a href="">Quên mật khẩu</a></sapn>
                        </div>
                    </form>

                    <div class="control-group">
                        <label class="control-label"></label>
                        <div class="controls">

                        </div>
                    </div>

                    <?php ActiveForm::end(); ?>
                </div>
            </div>
        </div>

    </div>

</div>
<script>
    function checkUserName(input){
        
    }
</script>
<%@include file="includes/layoutLogin/footer.jsp" %>
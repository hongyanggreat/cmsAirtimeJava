<%-- 
    Document   : login
    Created on : Oct 17, 2017, 12:34:45 PM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    String baseUrl = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Trang đăng nhập [sv1]</title>
  <meta charset="<?= Yii::$app->charset ?>">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="<%= baseUrl %>/resource/css/bootstrap.min.css" />
  <link rel="stylesheet" href="<%= baseUrl %>/resource/css/bootstrap-responsive.min.css" />
  <link rel="stylesheet" href="<%= baseUrl %>/resource/css/colorpicker.css" />
  <link rel="stylesheet" href="<%= baseUrl %>/resource/css/datepicker.css" />
  <link rel="stylesheet" href="<%= baseUrl %>/resource/css/uniform.css" />
  <link rel="stylesheet" href="<%= baseUrl %>/resource/css/select2.css" />
  <link rel="stylesheet" href="<%= baseUrl %>/resource/css/maruti-style.css?v=1.2" />
  <link rel="stylesheet" href="<%= baseUrl %>/resource/css/maruti-media.css" class="skin-color" />
    
</head>
<body>

<!--Header-part-->
<div id="header">
  <h1><a href="dashboard.html">AriTime</a></h1>
</div>
<!--close-Header-part--> 

<%@page import="com.htc.airtime.dao.AccountDAO"%><%@page import="com.htc.airtime.components.Tool"%><%@page import="com.htc.airtime.model.Account"%><%@page import="com.htc.airtime.components.Helper"%><%@include file="../includes/checkLogin.jsp" %><!DOCTYPE html><html lang="en">
    <head>
        <title>CMS AirTime [sv1]</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="<%= baseUrl%>/resource/css/bootstrap.min.css" />
        <link rel="stylesheet" href="<%= baseUrl%>/resource/css/bootstrap-responsive.min.css" />
        <link rel="stylesheet" href="<%= baseUrl%>/resource/css/colorpicker.css" />
        <link rel="stylesheet" href="<%= baseUrl%>/resource/css/datepicker.css" />
        <link rel="stylesheet" href="<%= baseUrl%>/resource/css/uniform.css" />
        <link rel="stylesheet" href="<%= baseUrl%>/resource/css/select2.css" />
        <link rel="stylesheet" href="<%= baseUrl%>/resource/css/maruti-style.css?v=1.0" />
        <link rel="stylesheet" href="<%= baseUrl%>/resource/css/maruti-media.css" class="skin-color" />
        <script src ="<%= baseUrl%>/resource/js/jquery.min.js"></script> 
        <script src ="<%= baseUrl%>/resource/js/select2.min.js"></script>
        <style>
            .checker{
                vertical-align: initial;
            }
        </style>
    </head>
    <body>
        <div id="header"><!--Header-part-->
            <h1><a href="<%= baseUrl%>">CMS AirTime</a></h1>
        </div>
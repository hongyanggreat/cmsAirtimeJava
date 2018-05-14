<%@page import="java.util.ArrayList"%>
<%@page import="com.htc.airtime.model.UserServices"%>
<%@page import="com.htc.airtime.dao.UserServicesDAO"%>
<%@page import="com.htc.airtime.components.Helper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/checkLogin.jsp" %>
 <%@include file="../includes/airTime/infoSelect.jsp" %>
<%    boolean isPost = "POST".equals(request.getMethod());
    if (!isPost) {
        response.sendRedirect("/login.jsp");
        return;
    }
    UserServicesDAO userSv = new UserServicesDAO();

    ArrayList<UserServices> dts = null;
    if (Tool.checkNull(request.getParameter("cpCode"))) {
        response.sendRedirect("/login.jsp");
        return;
    }
    String cpCode = request.getParameter("cpCode");
    if(cpCode.equals("all")){
        dts = userSv.getListByField("1", "1",arrAcc);
    }else{
//        dts = userSv.getListByField("CP_CODE", cpCode);
        dts = userSv.getListByField("CP_CODE", cpCode,arrAcc);
    }
    if (dts != null && dts.size() > 0) {
%>
<option value="all">Chọn mã game</option>
<%
    for (UserServices dt : dts) {
%>
<option value="<%= dt.getCodeGame()%>" user="<%= dt.getUserName()%>" cpCode="<%= dt.getCpCode()%>" ak="<%= dt.getAccessKey()%>" ><%= dt.getCodeGame()%> - <%= dt.getGameName()%></option>
<%        }
} else {

%>
<option value="all">Không có dữ liệu</option>
<%    }
%>
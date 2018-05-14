<%@page import="com.htc.airtime.dao.AccountDAO"%><%@page import="com.htc.airtime.model.Account"%><%@page import="com.htc.airtime.components.Tool"%>
<%
    String baseUrl = request.getContextPath();
    if (Tool.checkNull(session.getAttribute("acc"))) {
        try {
            response.sendRedirect("/login.jsp");
            return;
        } catch (Exception e) {
            System.out.println("CO LOI NHA");
        }
    }
    String nameUser = "";
    String cpCodeUser = "";
    String checkTypeUser = "";
    int idUser = 0;
    Account acc = null;
    if (!Tool.checkNull(session.getAttribute("acc"))) {
        acc = (Account) session.getAttribute("acc");
        idUser = acc.getAccId();
        nameUser = acc.getUserName();
        cpCodeUser = acc.getCpCode();
        checkTypeUser = AccountDAO.TYPE.getType(acc.getUserType()).toString();
    }
%> 
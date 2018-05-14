<%-- 
    Document   : infoSelect
    Created on : Nov 5, 2017, 10:19:56 PM
    Author     : Admin
--%>
 <%@page import="com.htc.airtime.dao.UserServicesDAO"%>
<%@page import="com.htc.airtime.model.UserServices"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.htc.airtime.model.Account"%>
<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%  //          
            AccountDAO accSearch = new AccountDAO();
            ArrayList<Account> dtsAccSearch = null;
            ArrayList<Account> arrAcc = null;

            UserServicesDAO userServicecSearch = new UserServicesDAO();
            ArrayList<UserServices> dtsCodeGameSearch = null;
            switch (checkTypeUser) {
                case "USER":
                    break;
                case "ADMIN":
                    dtsAccSearch = accSearch.getListByField("STATUS", 1);
                    dtsCodeGameSearch = userServicecSearch.getListByField("STATUS", 1);
                    break;
                case "AGENCY":
                    arrAcc = dtsAccSearch = accSearch.getListAgency(idUser, 1);
                    dtsCodeGameSearch = userServicecSearch.getListByField(dtsAccSearch);
                    break;
                case "AGENCY_MANAGER":
                    arrAcc = dtsAccSearch = accSearch.getListAgency(idUser, 1);
                    dtsCodeGameSearch = userServicecSearch.getListByField(dtsAccSearch);
                    break;
                default:
//            dtsAccSearch = accSearch.getListByField("STATUS", 1);
//            dtsSearch = userServicecSearch.getListByField("STATUS", 1);
                    break;
            }
        %>
<%-- 
    Document   : infoSelect
    Created on : Nov 5, 2017, 10:19:56 PM
    Author     : Admin
--%>
<%@page import="com.htc.airtime.thread.AccountCacheManager"%>
<%@page import="com.htc.airtime.dao.UserServicesDAO"%>
<%@page import="com.htc.airtime.model.UserServices"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.htc.airtime.model.Account"%>
<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%  //        

    String keycache = "airTime_cacheAcc";
    ArrayList<Account> arrAcc = null;
    AccountDAO accDao = new AccountDAO();
    if (arrAcc != null) {
        System.out.println("----------------------");
        System.out.println("accCache" + arrAcc);
        System.out.println("----------------------");
    } else {
        System.out.println("LAY DU LIEU VA TAO CACHE");
        System.out.println("KHONG TON TAI CACHE TAI KHOAN NHE");
    }
    switch (checkTypeUser) {
        case "USER":
            break;
        case "ADMIN":
            arrAcc = (ArrayList<Account>) AccountCacheManager.get(keycache);
            break;
        case "AGENCY":
            arrAcc = accDao.getListAgency(idUser, 1);
            break;
        case "AGENCY_MANAGER":
            arrAcc = accDao.getListAgency(idUser, 1);
            break;
        default:
            break;
    }
    //===================================================
//    AccountDAO accSearch = new AccountDAO();
//    ArrayList<Account> dtsAccSearch = null;
//    
//
//    UserServicesDAO userServicecSearch = new UserServicesDAO();
//    ArrayList<UserServices> dtsCodeGameSearch = null;
//    switch (checkTypeUser) {
//        case "USER":
//            break;
//        case "ADMIN":
//            dtsAccSearch = accSearch.getListByField("STATUS", 1);
//            dtsCodeGameSearch = userServicecSearch.getListByField("STATUS", 1);
//            break;
//        case "AGENCY":
//            arrAcc = dtsAccSearch = accSearch.getListAgency(idUser, 1);
//            dtsCodeGameSearch = userServicecSearch.getListByField(dtsAccSearch);
//            break;
//        case "AGENCY_MANAGER":
//            arrAcc = dtsAccSearch = accSearch.getListAgency(idUser, 1);
//            dtsCodeGameSearch = userServicecSearch.getListByField(dtsAccSearch);
//            break;
//        default:
////            dtsAccSearch = accSearch.getListByField("STATUS", 1);
////            dtsSearch = userServicecSearch.getListByField("STATUS", 1);
//            break;
//    }
%>
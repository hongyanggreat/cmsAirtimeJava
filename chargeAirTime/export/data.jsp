<%@page import="com.htc.airtime.components.Helper"%>
<%@page import="com.htc.airtime.components.MyDate"%>
<%@page import="com.htc.airtime.components.DateProc"%>
<%@page import="com.htc.airtime.components.Tool"%>
<%@page import="com.htc.airtime.dao.ChargeAirTimeDAO"%>
<%@page import="com.htc.airtime.model.ChargeAirTime"%>
<%@page import="com.htc.airtime.model.Account"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="java.util.ArrayList"%>
<%@page autoFlush="true"  %>
<%@page contentType="text/html; charset=utf-8" %> 
<%@include file="../../includes/checkLogin.jsp" %>
<%@include file="../../includes/airTime/infoSelect.jsp" %>
<%    try {
//        Account userlogin = Account.getAccount(session);
//        if (userlogin == null) {
//            response.sendRedirect(request.getContextPath() + "/login.jsp");
//            return;
//        }
        //--
        request.setCharacterEncoding("UTF-8");
        String price = "0";
        String cpCode = "";
        String cpName = "";
        String cpGame = "";
        String msisdn = "";

        int limit = 0;
        int offset = 0;
        int pages = 1;

        String formDate = MyDate.createDate("MM") + "/01/" + MyDate.createDate("yyyy");
        String toDate = MyDate.createDate("MM/dd/yyyy");

        if (!Tool.checkNull(request.getParameter("price"))) {
            price = request.getParameter("price");
        }
        if (!Tool.checkNull(request.getParameter("cpCode"))) {
            cpCode = request.getParameter("cpCode");
        }
        if (!Tool.checkNull(request.getParameter("cpName"))) {
            cpName = request.getParameter("cpName");
        }
        if (!Tool.checkNull(request.getParameter("cpGame"))) {
            cpGame = request.getParameter("cpGame");
        }
        if (!Tool.checkNull(request.getParameter("msisdn"))) {
            msisdn = request.getParameter("msisdn");
        }
        if (!Tool.checkNull(request.getParameter("formDate"))) {
            formDate = request.getParameter("formDate");
        }
        if (!Tool.checkNull(request.getParameter("toDate"))) {
            toDate = request.getParameter("toDate");
        }
        if (!Tool.checkNull(request.getParameter("numberLimit"))) {
            limit = Integer.parseInt(request.getParameter("numberLimit"));
        }
        if (!Tool.checkNull(request.getParameter("pages"))) {
            pages = Integer.parseInt(request.getParameter("pages"));
        }
        if (!Tool.checkNull(request.getParameter("offset"))) {
            offset = Integer.parseInt(request.getParameter("offset"));
        }

//        offset = (pages - 1) * limit;
        ChargeAirTimeDAO chargeAirTime = new ChargeAirTimeDAO();
        ArrayList<ChargeAirTime> dts = chargeAirTime.getListSearch(price, cpCode, cpName, cpGame, msisdn, formDate, toDate, limit, offset, arrAcc);

        out.clear();
        out = pageContext.pushBody();
        createExcel(dts, response);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<ChargeAirTime> allLog, HttpServletResponse response) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
//        Map<String, Object[]> data = new HashMap<String, Object[]>();
        ArrayList<Object[]> data = new ArrayList();
        double totalAmount = 0;
        double totalRequest = 0;
        String status = "";
        data.add(new Object[]{
            "STT",
            "Thời gian",
            "Số điện thoại",
            "Số tiền",
            "Mã OTP",
            "Trạng thái",
            "Mã CP",
            "Tên CP",
            "Game CP",});
        int i = 1;
        for (ChargeAirTime one : allLog) {
            if (one.getRS_MPS() != "0") {
                status = "Thành công";
            } else {
                status = "Thất bại";
            }

            data.add(new Object[]{
                Integer.toString(i++),
                one.getREQUEST_TIME(),
                one.getMSISDN(),
                (double) one.getPRICE(),
                one.getOTP(),
                status,
                one.getCP_CODE(),
                one.getUSER_NAME(),
                one.getGAME_CODE(),//END
            });
        }
        int rownum = 0;
        for (Object[] objArr : data) {
            Row row = sheet.createRow(rownum++);
            int cellnum = 0;
            for (Object obj : objArr) {
                Cell cell = row.createCell(cellnum++);
                if (obj instanceof Date) {
                    cell.setCellValue((Date) obj);
                } else if (obj instanceof Boolean) {
                    cell.setCellValue((Boolean) obj);
                } else if (obj instanceof String) {
                    cell.setCellValue((String) obj);
                } else if (obj instanceof Double) {
                    cell.setCellValue((Double) obj);
                } else {
                    cell.setCellValue((String) obj);
                }
            }
        }
//        System.out.println("2222222222");

        try {
            ServletOutputStream os = null;
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=DataChargeAirTime-page" + DateProc.createDDMMYYYY() + ".xlsx");
            os = response.getOutputStream();
            os.flush();
            workbook.write(os);
            System.out.println("Excel written successfully..");
        } catch (Exception e) {
            // e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }


%>
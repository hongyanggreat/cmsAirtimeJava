<%-- 
    Document   : exportStatistic
    Created on : Nov 24, 2017, 3:05:25 PM
    Author     : Company
--%>

<%@page import="java.util.regex.Pattern"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="com.htc.airtime.components.DateProc"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="com.htc.airtime.model.AirtimeReq"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URL"%>
<%@page import="com.htc.airtime.components.Tool"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String baseUrl = request.getContextPath();

    if (!Tool.checkNull(session.getAttribute("reqAllHistoryExport"))) {
        String pages = "";
        if (!Tool.checkNull(request.getParameter("pages"))) {
            String possibleNumber = request.getParameter("pages");
            boolean isNumber = Pattern.matches("[0-9]+", possibleNumber);
            if (isNumber && (Integer.parseInt(possibleNumber) > 0)) {
                pages = possibleNumber;
            }
        }
//        out.println("LAY DU LIEU VA XUAT FILE");
        ArrayList<AirtimeReq> datas = (ArrayList<AirtimeReq>) session.getAttribute("reqAllHistoryExport");
        out.clear();
        out = pageContext.pushBody();
        createExcel(datas, response, pages);
//        SAU KHI XUAT FILE THANH CONG HUY SESS
        session.removeAttribute("reqAllHistoryExport");
    } else {
        session.removeAttribute("otpHistoryExport");
        out.println("Xuất file thất bại.Vui lòng thực hiện lại");
    }
%>


<%!
    public static void createExcel(ArrayList<AirtimeReq> allLog, HttpServletResponse response, String pages) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
//        Map<String, Object[]> data = new HashMap<String, Object[]>();
        ArrayList<Object[]> data = new ArrayList();
        int totalAmount = 0;
        int totalRequest = 0;
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
        for (AirtimeReq one : allLog) {
            if (one.getRsMps().equals("4")) {
                status = "Thành công";
            } else {
                status = "Thất bại";
            }
            totalAmount += one.getPrice();
            totalRequest++;
            data.add(new Object[]{
                (double) i++,
                one.getReqTime(),
                one.getMsisdn(),
                (double) one.getPrice(),
                one.getOtp(),
                status,
                one.getCpCode(),
                one.getUserName(),
                one.getGameCode(),//END
            });
        }
//        data.add(new Object[]{
//            (double) totalRequest, "", "",
//            (double) totalAmount,
//            "", "", "", "", ""
//        });
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
        try {
            ServletOutputStream os = null;
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=all-history-" + DateProc.createDDMMYYYY() + "-" + pages + ".xlsx");
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
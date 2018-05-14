<%-- 
    Document   : exportStatistic
    Created on : Nov 24, 2017, 3:05:25 PM
    Author     : Company
--%>

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
    if (!Tool.checkNull(session.getAttribute("chargingStatisticExport"))) {
//        out.println("LAY DU LIEU VA XUAT FILE");
        ArrayList<AirtimeReq> datas = (ArrayList<AirtimeReq>) session.getAttribute("chargingStatisticExport");
        out.clear();
        out = pageContext.pushBody();
        createExcel(datas, response);
//        SAU KHI XUAT FILE THANH CONG HUY SESS
        session.removeAttribute("chargingStatisticExport");
    } else {
        session.removeAttribute("chargingStatisticExport");
        out.println("Xuất file thất bại.Vui lòng thực hiện lại");
    }
%>


<%!
    public static void createExcel(ArrayList<AirtimeReq> allLog, HttpServletResponse response) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
//        Map<String, Object[]> data = new HashMap<String, Object[]>();
        ArrayList<Object[]> data = new ArrayList();
        int totalAmount = 0;
        int totalRequest = 0;
        String status = "";
        data.add(new Object[]{
            "STT",
            "Tên CP",
            "Mã CP",
            "Game CP",
            "Trạng thái",
            "Số tiền",
            "Số request",});
        int i = 1;
        for (AirtimeReq one : allLog) {
            if (one.getRsMps().equals("0")) {
                status = "Thành công";
            } else {
                status = "Thất bại";
            }
            totalAmount += one.getTotalAmount();
            totalRequest += one.getTotalReq();
            data.add(new Object[]{
                (double) i++,
                one.getUserName(),
                one.getCpCode(),
                one.getGameCode(),
                status,
                (double) one.getTotalAmount(),
                (double) one.getTotalReq(), //END
            });
        }
        data.add(new Object[]{
            "", "", "", "", "",
            (double)totalAmount, (double)totalRequest,
            "", "", "", "", "", ""
        });
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
            response.setHeader("Content-Disposition", "attachment; filename=Thong-ke-charging-" + DateProc.createDDMMYYYY() + ".xlsx");
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
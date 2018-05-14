<%@page import="java.util.ArrayList"%>
<%@page import="com.htc.airtime.dao.AccountDAO"%>
<%@page import="com.htc.airtime.model.UserPermission"%>
<%@page import="com.htc.airtime.dao.UserPermissionDAO"%>
<%@include file="../includes/head.jsp" %>
<%@include file="common.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  //  
    AccountDAO account = new AccountDAO();
    boolean checkPermission = account.checkList(request, session);
    Helper.cPermission(response, checkPermission);

    String actionName = "Danh sách";

    int idAcc = 0;
    idAcc = Integer.parseInt(request.getParameter("id"));
    boolean checkChild = AccountDAO.checkIsParent(idAcc, idUser);
    if(!checkChild){
        response.sendRedirect(baseUrl +"/"+moduleSourse);
        return;
    }
    UserPermissionDAO userPermission = new UserPermissionDAO();
    ArrayList<UserPermission> dts = userPermission.getListModuleUserPermission(idAcc);
    ArrayList<String> ArrayModuleAllow = new ArrayList<String>(4);
    
    ArrayModuleAllow.add("otpAirTime");
    ArrayModuleAllow.add("chargeAirTime");
    ArrayModuleAllow.add("errorOtpAirTime");
    ArrayModuleAllow.add("errorChargeAirTime");
    
//    System.out.println("ArrayModuleAllow" + ArrayModuleAllow);

%>

<!--close-Header-part--> 

<!--top-Header-menu-->
<%@include file="../includes/topMenu.jsp" %>
<!--close-top-Header-menu--> 
<!--left-menu-stats-sidebar-->
<%@include file="../includes/mainMenu.jsp" %>
<!--close-left-menu-stats-sidebar-->

<div id="content">
    <div id="content-header">
        <%@include file="../includes/breadcrumb.jsp" %>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title">
                        <span class="icon"><i class="icon-th"></i></span> 
                        <h5>Danh sách quyền</h5>
                        <% //if (account.checkList(request, session)) {%>
                        <span class="icon"><a class="" href="<%= baseUrl%>/<%= moduleSourse%>" title="Thêm mới" style="padding:0 2px;">
                                <img  width="18" src="<%=baseUrl%>/resource/images/icon/home.png" alt=""> Danh sách</a>
                        </span>
                        <%//}%>
                    </div>
                    <div class="widget-content nopadding">
                        <form action="<%= request.getContextPath()%>/addUserPermissionChild" name="myform" method="post" class="form-horizontal">
                            <input type="hidden" name="idAcc" class="span11" value="<%=idAcc%>" placeholder="Id Account" />
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th class="hide">Tên module</th>
                                        <th class="hide">Tên module</th>
                                        <th class="hide">Tên module</th>
                                        <th >Tên module</th>
                                        <th >Tên module</th>
                                        <th colspan="2">Trạng thái</th>
                                        <th colspan="8">Quyền</th>

                                        <th>Thực hiện</th>
                                    </tr>
                                    <tr>
                                        <th></th>
                                        <th class="hide">ID Module</th>
                                        <th class="hide">ID Module</th>
                                        <th class="hide">action Module</th>
                                        <th>Module</th>
                                        <th>Resourse</th>
                                        <th >Module</th>
                                        <th ><input type="checkbox" class="checkAllModule permission" id="permission" name="radios" /><br>Kích hoạt</th>
                                        <th ><span><input type="checkbox" class="checkAllModule all" id="all" name="radios" /><br>All</span></th>
                                        <th ><span><input type="checkbox" class="checkAllModule list" id="list"  name="radios" /><br>List</span></th>
                                        <th ><span><input type="checkbox" class="checkAllModule view" id="view" name="radios" /><br>Xem</span></th>
                                        <th ><span><input type="checkbox" class="checkAllModule add" id="add" name="radios" /><br>Thêm</span></th>
                                        <th ><span><input type="checkbox" class="checkAllModule edit" id="edit" name="radios" /><br>Sửa</span></th>
                                        <th ><span><input type="checkbox" class="checkAllModule delelete" id="delete" name="radios" /><br>Xóa</span></th>
                                        <th ><span><input type="checkbox" class="checkAllModule upload" id="upload" name="radios" /><br>Upload</span></th>
                                        <th ><span><input type="checkbox" class="checkAllModule download" id="download" name="radios" /><br>Download</span></th>

                                        <th>
                                            <button type="submit" class="btn userPermissionSubmit" name="updateOne" value="updateAll"> <img  width="20" src="<%= baseUrl%>/resource/images/icon/update.png" alt=""> Update all</button>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int i = 0;
                                        for (UserPermission dt : dts) {
                                            if (ArrayModuleAllow.contains(dt.getRESOURCE())) {
                                                System.out.println("+" + dt.getRESOURCE());
                                                i++;

                                                int idModule = dt.getMODULE_ID();

                                                int statusModule = dt.getSTATUSMODULE();
                                                int isRight = dt.getIS_RIGHT();
                                                String strNameSubmitButton = "";
                                                String nameSubmitButton = "";
                                                String imgSubmitButton = "";
                                                if (isRight == 1) {
                                                    nameSubmitButton = "updateOne";
                                                    imgSubmitButton = "update";
                                                    strNameSubmitButton = "Cập nhật";
                                                } else {
                                                    nameSubmitButton = "addOne";
                                                    imgSubmitButton = "add";
                                                    strNameSubmitButton = "Thêm mới";
                                                }
                                                String imgStatusModule = "";

                                                if (statusModule == 0) {
                                                    imgStatusModule = Helper.getImageIcon("inActive", baseUrl);
                                                } else if (statusModule == 1) {
                                                    imgStatusModule = Helper.getImageIcon("active", baseUrl);
                                                } else {
                                                    imgStatusModule = Helper.getImageIcon("disable", baseUrl);
                                                }
                                                boolean allRight = dt.isALL_RIGHT();
                                                boolean listRight = dt.isLIST_RIGHT();
                                                boolean viewRight = dt.isVIEW_RIGHT();
                                                boolean addRight = dt.isADD_RIGHT();
                                                boolean editRight = dt.isEDIT_RIGHT();
                                                boolean deleteRight = dt.isDEL_RIGHT();
                                                boolean upRight = dt.isUP_RIGHT();
                                                boolean downRight = dt.isDOWN_RIGHT();
                                                int status = dt.getSTATUS();
                                                //checked Right
                                                String checkallRight = "";
                                                String checklistRight = "";
                                                String checkviewRight = "";
                                                String checkaddRight = "";
                                                String checkeditRight = "";
                                                String checkdeleteRight = "";
                                                String checkupRight = "";
                                                String checkdownRight = "";
                                                String checkstatus = "";

                                                if (allRight) {
                                                    checkallRight = "checked";
                                                }
                                                if (listRight) {
                                                    checklistRight = "checked";
                                                }
                                                if (viewRight) {
                                                    checkviewRight = "checked";
                                                }
                                                if (addRight) {
                                                    checkaddRight = "checked";
                                                }
                                                if (editRight) {
                                                    checkeditRight = "checked";
                                                }
                                                if (deleteRight) {
                                                    checkdeleteRight = "checked";
                                                }
                                                if (upRight) {
                                                    checkupRight = "checked";
                                                }
                                                if (downRight) {
                                                    checkdownRight = "checked";
                                                }
                                                if (status == 1) {
                                                    checkstatus = "checked";
                                                }


                                    %> 
                                    <tr class="gradeX" info="<%= nameSubmitButton%>" >
                                        <td style="width:30px;text-align:center"><%= i%></td>
                                        <td class="hide"><%= idModule%></td>
                                        <td class="hide">
                                            <input type="checkbox"  class="checkboxIdModule" name="idModule<%= idModule%>" value="<%= idModule%>" />
                                        </td>
                                        <td class="hide">
                                            <input type="checkbox"  class="checkboxActionModule" name="actionModule<%= idModule%>" value="<%= nameSubmitButton%>" />
                                        </td>
                                        <td><%= dt.getMODULE_NAME()%></td>
                                        <td><%= dt.getRESOURCE()%></td>
                                        <td style="width:50px;text-align: center;">
                                            <span>
                                                <%= imgStatusModule%>
                                            </span>
                                        </td>
                                        <td style="width:50px;text-align: center;"><span> <input type="checkbox" <%= checkstatus%> class="checkRightPermission checkboxpermission" name="status<%= idModule%>" /></span></td>
                                        <td style="width:40px;text-align: center;"><span> <input type="checkbox" <%= checkallRight%> class="checkRightPermission checkboxall" title="All Right" name="allRight<%= idModule%>" /></span></td>
                                        <td style="width:40px;text-align: center;"><span> <input type="checkbox" <%= checklistRight%> class="checkRightPermission checkboxlist" title="List Right" name="listRight<%= idModule%>" /></span></td>
                                        <td style="width:40px;text-align: center;"><span> <input type="checkbox" <%= checkviewRight%> class="checkRightPermission checkboxview" title="View Right" name="viewRight<%= idModule%>" /></span></td>
                                        <td style="width:40px;text-align: center;"><span> <input type="checkbox" <%= checkaddRight%> class="checkRightPermission checkboxadd" title="Add Right" name="addRight<%= idModule%>" /></span></td>
                                        <td style="width:40px;text-align: center;"><span> <input type="checkbox" <%= checkeditRight%> class="checkRightPermission checkboxedit" title="Edit Right" name="editRight<%= idModule%>" /></span></td>
                                        <td style="width:40px;text-align: center;"><span> <input type="checkbox" <%= checkdeleteRight%> class="checkRightPermission checkboxdelete" title="Delete Right" name="deleteRight<%= idModule%>" /></span></td>
                                        <td style="width:40px;text-align: center;"><span> <input type="checkbox" <%= checkupRight%> class="checkRightPermission checkboxupload" title="Upload Right" name="upRight<%= idModule%>" /></span></td>
                                        <td style="width:40px;text-align: center;"><span> <input type="checkbox" <%= checkdownRight%> class="checkRightPermission checkboxdownload" title="Download Right" name="downRight<%= idModule%>" /></span></td>
                                        <td style="width:150px;text-align:center">
                                            <button type="submit" class="btn userPermissionSubmit" name="<%= nameSubmitButton%>" value="<%= idModule%>"> <img  width="20" src="<%= baseUrl%>/resource/images/icon/<%= imgSubmitButton%>.png" alt=""> <%= strNameSubmitButton%></button>
                                        </td>

                                    </tr>
                                    <% }%>
                                    <% }%>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<%@include file="../includes/topFooter.jsp" %>
<%@include file="../includes/footerJs.jsp" %>

<script>

    $(document).ready(function () {
        var baseUrl = window.location.origin;
        $("body").on("click", '.checkAllModule', function () {
            var id = $(this).attr('id');
            var checkbox = 'checkbox' + id;
            //alert(checkbox);
            //$(checkbox)
            if ($(this).hasClass('onchecked')) {
                $('.' + checkbox).prop('checked', false);
                $('.' + checkbox).parent('span').removeClass('checked');

//                $('.checkboxIdModule,.checkboxActionModule').prop('checked', false);
//                $('.checkboxIdModule,.checkboxActionModule').parent('span').removeClass('checked');

                $(this).removeClass('onchecked');
            } else {
                $('.' + checkbox).prop('checked', true);
                $('.' + checkbox).parent('span').addClass('checked');

                $('.checkboxIdModule,.checkboxActionModule').prop('checked', true);
                $('.checkboxIdModule,.checkboxActionModule').parent('span').addClass('checked');



                $(this).addClass('onchecked');
            }
        });

        $("body").on("click", '.checkRightPermission', function () {
            $(this).closest("tr").find('.checkboxIdModule').prop('checked', true);
            $(this).closest("tr").find('.checkboxIdModule').parent('span').addClass('checked');
            $(this).closest("tr").find('.checkboxActionModule').prop('checked', true);
            $(this).closest("tr").find('.checkboxActionModule').parent('span').addClass('checked');
        });
        $('.userPermissionSubmit').hover(function () {
            var nameSubmit = $(this).parent().parent().attr('info');
            console.log(nameSubmit);
            $(this).attr('name', nameSubmit);
        });


    });
</script>
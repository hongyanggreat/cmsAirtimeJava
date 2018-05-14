<%-- 
    Document   : paginator
    Created on : Sep 14, 2017, 4:39:45 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    System.out.println("Tong so trang = :" + totalPage);
    System.out.println("Trang hien tai = :" + pages);
    System.out.println("Action = :" + actionPage);
    System.out.println("ParamPage = :" + paramPage);
    
    if(totalPage != 1 && totalPage>= pages ){
        String disabledPrev = "";
        String disabledNext = "";
        int numberPagePrev = 0;
        int numberPageNext = 0;
        
        if(totalPage>= pages){
            if(pages == 1){
                    disabledPrev = "disabled";
            }else{
                if(pages > 1){
                  numberPagePrev = pages - 1;
                }else{
                  disabledPrev = "disabled"; 
                }
            }
            if(pages == totalPage){
                disabledNext = "disabled";
            }else{
                numberPageNext = pages + 1;
            }
        }
       %>
        <%
            //Sử lý cho trang đầu tiên
            String linkFirst = "";
            String disabledFirst = "disabled";
            if(pages != 1){
                disabledFirst = "";
                linkFirst = "href='"+actionPage +"1"+paramPage+"'";
            }
        %>
        <li class="<%= disabledFirst %>" title="Trang đầu"><a <%= linkFirst %> >Trang đầu</a></li>
        <!--//Sử lý cho trang trước-->
        <li class="<%= disabledPrev %>" title="Trang trước">
            <a 
                <%
                    if(numberPagePrev > 0){
                        out.print("href='"+actionPage + numberPagePrev + paramPage+"'");
                    }
                %>
            >Prev
            </a>
        </li>
        <!--//Sử lý cho trang liên quan-->
        <%
        int forLine = 0;  
        if(totalPage > 5){
            forLine = 7;
        }else{
            forLine = (totalPage + 2);
        }
       
          String linkPage ="";
          String active ="";
          int pageLine =0;
          int numberPage =0;
          String  titlePage = "";

          for (int j=0; j < forLine ; j++) { 
              active ="";
              pageLine = 0;
              if(pages >= 3){
                  pageLine = 5;
              }else if(pages == 2){
                  if(totalPage >=5){
                    pageLine = 6;
                  }else{
                    pageLine = 5;
                  }
              }else{
                  pageLine = 7;
              }
              if(j<pageLine){
                  switch (j) {
                    case 0:
                      numberPage = 0;
                      if(pages >=3){
                        numberPage = pages - 2;
                      }
//                      System.out.println("case0");
                      break;
                    case 1:
                      numberPage = 0;
                      if(pages >=2){
                        numberPage = pages - 1;
                      }
//                      System.out.println("case1");
                      break;
                    case 2:
                      numberPage = pages;
                      active ="active";
//                      System.out.println("case2");
                      break;
                    case 3:
                      numberPage = 0;
                      if(pages < totalPage){
                        numberPage = pages + 1;
                      }
//                      System.out.println("case3");
                      break;
                    case 4:
                      numberPage = 0;
                      if(pages < totalPage && (totalPage - pages) >=2){
                        numberPage = pages + 2;
                      }
//                      System.out.println("case4");
                      break;
                    //TH page < 3
                    case 5:
                      if(pages < 5){
                        numberPage = pages + 3;
                      }
//                      System.out.println("case5");
                      break;
                     case 6:
                      if(pages < 5){
                        numberPage = pages + 4;
                      }
//                      System.out.println("case6");
                      break;
                    case 7:
                      if(pages < 5){
                        numberPage = pages + 5;
                      }
//                      System.out.println("case7");
                      break;
                    
                    default:
//                      System.out.println("caseDefault");
                      numberPage = 0;
                      break;
                  }
                  if(numberPage > 0){
                    linkPage = actionPage+numberPage+paramPage;
                    titlePage = "Trang "+ numberPage;
                    if(active.equals("active")){
                        out.println("<li class='"+active+"' title='"+titlePage+"'><a>"+numberPage+"</a> </li>");        
                    }else{
                        out.println("<li class='"+active+"' title='"+titlePage+"'><a href='"+linkPage+"'>"+numberPage+"</a> </li>");        
                    }
                  }
              }
          }
        %>
        <!--//Sử lý cho Trang kế tiếp-->
        <li class="<%= disabledNext %>" title="Trang kế tiếp"><a <%
            if(numberPageNext > 0){
                out.print("href='"+actionPage + numberPageNext + paramPage + "'");
            }
        %>>Next</a></li>
        <!--//Sử lý cho Trang cuối-->
        <%
            String linkLast = "";
            String disabledLast = "disabled";
            if(totalPage != pages){
                disabledLast = "";
                linkLast = "href='"+actionPage + totalPage + paramPage +"'";
            }
        %>
        <li class="<%= disabledLast %>" title="Trang cuối"><a <%= linkLast %> >Trang cuối</a></li>
    <%
        }
    %>
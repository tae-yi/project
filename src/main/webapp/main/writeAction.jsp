 <%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="bbs.BbsDAO"%>
<%@page import="java.io.PrintWriter"%>    <%-- javascript 문장을 작성하기 위해 사용--%>
<%request.setCharacterEncoding("UTF-8");%> <%--건너오는 모든 데이터를 utf-8로받을수 있도록 함 --%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" /> <%--scope=page: 현재페이지안에서만 빈즈가 사용되도록함 --%>
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html> <!-- 사용자에게 로그인 결과를 보여주는 화면 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
   <%
   String userID = null;
   if (session.getAttribute("userID") != null) {
      userID = (String) session.getAttribute("userID");
   }
   if (userID == null) {
      PrintWriter script = response.getWriter();
       script.println("<script>");
       script.println("location.href ='login.jsp'");
       script.println("</script>");
   } else {
      if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안된 사항이 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
      } else {
    	 BbsDAO bbsDAO = new BbsDAO(); 
         int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
         if (result == -1) {
               PrintWriter script = response.getWriter();
               script.println("<script> ");
               script.println("alert('글쓰기에 실패했습니다.')");
               script.println("history.back()");
               script.println("</script>");
         }
         else {
               PrintWriter script = response.getWriter();
               script.println("<script>");
               script.println("location.href ='bbs.jsp'");
               script.println("</script>");
         }
      }
   }
   
   %>
</body>
</html>
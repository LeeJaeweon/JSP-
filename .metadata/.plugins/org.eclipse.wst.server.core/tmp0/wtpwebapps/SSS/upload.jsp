<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- PrintWriter를 추가 -->

<%
    // 클라이언트에서 전송된 문의 내용을 받아옵니다.
    String message = request.getParameter("message");

    // 받아온 문의 내용을 파일로 저장합니다. 이 부분을 데이터베이스 저장으로 변경할 수 있습니다.
    String filePath = getServletContext().getRealPath("/") + "FAQ/message.xml";
    
    // 다른 이름으로 PrintWriter 변수를 선언하세요.
    try (PrintWriter fileWriter = new PrintWriter(filePath)) {
        fileWriter.write(message);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

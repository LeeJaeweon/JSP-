<%@ page language="java" contentType="image/jpeg; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // 이미지 파일의 경로 (images 디렉토리에 저장된 이미지 파일 경로로 대체해야 합니다)
    String imagePath = "images/email.png"; 

    // 이미지 파일 경로를 실제 서버 경로로 변경
    String realPath = application.getRealPath(imagePath);

    // 이미지 파일을 읽기 위한 스트림 생성
    java.io.FileInputStream fis = new java.io.FileInputStream(realPath);

    // 응답 헤더 설정
    response.setContentType("image/jpeg"); // 이미지 타입에 따라 변경
    response.setHeader("Content-Disposition", "inline; filename=\"" + imagePath + "\"");

    // 이미지 데이터를 클라이언트로 전송
    java.io.OutputStream os = response.getOutputStream();
    byte[] buffer = new byte[4096];
    int bytesRead = -1;
    while ((bytesRead = fis.read(buffer)) != -1) {
        os.write(buffer, 0, bytesRead);
    }

    // 스트림 닫기
    fis.close();
    os.close();
%>
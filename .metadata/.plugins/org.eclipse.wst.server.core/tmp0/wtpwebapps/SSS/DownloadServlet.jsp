<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.File, java.io.FileInputStream, java.io.IOException, java.io.OutputStream" %>
<%
    String fileName = request.getParameter("file");
    if (fileName == null || fileName.isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        return;
    }

    String filePath = "/files/" + fileName; // 파일 경로 설정
    File file = new File(getServletContext().getRealPath(filePath));
    if (!file.exists()) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
        return;
    }

    String contentType = getServletContext().getMimeType(file.getAbsolutePath());
    if (contentType == null) {
        contentType = "application/octet-stream";
    }

    response.setContentType(contentType);
    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

    try (FileInputStream fileInputStream = new FileInputStream(file);
         OutputStream outputStream = response.getOutputStream()) {

        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = fileInputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
    } catch (IOException e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
%>

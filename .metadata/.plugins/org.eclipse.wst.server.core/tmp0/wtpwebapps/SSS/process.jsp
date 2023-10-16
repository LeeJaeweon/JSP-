<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="org.w3c.dom.*" %>
<%@ page import="org.xml.sax.InputSource" %>

<%
    if(request.getContentType().startsWith("multipart/form-data")) {
        try {
            Part filePart = request.getPart("xmlFile");
            InputStream fileContent = filePart.getInputStream();
            
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            // XXE 취약점을 활성화 (실제 환경에서는 하면 안 됨)
            dbFactory.setExpandEntityReferences(true);
            
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(new InputSource(fileContent));

            // XML의 내용을 읽어와 화면에 출력
            Element root = doc.getDocumentElement();
            out.print("Root element: " + root.getNodeName());

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>

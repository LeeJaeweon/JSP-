<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*" %>

<%
    // 사용자 정보를 파라미터로부터 가져옵니다.
    String name = request.getParameter("name");
    String userID = request.getParameter("userID");
    String email = request.getParameter("email");
    String tel = request.getParameter("tel");

    // XML 파일 경로 (필요에 따라 경로를 수정하세요)
    String xmlFilePath = "userInfo.xml";

    // XML 파일에 사용자 정보를 저장합니다.
    try {
        File file = new File(xmlFilePath);

        // XML 파일이 없으면 새로 생성하고 루트 엘리먼트 생성
        if (!file.exists()) {
            PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(xmlFilePath)));
            out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            out.println("<users>");
            out.close();
        }

        // 기존 XML 파일 열기
        BufferedReader br = new BufferedReader(new FileReader(xmlFilePath));
        String line;
        StringBuilder xmlContent = new StringBuilder();
        while ((line = br.readLine()) != null) {
            xmlContent.append(line);
        }
        br.close();

        // 새로운 사용자 정보를 XML에 추가
        xmlContent.insert(xmlContent.indexOf("</users>"), "    <user>\n" +
                "        <name>" + name + "</name>\n" +
                "        <userID>" + userID + "</userID>\n" +
                "        <email>" + email + "</email>\n" +
                "        <tel>" + tel + "</tel>\n" +
                "    </user>\n");

        // XML 파일 업데이트
        PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(xmlFilePath)));
        out.print(xmlContent.toString());
        out.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 정보 저장 완료</title>
</head>
<body>
    <div class="container">
        <h1>사용자 정보 저장 완료</h1>
        <p>사용자 정보가 성공적으로 저장되었습니다.</p>
        <p><a href="userInfo.jsp">다른 사용자 정보 입력</a></p>
    </div>
</body>
</html>

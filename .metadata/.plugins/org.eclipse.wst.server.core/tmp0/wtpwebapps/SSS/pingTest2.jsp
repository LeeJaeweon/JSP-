<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>핑 테스트</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <style>
        .center-text {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-12 center-text"><br><br>
                <h1>핑 테스트</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-12 center-text">
                <form method="post" action="pingTest2.jsp">
                    <input type="text" name="domain" placeholder="도메인을 입력하세요">
                    <button type="submit">핑 테스트 시작</button>
                </form>
            </div>
        </div>

        <%
        String domain = request.getParameter("domain");
        
        if (domain != null && !domain.isEmpty()) {
            try {
                String[] cmd = { "cmd.exe", "/c", "ping " + domain }; // 커맨드 인젝션 시도
                Process process = Runtime.getRuntime().exec(cmd);

                java.io.BufferedReader reader = new java.io.BufferedReader(new java.io.InputStreamReader(process.getInputStream(), "EUC-KR"));
                String line;
                StringBuilder output = new StringBuilder();
                while ((line = reader.readLine()) != null) {
                    output.append(line).append("<br>");
                }
                reader.close();
                
                out.println("<pre>" + output.toString() + "</pre>");

                int exitCode = process.waitFor();
                if (exitCode != 0) {
                    out.println("<p>실행 중 오류가 발생했습니다.</p>");
                }
            } catch (Exception e) {
                out.println("<p>오류가 발생하였습니다: " + e.getMessage() + "</p>");
            }
        }
        %>
        
        <div class="row">
            <div class="col-12 center-text">
                <table class="table table-bordered table-striped">
                    <!-- 테이블 내용 생략 -->
                </table>
            </div>
        </div>
    </div>

    <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
</body>
</html>

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
                <form method="post" action="pingTest.jsp">
                    <input type="text" name="domain" placeholder="도메인을 입력하세요">
                    <button type="submit">핑 테스트 시작</button>
                </form>
            </div>
        </div>

        <% 
        String domain = request.getParameter("domain"); // 입력된 도메인 가져오기
        
        if (domain != null && !domain.isEmpty()) {
            try {
                String command = "ping " + domain;
                Process process = Runtime.getRuntime().exec(command); // 명령 프롬프트 명령 실행

                java.io.BufferedReader reader = new java.io.BufferedReader(new java.io.InputStreamReader(process.getInputStream(), "EUC-KR")); // 문자 인코딩 설정
                String line;
                StringBuilder output = new StringBuilder();
                while ((line = reader.readLine()) != null) {
                    output.append(line).append("<br>");
                }
                reader.close(); // BufferedReader 닫기
                
                out.println("<pre>" + output.toString() + "</pre>"); // 결과 출력

                int exitCode = process.waitFor();
                if (exitCode != 0) {
                    out.println("<p>핑 테스트 실행 중 오류가 발생했습니다.</p>");
                }
            } catch (Exception e) {
                out.println("<p>오류가 발생하였습니다: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p></p>");
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

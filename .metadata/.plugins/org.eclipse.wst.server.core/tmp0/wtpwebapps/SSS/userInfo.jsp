<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 정보 입력</title>
</head>
<body>
    <div class="container">
        <h1>사용자 정보 입력</h1>
        <form action="SaveUserInfo.jsp" method="post">
         	<label for="userID">아이디:</label>
            <input type="text" id="userID" name="userID" required><br><br>

            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" required><br><br>

            <label for="tel">전화번호:</label>
            <input type="tel" id="tel" name="tel" required><br><br>

            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>

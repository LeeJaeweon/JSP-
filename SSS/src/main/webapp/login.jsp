<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/custom.css">
    <title>게시판 웹 사이트</title>
    <style>
        /* 추가한 스타일 */
        body, html {
            height: 100%;
            margin: 0;
            overflow: hidden; /* 추가 */
        }
        .container {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* 수정: 맨 위 정렬 */
            align-items: center;
            max-width: 400px; /* 최대 너비 설정 */
            margin: 0 auto; /* 가운데 정렬을 위해 추가 */
        }
        .jumbotron {
            width: 100%;
            padding: 20px; /* 내부 패딩 조정 */
        }
        .form-group {
            margin-bottom: 15px; /* 폼 요소 간격 조정 */
        }
        .btn-primary {
            margin-top: 15px; /* 로그인 버튼 상단 간격 조정 */
        }
        .find_wrap {
            text-align: center; /* 아이디 찾기, 회원가입 링크 중앙 정렬 */
            margin-top: 10px; /* 링크 상단 간격 조정 */
        }
         /* 추가한 스타일 */
        .find_wrap a {
            display: inline-block; /* 변경: inline-block으로 설정 */
            margin: 5px; /* 간격 추가 */
            text-decoration: none; /* 링크의 밑줄 제거 */
        }
        .find_separator {
            margin: 0 5px; /* 좌우 간격 조정 */
            color: #ccc; /* 색상 설정 */
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="main.jsp" style="margin-left: 10px;">게시판 웹 사이트</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="main.jsp">🛖메인</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="bbs.jsp">📒게시판</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false">
                    접속하기
                </a>
                <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                    <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
                    <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="jumbotron" style="padding-top: 20px;">
        <form method="post" action="loginAction.jsp">
            <h3 style="text-align: center;">로그인 화면</h3>
            <div class="form-group">
                <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
            </div>
            <div class="form-group">
                <input type="password" class="form-control" placeholder="패스워드" name="userPassword" maxlength="20">
            </div>
            <input type="submit" class="btn btn-primary form-control" value="로그인">
            <div class="login-form">
                <ul class="find_wrap" id="find_wrap">
                    <a href="javascript:void(0);" onclick="openPopup('FindID.jsp', '아이디 찾기', 600, 800);">아이디 찾기</a>
                    <span class="find_separator">|</span> <!-- 구분선 -->
                    <a target="_blank" href="join.jsp" class="find_text">회원가입</a>
                </ul>
            </div>
        </form>
    </div>
</div>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
<script>
    function openPopup(url, title, width, height) {
        var left = (screen.width - width) / 2;
        var top = (screen.height - height) / 2;
        var features = 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top + ',resizable=yes';
        window.open(url, title, features);
    }
</script>
</body>
</html>

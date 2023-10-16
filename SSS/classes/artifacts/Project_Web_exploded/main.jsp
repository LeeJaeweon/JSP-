<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNavDropdown">
			<ul class="navbar-nav">
				<li class="nav-item active">
					<a class="nav-link" href="main.jsp">메인</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="bbs.jsp">게시판</a>
				</li>
				<%
					if(userID == null) {
				%>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false">
						접속하기
					</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						<li><a class="dropdown-item" href="login.jsp">로그인</a></li>
						<li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
					</ul>
				</li>
				<%
				} else {
				%>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-expanded="false">
						회원관리
					</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						<li><a class="dropdown-item" href="profileUpdate.jsp">프로필 수정</a></li>
						<li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
				<%
					}
				%>
			</ul>
		</div>
	</nav>
	<!-- 메인 페이지 영역 시작  -->
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>	My Web	</h1>
				<p> ㅎ2  </p>
				<a class="btn btn-primary btn-pull"  href="#	" role="button"> 자세히 알아보기 </a>
			</div>
		</div>
	</div>
	<!--  메인페이지 사진 삽입 영역  -->
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="weap">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="1" class="active"></li>
	<!--  	<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>		-->
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/camping.gif" height="600" width="1200">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<!--  메인 페이지 영역 끝  -->
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
	<%--<script src="js/bootstrap.js"></script>--%>
</body>
</html>
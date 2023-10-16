<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--부트스트랩은 어떤device로 접속하더라도 해상도에 맞게 알아서 설정되는 탬플릿이다. -->
<meta name="viewport" content="width=device-width" , initial-scale="1">
<!--스타일시트를 참조, 주소는 css안에 부트스트랩.css-->
<link rel="stylesheet" href="css/bootstrap.css">
<title>프로필 사진 등록</title>
</head>
<body>
<!-- 네비게이션 구현 네비게이션이라는 것은 하나의 웹사이트의 전반적인 구성을 보여주는 역할 -->
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
	<!-- 하나의 컨테이너처럼 감싸주는 역할 -->
	<div class="container"> 
		<div class="col-lg-4"></div>
		<!-- 회원가입 폼은 위의 양식은 일치하며, 이제 내부 폼만 바꿔준다. -->
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<!-- 양식 삽입 post는 회원가입이나 로그인같이 어떠한 정보값을 숨기면서 보내는 메소드/ 로그인 Action페이지로 정보를보내겠다-->
				<form method="post" action="joinAction.jsp">
					<!-- 회원 가입에 맞게 위에 액션은 joinAction페이지로 밑에 제목은 회원가입 화면으로 변경 -->
					<h3 style="text-align: center;">프로필 사진 등록</h3>
					<div class="form-group">
						<!-- 회원 가입에서도 userID or userPassword는 동일하게 가져가고, 회원가입에 필요한 나머지 속성추가 -->
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<!-- userName 추가 -->
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
					<!-- 성별 선택 추가 -->
					<div class="form-group" style="text-align: center;">
						<!-- 버튼 공간을 따로 마련해준다.(남,녀) -->
						<div class="btn-group" data-toggle="buttons">
							<!-- 선택이 된곳에 표시를 하는 active를 설정해준다. -->
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자 
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자 
							</label>
							</div>
							<!-- 성별 선택부분 완료 -->
							</div>
							<!-- email 작성부분 구현 -->
							<div class="form-group">
						<!-- placeholder는 아무런 입력이 없을때 띄워주는 값 -->
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
						</div>
					</form>	
				</div>
			</div>	
			<div class="col-lg-4"></div>
		</div>
	<!-- 애니메이션을 담당하게 될 자바스크립트 참조 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 특정홈페이지에서 제이쿼리 호출 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
<%--<script src="js/bootstrap.js"></script>--%>
</body>
</html>
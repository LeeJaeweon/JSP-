<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
<title> Camping </title>

	<!--  핑테스트 팝업 창 띄우기 시작  -->
	<script>
    function openPopupPingTest() {
        var popup = window.open("pingTest2.jsp", "_blank", "width=600,height=400");
        popup.focus();
    }
</script>

<script>
    function openPopupFindUser() {
        var popup = window.open("finduser.jsp", "_blank", "width=600,height=800");
        popup.focus();
    }
</script>

	

<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration:none;
	}
</style>
</head>
<body>
    <% 
    String userID = null;
    if (session.getAttribute("userID") != null){
        userID = (String) session.getAttribute("userID");
    }
    int pageNumber = 1;
    if (request.getParameter("pageNumber") != null){
    	pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
    }
    %>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="main.jsp" style="margin-left: 10px;">게시판 목록</a>
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
                        ⚙️회원관리
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                    	<a href="#" class="dropdown-item" onclick="openPopupFindUser(); return false;">🏕️유저찾기</a>
						<a href="#" class="dropdown-item" onclick="openPopupPingTest(); return false;">📡인터넷 테스트</a>
                        <li><a class="dropdown-item" href="logoutAction.jsp">🤚로그아웃</a></li>
                    </ul>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </nav>
    <div class="row mt-4">
    <div class="col-md-6 offset-md-3">
        <h2 class="text-center">게시글 검색</h2>
        <form action="search.jsp" method="get">
            <div class="input-group">
                <input type="text" name="query" placeholder="  검색어를 입력하세요" class="form-control">
                <div class="input-group-append">
                    <button type="submit" class="btn btn-primary">검색🔍</button>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="row mt-4"></div>


<div class="container">
    <div class="row">
        <table class="table table-bordered table-striped" style="text-align: center;">
            <thead>
                <tr>
                    <th style="background-color: #eeeeee; text-align: center;">번호</th>
                    <th style="background-color: #eeeeee; text-align: center;">제목</th>
                    <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                    <th style="background-color: #eeeeee; text-align: center;">작성일</th>
                </tr>
            </thead>
            <tbody>
                <%
                    BbsDAO bbsDAO = new BbsDAO();
                    ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                    for (int i = 0; i < list.size(); i++) {
                %>
                <tr>
                    <td><%= list.get(i).getBbsID() %></td>
                    <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%= list.get(i).getBbsTitle() %></a></td>
                    <td><%= list.get(i).getUserID() %></td>
                    <td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
                </tr>
                <%
                    }
                %>
                
            </tbody>
        </table>
<div class="container">
    <div class="row">
        <table class="table table-bordered table-striped" style="text-align: center;">
            <!-- 테이블 내용 생략 -->
        </table>
        <div class="col-md-12 mt-4"> <!-- 버튼 컨테이너 역할을 하는 col-md-12와 상단 여백을 위한 mt-4 클래스 추가 -->
            <div class="d-flex justify-content-center"> <!-- 가운데 정렬을 위한 d-flex와 justify-content-center 클래스 추가 -->
                <% if (pageNumber != 1) { %>
                <a href="bbs.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success btn-arrow-left">⬅️ 이전 페이지</a>
                <% } %>
                <% if (bbsDAO.nextPage(pageNumber + 1)) { %>
                <a href="bbs.jsp?pageNumber=<%=pageNumber +1%>" class="btn btn-success btn-arrow-right">다음 페이지 ➡️</a>
                <% } %>
            </div>
            <div class="float-right mt-2"> <!-- 오른쪽 정렬을 위한 text-right 클래스와 상단 여백을 위한 mt-2 클래스 추가 -->
                <a href="write.jsp" class="btn btn-primary">글쓰기</a>
            </div>
        </div>
    </div>
</div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
    <%--<script src="js/bootstrap.js"></script>--%>
</body>
</html>
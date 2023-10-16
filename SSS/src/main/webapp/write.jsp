<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!--  파일 업로드 추가 page import -->
<%@ page import="file.FileDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
<title> 게시판 웹 사이트</title>
</head>
<body>
    <% 
    String userID = null;
    if (session.getAttribute("userID") != null){
        userID = (String) session.getAttribute("userID");
    }
    %>
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
                        <li><a class="dropdown-item" href="profileUpdate.jsp">✒️프로필 수정</a></li>
                        <li><a class="dropdown-item" href="logoutAction.jsp">🤚로그아웃</a></li>
                    </ul>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </nav>
    <div class= "container">
    	<div= "row">
    		<form name="form" method="post" action="writeAction.jsp" enctype="multipart/form-data">
    	 	   <table class= "table table-striped" style= "text-align: center; border: 1px solid #dddddd">
    	    		<thead>
    	    			<tr>
    	    				<th colspan="2" sytle="background-color: #eeeeee; text-align: center;">게시판 글쓰기</th>
    	    			</tr>
    	    		</thead>
    	    		<tbody>
    	    			<tr>
    	    				<td><input type="text" class="form-control" placeholder=" 제목" name="bbsTitle" maxlength="60"></td>
    	    			</tr>
    	    			<tr>
    	    				<td><textarea class="form-control" placeholder=" 내용" name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
    	    			</tr>
    	    			<tr>
					<td colspan="5" ><input type="file" name="fileName"></td>
				</tr>
    	    		</tbody>
    		    </table>
    	   		<input type="submit" href= "fileSelect.jsp" class= "btn btn-primary pull-right" value="게시글 작성">
    		</form>
    	</div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
    <%--<script src="js/bootstrap.js"></script>--%>
</body>
</html>
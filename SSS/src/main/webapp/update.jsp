<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
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
    if (userID == null){
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인하세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }
    int bbsID = 0;
    if (request.getParameter("bbsID") != null)
    {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0)
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    Bbs bbs = new BbsDAO().getBbs(bbsID);
    if (!userID.equals(bbs.getUserID())){
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('권한이 없습니다.')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
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
    	<div class= "row">
    		<form name="form" method="post" action="updateAction.jsp" encType="multipart/form-data&keyvalue=multipart">
    			<table class= "table table-stripped" style= "text-align: center; boarder: 1px solid #dddddd">
	    	    	<thead>
		    	    	<tr>
		    	    		<th colspan= "2" style= "background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
		    	    	</tr>
	    	    	</thead>
			    	<tbody>
			    		<tr>
			    			<td><input type="text" class="form-control" placeholder="글 제목"  name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle()%>"></td>
			    		</tr>
			    		<tr>
			    			<td><textarea class="form-control" placeholder="글 내용"  name="bbsContent" maxlength="2048" style= "height:350px"><%= bbs.getBbsContent()%></textarea></td>
			    		</tr>
			    		<tr>
					<td colspan="5" ><input type="file" name="fileName"></td>
				</tr>
			    	</tbody>
    	    	</table>
    	    	<input type="submit" class="btn btn-primary pull-right" value="글수정">
    		</form>
    	    </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
    <%--<script src="js/bootstrap.js"></script>--%>
</body>
</html>
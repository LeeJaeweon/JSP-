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
<title>JSP 게시판 웹 사이트</title>
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
    <div class= "container">
    	<div= "row">
    	    <table class= "table table-stripped" style= "text-align: center; boarder: 1px solid #dddddd">
    	    	<thead>
    	    	<tr>
    	    		<th style= "background-color: #eeeeee; text-align: center;">번호</th>
    	    		<th style= "background-color: #eeeeee; text-align: center;">제목</th>
    	    		<th style= "background-color: #eeeeee; text-align: center;">작성자</th>
    	    		<th style= "background-color: #eeeeee; text-align: center;">작성일</th>
    	    	</tr>
    	    	</thead>
    	    	<tbody>
    	    		<tr>
    	    			<%
    	    				BbsDAO bbsDAO = new BbsDAO();
    	    				ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
    	    				for (int i =0; i<list.size(); i++){
    	    			%>
    	    			<tr>
    	    				<td><%= list.get(i).getBbsID() %></td>
    	    				<td><a href ="view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
    	    				<td><%= list.get(i).getUserID() %></td>
    	    				<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
    	    			</tr>	
    	    			<%
    	    				}
    	    			%>
    	    		</tr>
    	    	</tbody>
    	    </table>
    	    <%
    	    	if(pageNumber != 1){
    	    %>		
    	    		<a href= "bbs.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success btn-arraw-left">이전</a>
    	    <% 
    	    	}if(bbsDAO.nextPage(pageNumber + 1)){
    	    %>		
    	    	<a href= "bbs.jsp?pageNumber=<%=pageNumber +1%>" class="btn btn-success btn-arraw-left">다음</a>
    	    <% 
    	    	}
    	    %>
    	    
    	    <a href= "write.jsp" class= "btn btn-primary pull-right">글쓰기</a>
    	</div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
    <%--<script src="js/bootstrap.js"></script>--%>
</body>
</html>
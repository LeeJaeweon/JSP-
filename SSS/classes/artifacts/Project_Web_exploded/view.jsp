<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >  <!-- 반응형 웹에 사용하는 메타태그 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조  -->
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
	// 메인 페이지로 이동했을 때 세션에 값이 담기는지 체크
    String userID = null; // 로그인이 된 사람들은 로그인정보를 담을 수 있도록한다
    if (session.getAttribute("userID") != null)
    {
        userID = (String)session.getAttribute("userID");
    }
    // bbsID를 초기화 시키고
    // 'bbsID' 라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다.
    int bbsID = 0;
    if (request.getParameter("bbsID") != null)
    {
        bbsID = Integer.parseInt(request.getParameter("bbsID"));
    }
    if (bbsID == 0)		// 만약 넘어온 데이터가 없다면
    {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    Bbs bbs = new BbsDAO().getBbs(bbsID);
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
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
                <thead>
                    <tr>
                        <th colspan="3" style="background-color:#eeeeee; text-align:center;">게시판 글 보기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width:20%;">글 제목</td>
                        <td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>                  
                    </tr>
                    <tr>
                        <td>작성자</td>
                        <td colspan="2"><%= bbs.getUserID().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
                    </tr>
                    <tr>
                        <td>작성일자</td>
                        <td colspan="2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11, 13) + "시" 
                                + bbs.getBbsDate().substring(14,16) + "분"  %></td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td colspan="2" style="min-height:200px; text-align:left;">
                        <!-- 특수문자를 제대로 출력하기위해 & 악성스크립트를 방지하기위해 -->
                        <%= bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>    
                    </tr>
                </tbody>
            </table>
            <a href="bbs.jsp" class="btn btn-primary">목록</a>
            <%
                if(userID != null && userID.equals(bbs.getUserID()))
                {
            %>
                <a href="update.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">수정</a>
                <a href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">삭제</a>
                
            <%     
                }
            %>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha1/js/bootstrap.min.js"></script>
<%--<script src="js/bootstrap.js"></script>--%>
</body>
</html>
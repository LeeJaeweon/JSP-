<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>


<%@ page import="file.FileDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%@ page import="bbs.Bbs" %>


<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
	// 다음 라인들은 로직을 처리하기 위한 필요한 변수들을 설정합니다.
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}

	String realFolder=""; // 파일 저장 경로를 설정하기 위한 변수를 선언합니다.
	String saveFolder = "bbsUpload"; // 파일을 저장할 폴더 이름을 설정합니다.
	String encType = "utf-8"; // 문자 인코딩 타입을 설정합니다.
	String map="";
	int maxSize=5*1024*1024; // 파일 크기의 최대값을 설정합니다.

	// 서블릿 컨텍스트를 가져오고 파일 저장 경로를 설정합니다.
	ServletContext context = this.getServletContext();
	realFolder = context.getRealPath(saveFolder);

	// MultipartRequest 객체를 생성합니다. 이 객체는 파일 업로드를 처리합니다.
	MultipartRequest multi = null;
	multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());

	// 폼에서 제출된 데이터를 가져옵니다.
	String realFileName = multi.getFilesystemName("fileName"); // 파일 이름을 가져옵니다.
	String bbsTitle = multi.getParameter("bbsTitle"); // 게시물 제목을 가져옵니다.
	String bbsContent = multi.getParameter("bbsContent"); // 게시물 내용을 가져옵니다.
	bbs.setBbsTitle(bbsTitle); // 'bbs' 객체의 제목을 설정합니다.
	bbs.setBbsContent(bbsContent); // 'bbs' 객체의 내용을 설정합니다.

	// 로그인 여부를 확인하고, 게시물 작성 여부를 확인하고, 게시물을 데이터베이스에 작성합니다.
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')"); // 사용자가 로그인하지 않았으면 알림을 출력합니다.
		script.println("location.href = 'login.jsp'"); // 로그인 페이지로 리다이렉트합니다.
		script.println("</script>");
	} else {
		if (bbs.getBbsTitle().equals("") || bbs.getBbsContent().equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			BbsDAO BbsDAO = new BbsDAO();
			int bbsID = BbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			if (bbsID == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				PrintWriter script = response.getWriter();
				if(realFileName != null){
					File oldFile = new File(realFolder+"\\"+realFileName);
					String fileName = (bbsID - 1) + "사진.jpg";
					File newFile = new File(realFolder + "\\" + fileName);
					oldFile.renameTo(newFile);
					BbsDAO.saveFile(fileName, realFileName,bbsID);
				}
				script.println("<script>");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
		}
	}
%>
</body>
</html>
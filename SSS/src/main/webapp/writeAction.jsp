<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 웹 사이트</title>
</head>
<body>
<%
    String userID = null;
    if(session.getAttribute("userID") != null){
        userID = (String) session.getAttribute("userID");
    }
    int boardID = 0;
    if (request.getParameter("boardID") != null){
        boardID = Integer.parseInt(request.getParameter("boardID"));
    }
    
    String realFolder="";
    String saveFolder = "bbsUpload";
    String encType = "utf-8";
    int maxSize=5*1024*1024;
    
    ServletContext context = this.getServletContext();
    realFolder = context.getRealPath("/") + saveFolder;

    MultipartRequest multi = null;
    
    multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());        
    String originalFileName = multi.getFilesystemName("fileName");
    String bbsTitle = multi.getParameter("bbsTitle");
    String bbsContent = multi.getParameter("bbsContent");
    bbs.setBbsTitle(bbsTitle);
    bbs.setBbsContent(bbsContent);

    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 해주세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    } else if (bbs.getBbsTitle().equals("") || bbs.getBbsContent().equals("")) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력이 안된 사항이 있습니다.')");
        script.println("history.back()");
        script.println("</script>");
    } else {
        BbsDAO bbsDAO = new BbsDAO();
        int bbsID = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
        if (bbsID == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('글쓰기에 실패했습니다.')");
            script.println("history.back()");
            script.println("</script>");
        } else {
            if(originalFileName != null){
                String newFileName = bbsID + "_" + originalFileName;
                File oldFile = new File(realFolder + "\\" + originalFileName);
                File newFile = new File(realFolder + "\\" + newFileName);
                oldFile.renameTo(newFile);
            }
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href= \'bbs.jsp?boardID=" + boardID + "\'");
            script.println("</script>");
        }
    }
%>
</body>
</html>

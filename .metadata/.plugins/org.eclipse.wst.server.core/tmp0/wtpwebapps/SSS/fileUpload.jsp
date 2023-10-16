<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 파일이름 중복을 피할 수 있도록 -->

<%
	String realFolder = "";

	String saveFolder = ""; // out폴더에 fileSave 폴더 생성
	String encType = "utf-8";
	int maxSize = 5*1024*1024; // 최대 업로드 5mb

	ServletContext context = request.getServletContext();
	realFolder = context.getRealPath(saveFolder);
	out.println("the realpath is: " + realFolder + "<br>");

	try {
	    MultipartRequest multi = null;

	    multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

	    Enumeration params = multi.getParameterNames();

	    while(params.hasMoreElements()) {
	        String name = (String) params.nextElement();
	        String value = multi.getParameter(name);
	        out.println(name + " = " + value + "<br>");
	    }

	    out.println("-------------------<br>");

	    Enumeration files = multi.getFileNames();

	    while(files.hasMoreElements()) {
	        String name = (String)files.nextElement();
	        String filename = multi.getFilesystemName(name);
	        String original = multi.getOriginalFileName(name);
	        String type = multi.getContentType(name);
	        File file = multi.getFile(name);


	        out.println(" paramname " +": " + name + "<br>");
	        out.println(" filename " +" : "+ original + "<br>");
	        out.println(" Savename " +" : "+ filename + "<br>");
	        out.println(" filetype " +" : " + type + "<br>");

		    if(file!= null) {
		        out.println("크기 : " + file.length() + "byte" + "<br>");
		    }
	    }

	}catch (IOException ioe) {
		System.out.println(ioe);
	} catch (Exception ex) {
		System.out.println(ex);
	}
%>
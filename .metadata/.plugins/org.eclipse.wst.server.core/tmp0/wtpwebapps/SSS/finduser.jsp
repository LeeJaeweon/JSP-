<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %> <!-- ResultSet import 추가 -->
<%@ page import="java.util.ArrayList" %> <!-- ArrayList import 추가 -->
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        #header {
            background-color: #4285f4;
            color: white;
            text-align: center;
            padding: 1em;
        }
        #content {
            max-width: 600px;
            margin: 2em auto;
            padding: 1em;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }
        h2 {
            color: #4285f4;
        }
        form {
            display: flex;
            align-items: center; /* 세로 중앙 정렬 */
        }
        input[type="text"] {
            flex: 1;
            padding: 0.5em;
            border: none;
            border-radius: 3px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-right: 1em;
        }
        input[type="submit"] {
            background-color: #4285f4;
            color: white;
            border: none;
            padding: 0.5em 1em;
            border-radius: 3px;
            cursor: pointer;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            padding: 0.5em 0;
            border-bottom: 1px solid #ddd;
        }
        p {
            color: #666;
        }
        
        #content {
            max-width: 600px;
            margin: 2em auto;
            padding: 1em;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            text-align: center; /* 가운데 정렬 추가 */
        }
    </style>
</head>
<body>
    <div id="header">
        <h1>유저 찾기</h1>
    </div>
    <div id="content">
        <h2>유저 찾기</h2>
        <form action="" method="post">
            <input type="text" name="searchQuery" placeholder="아이디 검색">
            <input type="submit" value="검색">
        </form>
        <hr>
        <h3>검색 결과</h3>
        <% 
            String searchQuery = request.getParameter("searchQuery");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) { // Check if searchQuery is not empty
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                
                try {
                    String dbURL = "jdbc:mysql://localhost:3306/bbs"; // 적절한 DB URL로 변경
                    String dbID = "root"; // 적절한 DB 사용자명으로 변경
                    String dbPassword = "Jaeweon7018!@"; // 적절한 DB 비밀번호로 변경
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
                    
                    ArrayList<String> userList = new ArrayList<String>();
                    String SQL = "SELECT * FROM bbs.user WHERE userID LIKE '%" + searchQuery + "%'"; // 적절한 테이블명과 컬럼명으로 변경해야 합니다.
                   				 
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(SQL);
                    while (rs.next()) {
                        userList.add(rs.getString("userID"));
                    }
                    
                    if (userList.size() > 0) {
                        out.println("<ul>");
                        for (String userID : userList) {
                            out.println("<li>" + userID + "</li>");
                        }
                        out.println("</ul>");
                        
                        out.println("<p>총 : " + userList.size() + "명</p>"); // 총 인원 수 출력
                    } else {
                        out.println("<p>검색 결과가 없습니다.</p>");
                    }
                } catch (Exception e) {
                	out.println(e.toString());
                    //e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
                }
            } else {
                out.println("<p>아이디를 입력해주세요.</p>");
            }
        %>
    </div>
</body>
</html>

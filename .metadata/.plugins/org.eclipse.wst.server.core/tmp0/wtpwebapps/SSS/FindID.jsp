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
            text-align: center; /* 가운데 정렬 추가 */
        }
        h2 {
            color: #4285f4;
        }
        form {
            margin-top: 1em;
            display: flex;
        }
        input[type="text"] {
            flex: 1;
            padding: 0.5em;
            border: 1px solid #ccc;
            border-radius: 3px;
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
        
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 0 auto; /* 가운데 정렬 추가 */
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center; /* 가운데 정렬 추가 */
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
    <title>아이디 찾기</title>
</head>
<body>
    <div id="header">
        <h1>아이디 찾기</h1>
    </div>
    <div id="content">
        <h2>이름으로 찾기</h2>
        <form action="" method="post">
            <input type="text" name="searchName" placeholder="가입시 사용한 이름 입력">
            <input type="submit" value="검색">
        </form>
        <hr>
        <h3>검색 결과</h3>
        
        <% 
            String searchName = request.getParameter("searchName");
            if (searchName != null) {
                searchName = new String(searchName.getBytes("ISO-8859-1"), "UTF-8");
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
                    String SQL = "SELECT * FROM bbs.user WHERE userName LIKE '" + searchName + "'"; // 적절한 테이블명과 컬럼명으로 변경해야 합니다.
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(SQL);
                    
                    if (rs.next()) {
                        out.println("<table>");
                        out.println("<tr><th>아이디</th><th>이메일</th></tr>");
                        
                        do {
                            String userID = rs.getString("userID");
                            String userEmail = rs.getString("userEmail");
                            out.println("<tr><td>" + userID + "</td><td>" + userEmail + "</td></tr>");
                        } while (rs.next());
                        
                        out.println("</table>");
                    } else {
                        out.println("<p>검색 결과가 없습니다.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
                }
            }
        %>
    </div>
</body>
</html>

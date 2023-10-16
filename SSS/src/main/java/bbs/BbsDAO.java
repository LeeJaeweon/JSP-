package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.sql.Statement; // Statement import 추가

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs";
			String dbID = "root";
			String dbPassword = "Jaeweon7018!@";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 현재 시간을 가져오는 함수, 게시판의 글을 작성할 때 현재 서버의 시간을 넣어주는 역할
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	// 게시글 번호는 하나씩 늘어나므로 마지막에 쓰인 글을 가져와서 +1을 하면 다음 번호가 된다 

	public int getNewNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 실제로 글을 작성하는 함수
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO bbs (bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable) VALUES(?, ?, ?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			int next = getNewNext();
			pstmt.setInt(1, next);
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			pstmt.executeUpdate();
			return next;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	public int saveFile(String fileName, String fileRealName,int bbsID) {
		String SQL = "INSERT INTO bbs_file (fileName, fileRealName, bbsID) VALUES(?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNewNext()-(pageNumber -1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	// 해당 페이지로 넘어갈 수 있는지 검사 
	public boolean nextPage(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNewNext()-(pageNumber -1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false; 
	}
	
	//하나의 게시글을 보는 메소드
	public Bbs getBbs(int bbsID)
    {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; 
        try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, bbsID);
				rs = pstmt.executeQuery();
				if (rs.next())
				{
	                Bbs bbs = new Bbs();
	                bbs.setBbsID(rs.getInt(1));
	                bbs.setBbsTitle(rs.getString(2));
	                bbs.setUserID(rs.getString(3));
	                bbs.setBbsDate(rs.getString(4));
	                bbs.setBbsContent(rs.getString(5));
	                bbs.setBbsAvailable(rs.getInt(6));
	                return bbs;
		        }
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return null; 
    }
	// 게시글 수정 메소드
	public int update(int bbsID, String bbsTitle, String bbsContent) {	
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}
	// 게시글 삭제
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류 
	}
	
	
	
	
	// BbsDAO.java

	public ArrayList<Bbs> searchList(String query, int pageNumber) {
	    String SQL = "SELECT * FROM bbs WHERE bbsTitle LIKE ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT ?, 10";
	    ArrayList<Bbs> list = new ArrayList<Bbs>();
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, "%" + query + "%");
	        pstmt.setInt(2, (pageNumber - 1) * 10);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Bbs bbs = new Bbs();
	            bbs.setBbsID(rs.getInt(1));
	            bbs.setBbsTitle(rs.getString(2));
	            bbs.setUserID(rs.getString(3));
	            bbs.setBbsDate(rs.getString(4));
	            bbs.setBbsContent(rs.getString(5));
	            bbs.setBbsAvailable(rs.getInt(6));
	            list.add(bbs);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}




	
	
	
	
}
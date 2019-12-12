package board2417;

import java.sql.*;
import java.util.Vector;

public class BoardDbBean {
	Connection conn;
	PreparedStatement pstmt;
	String sql;
	ResultSet rs;

	public BoardDbBean() {
	}

//	connection 가져오기
	public Connection getConn() {
		try {
//			getConnection() 이 static 메소드이기 때문에 사용 가능
			conn = DBConnection.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("드라이버 로딩 및 connection 오류");
		}
		return conn;
	}

//	게시물 작성
	public int insertBoard(BoardBean board) {
		BoardBean bd = board;
		sql = "SELECT MAX(ref) FROM tblboard GROUP BY ref";
		int result = 0;
		int ref = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ref = rs.getInt(1);
				bd.setRef(ref+1);
			}
			sql = "INSERT INTO tblboard VALUES(?, ?, ?, date_format(NOW(), '%Y%m%d%H%i%s'), ?, ?, ?, 0, ?, 0, 0, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 0);
			pstmt.setString(2, bd.getWriter());
			pstmt.setString(3, bd.getPass());
			pstmt.setString(4, bd.getEmail());
			pstmt.setString(5, bd.getSubject());
			pstmt.setString(6, bd.getContent());
			pstmt.setInt(7, bd.getRef());
			pstmt.setString(8, bd.getIp());
			pstmt.executeUpdate();

			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

//	
//	해당 게시물 내용 불러오기
	public BoardBean readBoard(int num) {
		BoardBean board = new BoardBean();
		sql = "select * from tblboard where num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				board.setNum(rs.getInt(1));
				board.setWriter(rs.getString(2));
				board.setPass(rs.getString(3));
				board.setRegdate(rs.getString(4));
				board.setEmail(rs.getString(5));
				board.setSubject(rs.getString(6));
				board.setContent(rs.getString(7));
				board.setReadcnt(rs.getInt(8));
				board.setRef(rs.getInt(9));
				board.setRef_step(rs.getInt(10));
				board.setRe_level(rs.getInt(11));
				board.setIp(rs.getString(12));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return board;
	}

//	전체 게시물 개수 조회
	public int getBoardCount() {
		int total = 0;
		sql = "SELECT COUNT(num) FROM tblboard";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return total;
	}

//	전체 게시물 list 조회
	public Vector<BoardBean> selectBoard() {

		sql = "SELECT num, subject, writer, regDate, readcnt, re_level FROM tblboard ORDER BY ref DESC, ref_step";
		Vector<BoardBean> blist = new Vector<BoardBean>();
		BoardBean poll = null;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				poll = new BoardBean();
				poll.setNum(rs.getInt(1));
				poll.setSubject(rs.getString(2));
				poll.setWriter(rs.getString(3));
				poll.setRegdate(rs.getString(4));
				poll.setReadcnt(rs.getInt(5));
				poll.setRe_level(rs.getInt(6));
				blist.add(poll);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return blist;

	}

//	조회수 올리기
	public int updateReadcnt(int num) {
		BoardBean board = new BoardBean();
		sql = "UPDATE tblboard SET readcnt = readcnt+1 WHERE num=?";
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 게시물 update
	public int updateBoard(BoardBean board) {
		int result = 0;
		sql = "UPDATE tblboard SET content = ?, email = ?, pass = ?, ip = ? WHERE num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getContent());
			pstmt.setString(2, board.getEmail());
			pstmt.setString(3, board.getPass());
			pstmt.setString(4, board.getIp());
			pstmt.setInt(5, board.getNum());
			pstmt.executeUpdate();
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
//	게시글 삭제
	public int deleteBoard(int num) {
		int result = 0;
		sql = "SELECT ref, re_level FROM tblboard WHERE num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int re_level = rs.getInt("re_level");
				int ref = rs.getInt("ref");
				if (re_level == 0) {
					sql = "DELETE FROM tblboard WHERE ref = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, ref);
					pstmt.executeUpdate();
					result = 1;
				} else {
					sql = "DELETE FROM tblboard WHERE num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					result = 1;
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
//	비밀번호 체크
	public int checkPass(int num, String inPass) {
		int result = 0;
		sql = "SELECT pass FROM tblboard WHERE num = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				String dbPass = rs.getString(1);
				if (dbPass.equals(inPass)) {
					System.out.println("비밀번호가 맞음.");
					result = 1;
				} else {
					System.out.println("비밀번호가 틀림");
					result = 2;
				}
			} else {
				result = 3;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
//	답변 작성
	public int replyBoard(BoardBean board) {
		int ref_step = board.getRef_step() + 1;
		int re_level = board.getRe_level() + 1;
		int result = 0;
		sql = "INSERT INTO tblboard(num, writer, pass, regdate, email, subject, content, ref, ref_step, re_level, ip)"
				+ " VALUES(?, ?, ?, date_format(NOW(), '%Y%m%d%H%i%s'), ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 0);
			pstmt.setString(2, board.getWriter());
			pstmt.setString(3, board.getPass());
			pstmt.setString(4, board.getEmail());
			pstmt.setString(5, board.getSubject());
			pstmt.setString(6, board.getContent());
			pstmt.setInt(7, board.getRef());
			pstmt.setInt(8, ref_step);
			pstmt.setInt(9, re_level);
			pstmt.setString(10, board.getIp());
			pstmt.executeUpdate();
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;
	}
	
	public int upReply(int ref, int ref_step) {
		int result = 0;
		sql = "UPDATE tblboard SET ref_step = ref_step+1 WHERE ref=? AND ref_step > ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, ref_step);
			pstmt.executeUpdate();
			
			result = 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}

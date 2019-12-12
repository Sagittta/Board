<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@	page import="board2417.BoardDbBean"%>
<%@	page import="board2417.BoardBean"%>
<%@	page import="java.util.*"%>
<%@	page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eunjung Board</title>
<script>
	function read(num) {
		document.readForm.num.value = num;
		document.readForm.action =  "read.jsp";
		document.readForm.submit();
	}
</script>
</head>
<body bgcolor="FFFFCC">
	<%
		Connection conn = null;
		BoardDbBean dbBoard = new BoardDbBean();
		conn = dbBoard.getConn();

		int count = 0;
		Vector<BoardBean> vlist = dbBoard.selectBoard();
		if (vlist != null) {
			count = dbBoard.getBoardCount();
		}
	%>
	<div align="center">
		<h2>Eunjung Board</h2>

		<table align="center" width="600" cellpadding="3">
			<tr>
				<td align="left">Total : <font color="red"> <%= count %></font>Articles</td>
			</tr>
			<tr>
				<td align="center" colspan="2">
				<%
					if (count == 0) {
						out.println("등록된 게시물이 없습니다.");
					} else {
				%>
					<table width="100%" cellpadding="2" cellspacing="0">
						<tr align="center" bgcolor="#D0D0D0" height="120%">
							<td>번호</td>
							<td>제목</td>
							<td>이름</td>
							<td>날짜</td>
							<td>조회수</td>
						</tr>

				<%
						BoardBean board = new BoardBean();
						int cnt = vlist.size();
						for (int i = 0; i < cnt; i++) {
							board = vlist.get(i);
							int re_level = board.getRe_level();
							out.println("<tr>");
							out.println("<td align='center'>" + (i+1) + "</td>");
							out.println("<td>"); 
							if (re_level > 0) {
								for (int j = 0; j < re_level; j++) {
									out.println("&nbsp;&nbsp;");
								}
							}
				%>
									<a href="javascript:read('<%= board.getNum() %>')">
				<%
							out.println(board.getSubject());
							out.println("</a>");
							out.println("<td align='center'>" + board.getWriter() + "</td>");
							out.println("<td align='center'>" + board.getRegdate() + "</td>");
							out.println("<td align='center'>" + board.getReadcnt() + "</td>");
							out.println("</tr>");
						}
					}
				%>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br> <br></td>
			</tr>
			<tr>
				<td align="right"><a href="writeForm.jsp">[글쓰기]</a></td>
			</tr>
		</table>
		<hr width="'600" />
		<form name="readForm" method="get">
			<input type="hidden" name="num">
		</form>
	</div>
</body>
</html>
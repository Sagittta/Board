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
<title>게시물 읽기</title>
</head>
<body bgcolor="FFFFCC">
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
%>
<script>
	function reply() {
		document.replyForm.action = "replyForm.jsp";
		document.replyForm.submit();
	}
	function update() {
		document.upForm.num.value=<%=num%>;
		document.upForm.delyn.value="n";
		document.upForm.action = "checkPass.jsp";
		document.upForm.submit();
	}
	function del() {
		document.delForm.num.value=<%=num%>;
		document.delForm.delyn.value="y";
		document.delForm.action="checkPass.jsp";
		document.delForm.submit();
	}
</script>
	<%
		BoardDbBean dbBoard = new BoardDbBean();
		Connection conn = null;
		conn = dbBoard.getConn();
		
		int result = dbBoard.updateReadcnt(num);
		System.out.println("updateReadcnt : " + result);
		if (result == 1) {
			BoardBean board = new BoardBean();
			board = dbBoard.readBoard(num);
			session.setAttribute("board", board);
	%>
	<div align="center">
		<table width="600" cellpadding="3">
			<tr>
				<td bgcolor="#84F399" height="25" align="center">게시판 글 읽기</td>
			</tr>
			<tr>
				<td align="center"><%=	num %></td>
			</tr>
		</table>
		<br />
		<table width="600" cellpadding="3" align="center">
			<tr>
				<td width="10%">성명</td>
				<td width="90%">
					<input name="writer" size="10" maxlength="8" readonly value="<%=board.getWriter()%>">
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input name="subject" size="50" maxlength="30" readonly value="<%=board.getSubject()%>">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="content" rows="10" cols="50" readonly> <%=board.getContent()%> </textarea>
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>
					<input type="text" name="email" size="20" maxlength="50" value="<%=board.getEmail()%>" readonly>
				</td>
			</tr>
			<tr>
				<td width="15%">비밀번호</td>
				<td>
					<input type="password" name="pass" size="15" maxlength="15" value="<%=board.getPass()%>" readonly>
				</td>
			</tr>
			<tr>
				<td colspan="2"><hr /></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" name="update" value="수정" onClick="javascript:update()"> 
					<input type="button" name="reply" value="답변쓰기" onClick="javascript:reply()"> 
					<input type="button" name="delete" value="삭제" onClick="javascript:del()"> 
					<input type="button" value="리스트" onClick="javascript:location.href='list.jsp'">
				</td>
			</tr>
		</table>
	</div>
	<%
		} else {
			System.out.println("조회수 업데이트 실패...");
		}
	%>
	<form name="replyForm" method="post">
	</form>
	<form name="upForm" method="post">
		<input type="hidden" name="num">
		<input type="hidden" name="delyn">
	</form>
	<form name="delForm" method="post">
		<input type="hidden" name="num">
		<input type="hidden" name="delyn">
	</form>
</body>
</html>
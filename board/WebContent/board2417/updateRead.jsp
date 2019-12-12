<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	page import="board2417.BoardBean" %>
<%@	page import="board2417.BoardDbBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body bgcolor="FFFFCC">
<%
	response.setCharacterEncoding("UTF-8");

	BoardBean board = new BoardBean();
	board = (BoardBean) session.getAttribute("board");
	BoardDbBean dbboard = new BoardDbBean();

	int num = board.getNum();
	String inPass = request.getParameter("pass");
	
	dbboard.getConn();
	int result = dbboard.checkPass(num, inPass);
	if (result == 1) {
		System.out.println("비밀번호 일치");
		dbboard.selectBoard();
%>
	<div align="center">
		<table width="'600" cellpadding="3">
			<tr>
				<td bgcolor="#9CA2EE" height="25" align="center">게시글 수정</td>
			</tr>
		</table>
		<form name="updateForm" method="post" action="update.jsp">
			<table width="600" cellpadding="3" align="center">
				<tr>
					<td width="10%">성명</td>
					<td width="90%"><%=	board.getWriter() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td>
						<input type="text" name="subject" size="15" value="<%=	board.getSubject()%>" readonly>
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea name="content" rows="10" cols="50"><%=	board.getContent() %></textarea>
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email" size="15" value="<%=	board.getEmail() %>"></td>
				</tr>
				<tr>
					<td width="15%">비밀번호</td>
					<td>
						<input type="password" name="pass" size="15" maxlength="15" value="<%=	board.getPass() %>">
					</td>
				</tr>
				<tr>
					<td colspan="2"><hr/></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="수정완료">
						<input type="reset" value="다시쓰기">
						<input type="button" value="뒤로" onClick="history.back()">
					</td>
				</tr>
			</table>
			<input type="hidden" name="ip" value="<%= request.getRemoteAddr() %>">
		</form>
	</div>
<%
	} else if (result == 2) {
		System.out.println("비밀번호 불일치");
%>
<script>
	alert("비밀번호 일치하지 않음.");
	location.href="list.jsp";
</script>
<%
	} else {
		System.out.println("존재하지 않음.");
%>
<script>
	alert("비밀번호 존재하지 않음.");
	location.href="list.jsp";
</script>
<%
	}
%>
</body>
</html>
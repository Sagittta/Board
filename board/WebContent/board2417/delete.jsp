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
<body>
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
		result = 0;
		
		dbboard.getConn();
		result = dbboard.deleteBoard(num);
		if (result == 1) {
%>
<script>
	alert("게시글 삭제 완료되었습니다.");
	location.href = "list.jsp";
</script>
<%
	} else if (result == 0) {
%>
<script>
	alert("게시글 삭제 실패하였습니다.");
	location.href="history.back()";
</script>
<%	
		}
	}
%>
</body>
</html>
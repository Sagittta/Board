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
	
	String content = request.getParameter("content");
	String email = request.getParameter("email");
	String pass = request.getParameter("pass");
	String ip = request.getParameter("ip");
	
	board.setContent(content);
	board.setEmail(email);
	board.setPass(pass);
	board.setIp(ip);
	
	dbboard.getConn();
	int result = dbboard.updateBoard(board);
	if (result == 1) {
%>
<script>
	alert("게시글 수정되었습니다.");
	location.href = "list.jsp";
</script>
<%
	} else if (result == 0) {
%>
<script>
	alert("게시글 수정되지 않았습니다.");
	location.href="list.jsp";
</script>
<%	
	}
%>
</body>
</html>
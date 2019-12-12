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
<title>글쓰기2</title>
</head>
<body bgcolor="FFFFCC">
<%	
	request.setCharacterEncoding("utf-8");

	String writer = request.getParameter("writer");
	String pass = request.getParameter("pass");
	String email = request.getParameter("email");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String ip = request.getParameter("ip");

	BoardBean board = new BoardBean();

	board.setWriter(writer);
	board.setPass(pass);
	board.setEmail(email);
	board.setSubject(subject);
	board.setContent(content);
	board.setIp(ip);

	Connection conn = null;
	BoardDbBean dbBoard = new BoardDbBean();
	conn = dbBoard.getConn();
	
	int result = dbBoard.insertBoard(board);
	String msg = "게시글 추가에 실패하였습니다.";
	String url = "list.jsp";
	if (result == 1) {
		msg = "게시글 추가되었습니다.";
		url = "list.jsp";
	}
%>
<script>
	alert("<%= msg %>");
	location.href="<%= url %>";
</script>

</body>
</html>
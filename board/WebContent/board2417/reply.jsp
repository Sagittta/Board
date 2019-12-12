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
<title>답변</title>
</head>
<body>
<%	
	request.setCharacterEncoding("utf-8");

	String writer = request.getParameter("writer");
	String pass = request.getParameter("pass");
	String email = request.getParameter("email");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	int ref = Integer.parseInt(request.getParameter("ref"));
	int ref_step = Integer.parseInt(request.getParameter("ref_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	String ip = request.getParameter("ip");

	BoardBean board = new BoardBean();

	board.setWriter(writer);
	board.setPass(pass);
	board.setEmail(email);
	board.setSubject(subject);
	board.setContent(content);
	board.setRef(ref);
	board.setRef_step(ref_step);
	board.setRe_level(re_level);
	board.setIp(ip);

	Connection conn = null;
	BoardDbBean dbBoard = new BoardDbBean();
	conn = dbBoard.getConn();

	String msg = "게시글 추가 실패";
	String url = "list.jsp";
	int result = 0;
	
	result = dbBoard.upReply(ref, ref_step);
	if (result == 1) {
		result = dbBoard.replyBoard(board);
		if (result == 1) {
			msg = "게시글 추가 성공";
		}
	}
%>
<script>
	alert("<%=	msg	%>");
	location.href="<%= url %>";
</script>
</body>
</html>
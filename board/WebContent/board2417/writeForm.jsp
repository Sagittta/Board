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
<title>게시물 만들기</title>
</head>
<body bgcolor="FFFFCC">
	<div align="center">
		<table width="600" cellpadding="3">
			<tr>
				<td bgcolor="#84F399" height="25" align="center">글쓰기</td>
			</tr>
		</table>
		<br />
		<form name="postForm" method="post" action="write.jsp">
			<table width="600" cellpadding="3" align="center">
				<tr>
					<td align="center">
						<table align="center">
							<tr>
								<td width="10%">성명</td>
								<td width="90%">
									<input name="writer" size="10" maxlength="8">
								</td>
							</tr>
							<tr>
								<td>제목</td>
								<td>
									<input name="subject" size="50" maxlength="30">
								</td>
							</tr>
							<tr>
								<td>내용</td>
								<td>
									<textarea name="content" rows="10" cols="50"> </textarea>
								</td>
							</tr>
							<tr>
								<td>이메일</td>
								<td>
									<input type="text" name="email" size="20" maxlength="50">
								</td>
							</tr>
							<tr>
								<td width="15%">비밀번호</td>
								<td>
									<input type="password" name="pass" size="15" maxlength="15">
								</td>
							</tr>
							<tr>
								<td colspan="2"><hr /></td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="submit" value="등록"> 
									<input type="reset" value="다시쓰기"> 
									<input type="button" value="리스트" onClick="javascript:location.href='list.jsp'"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="ip" value="<%= request.getRemoteAddr() %>">
		</form>
	</div>
</body>
</html>
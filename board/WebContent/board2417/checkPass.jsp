<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
</head>
<body bgcolor="FFFFCC">
	<script type="text/javascript">
		function f(action) {
			var p = document.checkPass.pass.value;
			if (p.length == 0) {
				alert("비밀번호를 입력하세요.");
				return false;
			} else {				
				document.checkPass.action = action;
				document.checkPass.submit();
			}
		}
	</script>
	<div align = "center">
		<%
			String delyn = request.getParameter("delyn");
			String name = "";
			String action = "";
			if (delyn.equals("y")) {
				name = "삭제 완료";
				action = "delete.jsp";
			} else {
				name = "수정";
				action = "updateRead.jsp";
			}
			int num = Integer.parseInt(request.getParameter("num"));
		%>
		
		<form name="checkPass" method="post">
			<table width="600" cellpadding="3">
				<tr>
					<td bgcolor="#D0D0D0" height="25" align="center"> 사용자의 비밀번호를 확인해주세요 </td>
				</tr>
			</table>
			<br>
			<table width="600" cellpadding="3" align="centeer">
				<tr>
					<td align="center">
						<input type="password" name="pass" size="15" maxlength="15">
					</td>
				</tr>
				<tr>
					<td align="center">
						<input type="button" value="<%= name %>" onClick="javascript:f('<%= action %>')">
						<input type="button" value="뒤로가기" onClick="history.back()">
					</td>
				</tr>
				<input type="hidden" name="num" value="<%=	num %>">
			</table>
		</form>
	</div>
</body>
</html>
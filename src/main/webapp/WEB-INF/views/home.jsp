<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

		<hr width="50%" color="blue">
		<h3>로그인 하시오</h3>
		<hr width="50%" color="blue">

		<form action="bandlist.do" method="post">
			<table>
				<tr>
					<th>아이디</th>
					<td><input name="userid"></td>
				</tr>
				<tr>
					<th>비번</th>
					<td><input type="password" name="userpwd"></td>
				</tr>
			</table>
			<div>
				<input type="submit" value="로그인"> <input type="reset" value="취소">
			</div>
		</form>
	<form action="exnav.do" method="post">
		<input type="submit" value="nav">
	</form>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="css/styles.css">
  <link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<title>Insert title here</title>	

<style type="text/css">

html { 
  background: url(resources/images/white.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
* {
  box-sizing: border-box;
  font-family: 'Noto Sans KR', sans-serif;
  
}
body {
  margin: 0;
  
  background-image: url("images/photo.jpg");
}

.login-form {
  position: absolute;
  background-color: #EEEFF1;
  border-radius: 5px;
  margin-left: auto;
  margin-right: auto;
  width: 300px;
  padding: 20px;
  top: 50%;
  left: 50%;
  opacity: 0.8;
  transform: translate(-50%, -50%);
}

.text-field {
   border: none;
  width: 138%;
  border-radius: 5px;
  font-size: 14px;
  padding: 10px;
  margin-bottom: 10px;
  margin-left: -45%;
  margin-right: 0%; 
  
  
}
#username{
   border: none;
  width: 138%;
  border-radius: 5px;
  font-size: 14px;
  padding: 10px;
  margin-bottom: 10px;
  margin-left: -45%;
  margin-right: 0%; 
}
#phone{

   border: none;
  width: 138%;
  border-radius: 5px;
  font-size: 14px;
  padding: 10px;
  margin-bottom: 10px;
  margin-left: -45%;
  margin-right: 0%; 
}

.submit-btn {
  border: none;
  width: 90%;
  background-color: #1BBC9B;
  border-radius: 5px;
  font-size: 14px;
  padding: 10px;
  margin-bottom: 30px;
  color: white;
} 
.bottom{
font size:13px;
color:white;
margin-left:30%;
position: absolute; bottom: 5px;

}

.links {
  text-align: center;
}

.links a {
  font-size: 12px;
  color: #9B9B9B;
}
h1{
color:white;
margin-left: 40px;

}
table{

margin-top: 10px;
margin-bottom: -30px;

}

</style>

</head>

<h1>bond</h1>
 <form class="bottom" align="center">
 <script language = "javascript">
    swal("비밀번호는 '"+"${pwd }"+"' 입니다");
</script>
 
	공지사항 | 이용약관 | 개인정보 처리방침 | 운영정책
	Copyright TheZone Corp. All right reserved
	</form> 


<form id="main2" name ="main2" class="login-form" action="findpwd.do" method="post" onsubmit="return check()">
	<table align="center">
		<tr>
    		<td style="width: 200px;"></td>
    		<td style="width: 390px"><input type="text" id="userid" name="userid" align="center" class="text-field style="width: 50% height : 10%;" 
    		placeholder="아이디 입력하세요"/></td>
		</tr>
		<tr>
    		<td style="width: 200px;"></td>
    		<td style="width: 390px"><input type="text" id="username" name="username" align="center" class="text-field style="width: 50% height : 10%;" 
    		placeholder="이름을 입력하세요"/></td>
		</tr>
		
		<tr>
		    <td></td>
    		<td><input type="text" name="phone" id="phone" class="text-field style="width: 50% height : 10%;" placeholder="핸드폰번호 입력"/></td>
		</tr>
		
		
	 
	</table>


	<br><br>
	<div style="text-align: center;padding-bottom: 15px;">
    	<input type="submit" value="비밀번호찾기"  id="login" class="submit-btn" />
    	  <input type="button" value="메인페이지" class="submit-btn	" onclick="location.href='main2.jsp'"/>
     
        <div class="links">
   
        <br> <br>
	</div>
</form>
</body>
</html>
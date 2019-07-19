
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
<title>Insert title here</title>
<script>
function check() {
	
	  if(main2.userid.value == "") {
		  swal("아이디를 입력해 주세요.");	
	    main2.userid.focus();
	    return false;
	  }else if(main2.pwd.value == "") {
		  swal("비밀번호를 입력해 주세요.");
		  main2.pwd.focus();
		  return false;  
}
	  else 
		  return true;
};
</script>	
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
<body >

<h1>BAND</h1>
 <form class="bottom" align="center">
	
	공지사항 | 이용약관 | 개인정보 처리방침 | 운영정책
	Copyright TheZone Corp. All right reserved
	</form> 

<form id="main2" name ="main2" class="login-form" action="login.do" method="post" onsubmit="return check()">
	<table align="center" >
		<tr>
    		<td style="width: 200px;"></td>
    		<td style="width: 390px"><input type="text" id="userid" name="userid" align="center" class="text-field"  placeholder="아이디입력하세요"/></td>
		</tr>
		<tr>
		    <td></td>
    		<td><input type="password" name="pwd" id="pwd" class="text-field style="width: 50% height : 10%;" placeholder="비밀번호를 입력하세요"/></td>
		</tr>
		
	</table>


	<br><br>
	<div style="text-align: center;padding-bottom: 15px;">
    	<input type="submit" value="로그인"  id="login" class="submit-btn"/>
        <input type="button" value="회원가입" class="submit-btn"onclick="location.href='signUp.do'"/>
        <div class="links">
      <a href="searchid.do">아이디 혹은 비밀번호를 잊어버리셨나요?</a>
        <br> <br>
        <%
    String clientId = "b_P87p7e5nMmJxe1aK7s";//애플리케이션 클라이언트 아이디값";
    
    String redirectURI = URLEncoder.encode("http://localhost:8282/controller/callback.do", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
  <a href="<%=apiURL%>" ><img align="middle" height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
        
	</div>
</form>

<%-- <div align="center">	

 <img src='<c:url value="resources/images/naverlogin.jpg"/>' id="naver" width="200">
</div> --%>

</body>
</html>
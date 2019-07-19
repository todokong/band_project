<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="css/styles.css">
  <link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
html { 
  background: url(resources/images/white.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
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
h1{
margin-top: 5%;
}
input{
  border: none;
  width: 26%;
  background-color: #1BBC9B;
  border-radius: 5px;
  font-size: 14px;
  padding: 10px;
  margin-bottom: 30px;
  color: white;
}
.hh1{
color:white;
margin-left: 32px;
margin-top: 22px;	
font-size: 33px;


}
h2 {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

	margin-top: 10%;
}
</style>
</head>
<body>
<h1 class="hh1">bond</h1>
<form align="center"  class="login-form">

<h2>회원가입이 완료되었습니다.</h2>
       
        <input type="button" value="로그인페이지로 이동하기" class="sub.submit-btn" onclick="location.href='main2.jsp'"/>
</form>
</body>
</html>
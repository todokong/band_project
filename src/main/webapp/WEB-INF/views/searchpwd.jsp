
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>   
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.js" />'></script>
<meta charset="UTF-8">
 <link rel="stylesheet" href="css/styles.css">
  <link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Insert title here</title>
<script>

function check() {
    if(main2.userid.value == "") {
    swal("아이디을 입력해 주세요.");	
    main2.userid.focus();
    return false;
    }else if(main2.username.value == "") {
    swal("이름을 입력해 주세요.");	
    main2.username.focus();
    return false;
  }else if(main2.phone.value == "") {
	  swal("핸드폰번호를 입력해 주세요.");
	  main2.phone.focus();
	  return false;  
  
}
  else 
	  return true;
  
};
$(function(){

    $(".phone-number-check1").on('keydown', function(e){
       // 숫자만 입력받기
        var trans_num = $(this).val().replace(/-/gi,'');
	var k = e.keyCode;
				
	if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687 || k==32 || k==229 || (k>=45032 && k<=55203)) ))
	{
  	    e.preventDefault();
	}
    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
        if($(this).val() == '') return;

        // 기존 번호에서 - 를 삭제합니다.
        var trans_num = $(this).val().replace(/-/gi,'');
      
        // 입력값이 있을때만 실행합니다.
        if(trans_num != null && trans_num != '')
        {
            // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
            if(trans_num.length==11 || trans_num.length==10) 
            {   
                // 유효성 체크
                var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
                if(regExp_ctn.test(trans_num))
                	
                {
                    // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿔줍니다.
                  //  trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})''?([0-9]{4})$/, "$1-$2-$3");
                    trans_num = trans_num.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
                    $(this).val(trans_num);
                }
                else
                {
                	swal("유효하지 않은 전화번호입니다.");
                    $(this).val("");
                    $(this).focus();
                }
            }
            else 
            {
            	swal("유효하지 않은 전화번호입니다.");
                $(this).val("");
                $(this).focus();
            }
      }
		

  }); 
  
});




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
</style>
</head>
<body >
<h1>bond</h1>
 <form class="bottom" align="center">


	
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
    		<td><input type="text" name="phone" id="phone" class="phone-number-check1" placeholder="핸드폰번호 입력"/></td>
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
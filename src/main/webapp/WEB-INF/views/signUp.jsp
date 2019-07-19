
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="https://fonts.googleapis.com/earlyaccess/notosanskr.css" rel="stylesheet">
     <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
   
  

<meta name="Keywords" content="회원가입" />
<meta name="Description" content="회원가입" />
<title>회원가입</title>
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

.signUpForm {
  position: absolute;
  background-color: #EEEFF1;
  border-radius: 5px;
  margin-left: auto;
  margin-right: auto;
  width: 700px;
  padding: 20px;
  top: 50%;
  left: 50%;
  opacity: 0.8;
  transform: translate(-50%, -50%);
}

.text-field {
  border: none;
  width: 90%;
  border-radius: 5px;
  font-size: 14px;
  padding: 10px;
  margin-bottom: 10px;
  margin-left: -15%;
  margin-right: 60%;
  
}

.submit-btn {
  border: none;
  width: 20%;
  background-color: #1BBC9B;
  border-radius: 5px;
  font-size: 14px;
  padding: 10px;
  margin-bottom: 30px;
  color: white;
  
} 

.submit-btn1 {
  border: none;
  width: 20%;
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
margin-left: 30px;
}
span{
font-size:12px;
position:absolute; right: 10%;
}
alert{
position: absolute; left: 10%;
font-size:40px;
}

</style>
<script>



$(function(){
   $(".submit-btn").prop("disabled", true);


   $("#idcheck_btn").click(function(){
      $("#idcheck").hide(); //span 태드를 숨기라는 의미
      var userId=   $("#userid").val();
      
      
      // 입력 길이 체크 (4자 이상 16자 미만)

       if($.trim($("#userid").val()).length < 6) {
         var warningTxt = 
            '<font color="red">아이디는 6자 이상이어야 합니다.</font>';
         
            $(".submit-btn").prop("disabled", true);

         $("#idcheck").text('');    // idcheck 영역 초기화
         $("#idcheck").show();      // idcheck 영역 보여짐.
         // idcheck 영역에 경고창이 추가되어서 보여짐.
         $("#idcheck").append(warningTxt);
         $("#userid").focus();
         return false;
       };
   /*     if(confirm("회원가입을 하시겠습니까?")){
             if(userid==0){
                 alert('아이디 중복체크를 해주세요');
                 return false;
             }else{
             alert("회원가입을 축하합니다");
             }  */
      
      //아이디중복여부 확인 -Ajax
      $.ajax({
         type :"post" ,                   //데이터 전송 방식
         url : "checkUserId.do", //파일 주소와 경로
         data : {"userid" : userId},             //id 변수에 userId값을 저장하여 넘긴다
         dataType : "json",
         //통신이 성공한 경우 결과값을 data라는 변수에 저장
         
         success : function(data){
            if(data == 1){ // 아이디가 존재하는 경우 --중복된 경우
               var warningTxt='<font color="red">중복된 아이디 입니다.</font>';
               $(".submit-btn").prop("disabled", true);

            
               $("#idcheck").text('');      //idcheck 영역 초기화
               $("#idcheck").show();       //idcheck 영역 보여줌
               //idcheck 영역에 경고창이 추가 되어서 보여짐
               $("#idcheck").append(warningTxt);
               $("#userid").focus();
               
               return true;
            }else{    //아이디가 존재하지 않는 경우  - 중복X
               var warningTxt='<font color="green">사용가능한 아이디 입니다.</font>';
               $("#idcheck").text('');      //idcheck 영역 초기화
               $("#idcheck").show();       //idcheck 영역 보여줌
               //idcheck 영역에 경고창이 추가 되어서 보여짐
               $("#idcheck").append(warningTxt);
               $("#username").val('').focus();
               $(".submit-btn").prop("disabled", false);
               return false;
            
            }
         },
         //통신이 실제한 경우
         error : function(){
            alert("통신 실패");
         }
      
      });//ajax의 end
      return false;
   
   });

    $('#pwd').keyup(function(){
       var pwd = $('#pwd').val();
       if(pwd.trim() !=''){
       if (pwd.length<6 || pwd.length>12){
          $('#check').html("6~12자리미만으로 가능합니다.");
            $(".submit-btn").prop("disabled", true);

       }else{
          $('#check').html("");
            $(".submit-btn").prop("disabled", false);


       }
       }
      
    });
    
   
    $("#pwd2").keyup(function(){

       var pwd = $('#pwd').val();

       var pwd2 = $('#pwd2').val();
      
       if(pwd.trim() !=''){

          if(pwd.trim() == pwd2.trim()){

             $('#checkPwd').html("비밀번호가 일치합니다.");
          }else{

             $('#checkPwd').html("비밀번호가 일치하지 않습니다.");
             
          }
       }else{
          $('#checkPwd').html("비밀번호를 입력해주세요");
       }
       if(pwd2.trim()==''){

          $('#checkPwd').html("");
       }
       
   }) 
   
}); 
$(function(){

    $(".phone-number-check").on('keydown', function(e){
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
                    trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");                  
                    $(this).val(trans_num);
                }
                else
                {
                   swal("유효하지 않은 전화번호 입니다.");
                    $(this).val("");
                    $(this).focus();
                }
            }
            else 
            {
               swal("유효하지 않은 전화번호 입니다.");
                $(this).val("");
                $(this).focus();
            }
      }
      

  }); 
  
});


function check() {
   
      
     if(signUpForm.userid.value == "") {
        swal("아이디를 입력해 주세요.");   
       signUpForm.userid.focus();
       return false;
     }else if(signUpForm.username.value == "") {
        swal("이름을 입력해 주세요.");
        signUpForm.username.focus();
        return false;  
     }else if(signUpForm.pwd.value == "") {
        swal("비밀번호를 입력해 주세요.");
        signUpForm.pwd.focus();
        return false;  
     }else if(signUpForm.pwd.value == "") {
        swal("비밀번호를 입력해 주세요.");
        signUpForm.pwd.focus();
        return false;
     }else if(signUpForm.pwd2.value == "") {
        swal("비밀번호를 한번 더 입력해 주세요.");
        signUpForm.pwd2.focus();
        return false;
     }else if(signUpForm.phone.value == "") {
        swal("핸드폰번호를 입력해 주세요.");
        signUpForm.phone.focus();
        return false;
     }else if(signUpForm.pwd.value != signUpForm.pwd2.value){
        swal("비밀번호를 확인해주세요");
        signUpForm.pwd2.focus();
        return false;
     }else if(signUpForm.pwd.value == signUpForm.pwd2.value){
        return true;

     
     
     }
     else 
        return true;
     
};


 
/* $(document).ready(function(){
   var f = document.getElementById("sighUpForm");
      
   f.onsubmit = function(){
      var userId = document.getElementById("userId");
      var pwd = document.getElementById("pwd");
      var pwd2 = document.getElementById("pwd2");
      
      if(userId.value.length>0){
         if((pwd.value.length ==0) && (pwd2.value.length==0)){
            var checkPwd = document.getElementbyId("checkPwd")
            checkPwd.innerHTML = "비밀번호를 입력해주세요"
            checkPwd.style.color = 'red';
            return false;
         }
         else{
            if(pwd.value == pwd2.value){
               return true;
            }
            else{
               var checkPwd = document.getElementById("checkPwd")
               checkPwd.innerHTML = "비번틀림"
               checkPwd.style.color = 'red';
               return false;
            }
         }
      }else{
         var idcheck = document.getElementById("idcheck");
         idcheck.innerHTML = "아이디를 입력해주세요"
            checkPwd.style.color = 'red';
      }
      return false;
   }
}; 
 */


</script>
<body>
<br><br><br><br><br><br><br><br> 

<h1 align="center">회원가입</h1>
<form align="center " id="signUpForm" name="signUpForm" class="signUpForm" action="signUpOk.do" method="post" onsubmit="return check()" >
<table align="center">
<tr>
    <td style="width: 50px;" > 아이디 :</td>
    <td style="width: 30px"><input type="text" id="userid" name="userid" style="width: 40%;" placeholder="6자리 이상 가능합니다"/></td>
    <td>
    <input type="button" value="아이디중복체크" id="idcheck_btn">
               <span name="idcheck" id="idcheck" ></span>
               
   
   </td>
   
    
</tr>
<tr>
    <td style="width: 200px;" >이름  : </td>
    <td style="width: 390px"><input type="text" name="username" style="width: 40%;" /></td>
</tr>
<tr>
    <td >비밀번호 : </td>
    <td><input type="password" name="pwd" id="pwd" style="width: 40%;" placeholder="6자리 이상 가능합니다" /></td>
    <td> <span id="check"></span>   </td>
</tr>
<tr>
    <td>비밀번호 확인 :</td>
    <td><input type="password" name="pwd2" id="pwd2" style="width: 40%;" onsubmit="pwdcheck" /></td>
     <td> <span id="checkPwd"></span>   </td>
</tr>
<tr>
    <td>핸드폰 번호 : </td>
    <td><input type="text" name="phone" style="width: 40%;" class="phone-number-check" placeholder="'-'없이 입력해주십시오"/></td>
</tr>
</table><p><p><p>
<div style="text-align: center;padding-bottom: 15px;">
    <input type="submit" value="가입하기" class="submit-btn"  disabled="disabled"/>
    <input type="button" value="회원가입취소" class="submit-btn1" onclick="location.href='main2.jsp'"/>
</div>
</form>
</body>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Page</title>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/vendor/bootstrap/css/bootstrap.min.css" />'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/shop-homepage.css" />'>
<script type="text/javascript" src='<c:url value="/resources/vendor/jquery/jquery.min.js" />'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js" />'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/style.css" />'>
<link rel="stylesheet" href="http://taitems.github.com/UX-Lab/core/css/prettify.css" />
<script type="text/javascript" src='<c:url value="/resources/js/jquery.fn.gantt.js" />'></script>
<script src="http://taitems.github.com/UX-Lab/core/js/prettify.js"></script>
<script src="https://kit.fontawesome.com/24e2aa92d8.js"></script>
<script type="text/javascript">
var userid = "${userid}";
function drawMember(data){
	var uUser;
	data.forEach(function(m){
		if (m.userid == userid){
			uUser = m;
		};
	});
	$("#phone1Area").val(uUser.phone.substr( 0, 3 ));
	$("#phone2Area").val(uUser.phone.substr( 3, (uUser.phone.length-1)));
	$("#userName").text(uUser.username);
}
function getMember() {
	$.ajax({
		url: "member_list.do",
		type: 'get',
		dataType: "json",
		success: function(data){
			drawMember(data);
		},
		error : function (jqXHR, textStatus, errorThrown) {
			console.log('error \n[' + textStatus + ']\n' + errorThrown);
		},
		complete	: function() {
			// console.log("complete");
		}
	});
}
$(function(){
	getMember();
});
</script>
<style type="text/css">
.marginLeft20px {    
	margin-left: 20px;
}
.input-group-text {
	background-color: #ffffff; 
	border: 0px;
} 
.list-group-item.active {
    background-color: #343a40;
    border-color: #343a40;
}
a:hover {
    color: #343a40;
}
a {
    color: #343a40;
}
</style>
</head>
<body data-spy="scroll" data-target=".navbar">
<nav id="navbar-example2"
		class="navbar navbar-light bg-light sticky-top">
		<div class="container pagewidth">
			<a class="navbar-brand"
				href="<%=request.getContextPath() %>/bandlist.do?userid=${userid }">BAND</a>
			<form class="form-inline">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
			<ul class="nav nav-pills" role="tablist">
				
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
					role="button" aria-haspopup="true" aria-expanded="false"><i
						class="fas fa-user-alt"></i></a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="mypage_info_${userid }.do">내정보</a> <a class="dropdown-item"
							href="#">설정</a>
						<div role="separator" class="dropdown-divider"></div>
						<a class="dropdown-item" href="logout.do">로그아웃</a>
					</div></li>
			</ul>
		</div>
	</nav>
<div class="container">
	<div class="row my-4">
		<div class="col-lg-3">
			<div class="list-group">
				<a href="mypage_info_${userid}.do" class="list-group-item active">내 정보</a>
				<a href="mypage_board_${userid}.do" class="list-group-item">내가 쓴 글</a>
				<a href="mypage_bookmark_${userid}.do" class="list-group-item">북마크</a>
				<a href="mypage_invite.do?userid=${userid }" class="list-group-item">가입신청 중인 밴드
				<c:if test="${invite != 0 }">
									<i class="fas fa-exclamation" style="color: red;"></i>
								</c:if></a>
				<a href="#" class="list-group-item">보호자 관계 설정</a>
			</div>
		</div>
		<div class="col-lg-9">
			<div class="card"> 
				<div class="card-body">
					<h3 class="card-title">내 정보</h3>
				</div>
			</div>
			<div class="card card-outline-secondary"> 
				<div class="row my-4">
					<div class="col-lg-3">
						<h6 class="marginLeft20px">사용 중인 프로필</h6>
					</div>
					<div class="col-lg-9">
						<img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="" style="width: 100px;">
					</div>
				</div>
				<div class="row my-4">
					<div class="col-lg-3">
						<h6 class="marginLeft20px">개인 정보</h6>
					</div>
					<div class="col-lg-9">
						<div class="row my-4">
							<div class="col-lg-2">
								<label class = "input-group-text">이름</label>
							</div>
							<div class="col-lg-8 input-group">
								<span class="input-group-text" id = "userName"></span>
							</div>
							<div class="col-lg-2">
							</div>
						</div>
						<div class="row my-4">
							<div class="col-lg-2">
								<label class = "input-group-text">생일</label>
							</div>
							<div class="col-lg-8 input-group">
								<select class="form-control">
									<option class="form-control">년</option>
								</select>
								<select class="form-control">
									<option class="form-control">월</option>
								</select>
								<select class="form-control">
									<option class="form-control">일</option>
								</select>
								<div class="input-group-prepend">
									<div class="input-group-text">
										<input type="checkbox"> 
									</div>
								</div>
								<span class="input-group-text" >음력</span>
							</div>
							<div class="col-lg-2">
								<button class="btn" style = "background-color: #e9ecef;">확인</button>
							</div>
						</div>
					</div>
				</div>
				<div class="row my-4">
					<div class="col-lg-3">
						<h6 class="marginLeft20px">로그인 계정</h6>
					</div>
					<div class="col-lg-9">
						<div class="row my-4">
							<div class="col-lg-2">
								<label class = "input-group-text">휴대폰 번호</label>
							</div>
							<div class="col-lg-8 input-group">
								<select class="form-control"  style="width: 50px;" id = "phone1Area">
									<option class="form-control">선택</option>
									<option class="form-control" value = "010">010</option>
								</select>
								<input type="text" class="form-control" id = "phone2Area">
								<button class="btn" style = "background-color: #e9ecef;">확인</button>
							</div>
							<div class="col-lg-2">
								<button class="btn" style = "background-color: #ffffff;">취소</button>
							</div>
						</div>
						<div class="row my-4">
							<div class="col-lg-2">
								<label class = "input-group-text">이메일</label>
							</div>
							<div class="col-lg-8 input-group">
								<input type="text" class="form-control" placeholder="이메일 주소 입력" >
							</div>
							<div class="col-lg-2">
								<button class="btn" style = "background-color: #e9ecef;">확인</button>
							</div>
						</div>
						<div class="row my-4">
							<div class="col-lg-2">
								<label class = "input-group-text">비밀번호</label>
							</div>
							<div class="col-lg-8 input-group">
							</div>
							<div class="col-lg-2">
								<button class="btn" style = "background-color: #ffffff;">변경</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
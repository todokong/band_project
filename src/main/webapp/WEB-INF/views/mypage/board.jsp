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
<style type="text/css">
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
				<a href="mypage_info_${userid}.do" class="list-group-item">내 정보</a>
				<a href="mypage_board_${userid}.do" class="list-group-item active">내가 쓴 글</a>
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
					<h3 class="card-title">내가 쓴 글</h3>
				</div>
			</div>
			<div class="card card-outline-secondary my-4">
				<div class="btn-group">
					<button type="button" class="btn border-btn bb1" style = "background-color: rgb(194, 196, 194);">게시글</button>
					<button type="button" class="btn border-btn bb2">댓글</button>
				</div>
				<div class="row" id = "ba">
					<div class="col-lg-12">
						<div class="table-responsive">
							<table class="table table-bordered" width="100%" cellspacing="0">
								<thead>
									<tr>
										<th>작성자 ID</th>
										<th>작성자 이름</th>
										<th>내용</th>
									</tr>
								</thead>
								<tbody id = "boardArea">
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="row" id = "ra" style="display:none;">
					<div class="col-lg-12">
						<div class="table-responsive">
							<table class="table table-bordered" width="100%" cellspacing="0">
								<thead>
									<tr>
										<th>작성자 ID</th>
										<th>작성자 이름</th>
										<th>내용</th>
										<th>날짜</th>
									</tr>
								</thead>
								<tbody id = "replyArea">
								</tbody>
							</table> 
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var userid = "${userid}";
$(".border-btn").click(function (){
	$(".border-btn").css("background-color", "#ffffff");
	$(this).css("background-color", "#c2c4c2");
});
$(".bb1").click(function (){
	$("#ba").show();
	$("#ra").hide();
});
$(".bb2").click(function (){
	$("#ra").show();
	$("#ba").hide();
});
function drawBoard(data) {
	var h = '';
	if (data.length == 0) {
		h += '<tr>';
		h += '<td colspan="4" style = "text-align: center;"> 등록된 게시글이 없습니다. </td>';
		h += '</tr>';
	} else {
		data.forEach(function(b){
			h += '<tr>';
			h += '<td>' + b.userid + '</td>';
			h += '<td>' + b.username + '</td>';
			h += '<td>' + b.boardcontent + '</td>';
			h += '</tr>'; 
		});
	};
	$("#boardArea").empty().append(h);
}
function drawReply(data) {
	var h = '';
	if (data.length == 0) {
		h += '<tr>';
		h += '<td colspan="4" style = "text-align: center;"> 등록된 댓글이 없습니다. </td>';
		h += '</tr>';
	} else {
		data.forEach(function(r){
			h += '<tr>';
			h += '<td>' + r.userid + '</td>';
			h += '<td>' + r.username + '</td>';
			h += '<td>' + r.replycontent + '</td>';
			h += '<td>' + r.replydate + '</td>';
			h += '</tr>'; 
			console.log(r.replycontent);
		});
	};
	$("#replyArea").empty().append(h);
}
function getReply() {
	$.ajax({
		url: "reply_list.do?userid="+userid,
		type: 'get',
		dataType: "json",
		success: function(data){
			drawReply(data);
		},
		error : function (jqXHR, textStatus, errorThrown) {
			console.log('error \n[' + textStatus + ']\n' + errorThrown);
		},
		complete	: function() {
			// console.log("complete");
		}
	});
}
function getBoard() {
	$.ajax({
		url: "board_list.do?userid="+userid,
		type: 'get',
		dataType: "json",
		success: function(data){
			drawBoard(data);
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
	getReply();
	getBoard();
});
</script>
</body>
</html>
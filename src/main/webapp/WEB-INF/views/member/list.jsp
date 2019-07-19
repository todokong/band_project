<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Page</title>
<link rel="stylesheet" href="../../resources/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="../../resources/css/shop-homepage.css">
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/vendor/bootstrap/css/bootstrap.min.css" />'>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/shop-homepage.css" />'>
<script src="../../resources/vendor/jquery/jquery.min.js"></script>
<script src="../../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/jquery/jquery.min.js" />'></script>
<script type="text/javascript" src='<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js" />'></script>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/style.css" />'>
<link rel="stylesheet" href="../../resources/css/style.css" />
<link rel="stylesheet" href="http://taitems.github.com/UX-Lab/core/css/prettify.css" />
<script src="../../resources/js/jquery.fn.gantt.js"></script>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.fn.gantt.js" />'></script>
<script src="http://taitems.github.com/UX-Lab/core/js/prettify.js"></script>
<style type="text/css">
tr {
    cursor: pointer;
}
tr:hover {
	background-color: #e9ecef;
}
</style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="/member">My Page</a>
	</div> 
</nav> 
<div class="container">
	<div class="row my-4">
		<div class="col-lg-12">
			<div class="card"> 
				<div class="card-body">
					<h3 class="card-title">멤버 리스트</h3>
				</div>
			</div>
			<div class="card card-outline-secondary my-4">
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>ID</th>
									<th>Name</th>
									<th>Phone</th>
								</tr>
							</thead>
							<tbody id = "memberArea">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){

	getMember();
});
function drawMember(data) {
	var h = '';
	data.forEach(function(m){
		h += '<tr class="moveMypage" data = "' + m.userid + '">';
		h += '<td>' + m.userid + '</td>';
		h += '<td>' + m.username + '</td>';
		h += '<td>' + m.phone + '</td>';
		h += '</tr>'; 
	})
	$("#memberArea").empty().append(h);
	$(".moveMypage").click(function (){
		location.href = 'mypage_info_' + $(this).attr("data")+'.do';
	})
}
function getMember() {
	$.ajax({
		url: "list.do",
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
</script>
</body>
</html>
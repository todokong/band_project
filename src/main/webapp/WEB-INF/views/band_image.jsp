<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/resources/css/boardlist.css" />'>
<script type="text/javascript"
	src='<c:url value="/resources/js/jquery.js" />'></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/24e2aa92d8.js"></script>
<script type="text/javascript">
var sel_file;
$(document).ready(function(){
	$("#input_img").on("change", handleImgFileSelect);
});
function handleImgFileSelect(e){
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("확장자만가능");
			return;
		}
		sel_file = f;
		
		var reader = new FileReader();
		reader.onload = function(e){
			$("#img").attr("src", e.target.result);
		}
		reader.readAsDataURL(f);
	});
}
var bandcode = ${bandcode};
function contimage(){
	
	var lastbno = $(".scrolling:last").attr("data-bno");
	
	$.ajax({
    	url : 'bandimage2.do',
    	type : 'get',
    	dataType: "json",
    	data : {'bandcode':bandcode, 'lastbno':lastbno },
    	success : function(retVal){
    		
    		values = retVal.boardlist;
       		var a ='';
       		if(values == ""){
   				alert("더 이상 게시물이 없습니다.");
   			}
       		$.each(values, function(index, value){
       			a += '<div class="col-3 margincard" style="float: none; margin: 0 auto;">';
       			a += '<div class="card">';
       			a += '<input type="hidden" value="'+value.boardcode+'" name="boardcode" data-bno="'+value.boardcode+'" class="scrolling">';
       			a += '<a href="imagecont2.do?bandcode='+value.bandcode+'&boardimage='+value.boardimage+'&boardcode='+value.boardcode+'">';
       			a += '<img src="<c:url value="resources/bandimage/'+value.boardimage+'"/>" class="card-img-top" alt="..." style="height: 150px;"></a>';
       			a += '</div></div>';	
       		});
       		$('#boardimage').append(a);
		
    	}
	});
}
//페이지 이동
function fn_movePage(val){
    jQuery("input[name=pageNo]").val(val);
    jQuery("form[name=frm]").attr("method", "post");
    jQuery("form[name=frm]").attr("action","find.do").submit();
}
//검색 버튼
function fn_search(){
    
    var searchValue = jQuery("#search").val();
    jQuery("#searchValue").val(searchValue);

    jQuery("input[name=pageNo]").val("1");
    jQuery("form[name=frm]").attr("method", "post");
    jQuery("form[name=frm]").attr("action","find.do").submit();
}

function Enter_Check() {
      // 엔터키의 코드는 13입니다.
    if(event.keyCode == 13){
         fn_search();  // 실행할 이벤트
    }
}
</script>
<style type="text/css">

.hovereffect {
width:100%;
height:100%;
float:left;
overflow:hidden;
position:relative;
text-align:center;
cursor:default;
}

.hovereffect .overlay {
width:100%;
height:100%;
position:absolute;
overflow:hidden;
top:0;
left:0;
opacity:0;
background-color:rgba(0,0,0,0.5);
-webkit-transition:all .4s ease-in-out;
transition:all .4s ease-in-out
}

.hovereffect img {
display:block;
position:relative;
-webkit-transition:all .4s linear;
transition:all .4s linear;
}

.hovereffect h2 {
text-transform:uppercase;
color:#fff;
text-align:center;
position:relative;
font-size:17px;
background:rgba(0,0,0,0.6);
-webkit-transform:translatey(-100px);
-ms-transform:translatey(-100px);
transform:translatey(-100px);
-webkit-transition:all .2s ease-in-out;
transition:all .2s ease-in-out;
padding:10px;
}

.hovereffect a.info {
text-decoration:none;
display:inline-block;
text-transform:uppercase;
color:#fff;
border:1px solid #fff;
background-color:transparent;
opacity:0;
filter:alpha(opacity=0);
-webkit-transition:all .2s ease-in-out;
transition:all .2s ease-in-out;
margin:50px 0 0;
padding:7px 14px;
}

.hovereffect a.info:hover {
box-shadow:0 0 5px #fff;
}

.hovereffect:hover img {
-ms-transform:scale(1.2);
-webkit-transform:scale(1.2);
transform:scale(1.2);
}

.hovereffect:hover .overlay {
opacity:1;
filter:alpha(opacity=100);
}

.hovereffect:hover h2,.hovereffect:hover a.info {
opacity:1;
filter:alpha(opacity=100);
-ms-transform:translatey(0);
-webkit-transform:translatey(0);
transform:translatey(0);
}

.hovereffect:hover a.info {
-webkit-transition-delay:.2s;
transition-delay:.2s;
}

</style>
</head>
<body style="background-color: #F6F6F6">
	<c:set value="${banddto }" var="banddto"></c:set>
	<div id="main">
		<nav id="navbar-example2"
			class="navbar navbar-light bg-light sticky-top">
			<div class="container a">
				<a class="navbar-brand"
					href="<%=request.getContextPath() %>/bandlist.do?userid=${dto.getUserid() }">BAND</a>

				<form method="post" action="find.do" id="frm" name="frm" class="form-inline">
					<input type="hidden" name="pageNo" />
            <!-- //페이지 번호 -->
            <input type="hidden" name="searchValue" id="searchValue" value="${Paging.searchValue }" />
            
						<input class="form-control mr-sm-2" type="search" id="search"
							placeholder="Search" aria-label="Search" onkeypress="JavaScript:Enter_Check();">
						<button class="btn btn-outline-success my-2 my-sm-0"  onclick="fn_search();">Search</button>
					</form>

				<ul class="nav nav-pills" role="tablist">
					
					<li class="nav-item"><a class="nav-link" href="#" data-toggle="modal"
					data-target="#exampleModal">사진 올리기</a></li>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
						role="button" aria-haspopup="true" aria-expanded="false"> <i
							class="fas fa-user-alt"></i>
							<c:if test="${invite != 0 }">
									<i class="fas fa-exclamation" style="color: red;"></i>
								</c:if></a>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="mypage_info_${dto.getUserid() }.do">내정보
							<c:if test="${invite != 0 }">
									<i class="fas fa-exclamation" style="color: red;"></i>
								</c:if></a> <a
								class="dropdown-item" href="#">설정</a>
							<div role="separator" class="dropdown-divider"></div>
							<a class="dropdown-item" href="logout.do">로그아웃</a>
						</div></li>
				</ul>
			</div>
		</nav>

		<div id="nav">
			<ul class="nav justify-content-center">
				<li class="nav-item"><a class="nav-link active"
					href="select2.do?bandcode=${bandcode }&userid=${dto.getUserid() }">전체글</a>
				</li>
				<li class="nav-item"><a class="nav-link"
					href="bandimage.do?bandcode=${bandcode }">사진첩</a></li>
				<li class="nav-item"><a class="nav-link" href="bandinvite.do?bandcode=${bandcode }">초대</a></li>
			</ul>
		</div>

		<div class="clear"></div>

		<div id="left">

			<div id="leftcontent">

				<div>
					<img
						src='<c:url value="resources/bandimage/${banddto.getBandimage() }"/>'  style="width: 200px;">
				</div>

				<div>
					<p>${banddto.getBandname() }</p>
					<p>${banddto.getBandinfo() }</p>
				</div>

				<div>
					<c:if test="${result == 1 }">
						<input type="button" value="밴드 탈퇴"
							onclick="location.href='bandout.do?bandcode=${bandcode }'">
					</c:if>
					<c:if test="${result != 1 }">
						<input type="button" value="밴드 가입하기"
							onclick="location.href='joinband.do?bandcode=${bandcode }'">
					</c:if>
				</div>

			</div>
			<%-- id=leftcontent --%>

		</div>
		<%-- id=left --%>

		<div id="center" align="center">

			<c:if test="${result != 1 }">
				<img src='<c:url value="resources/images/her3.png"/>' style="" >
			</c:if>

			<c:if test="${result == 1 }">
				<!-- <a class="nav-link" href="#" data-toggle="modal"
					data-target="#exampleModal">사진 올리기</a> -->

				<!-- 글쓰기 Modal -->
				<div class="modal fade bd-example-modal-lg" id="exampleModal"
					tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
					aria-hidden="true">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">사진 올리기</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form method="post" enctype="multipart/form-data"
									action="insertimage.do">
									<input type="hidden" value="${bandcode }" name="bandcode">

									<div class="form-group">
										<img id="img">
									</div>
									<div class="form-group">
										<label for="exampleInputFile">사진</label> <input type="file"
											id="input_img" name="file">
									</div>
									<button type="submit" class="btn btn-success">올리기</button>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>

				<c:set value="${boardlist }" var="listdto"></c:set>

				<div class="container conwidth">
					<div class="row text-center" id="boardimage">
					
						<c:if test="${empty listdto }">
							<img src='<c:url value="resources/images/her2.png"/>' style="" >
						</c:if>
						<c:forEach items="${listdto }" var="boarddto">
							
								<div class="col-3 margincard" style="float: none; margin: 0 auto;">
									<div class="card">
										<input type="hidden" value="${boarddto.getBoardcode() }" name="boardcode" data-bno="${boarddto.getBoardcode() }" class="scrolling">
										<a href="imagecont2.do?bandcode=${bandcode }&boardimage=${boarddto.getBoardimage() }&boardcode=${boarddto.getBoardcode() }">
											<img
											src='<c:url value="resources/bandimage/${boarddto.getBoardimage() }"/>'
											class="card-img-top" alt="..." style="height: 150px;">
										</a>
										<!-- <div class="card-body"></div> -->
									</div>
								</div>
						</c:forEach>
					</div>
				</div>
				<button onclick="contimage()">더 보기</button>
			</c:if>
			
		</div>
		<%-- id=center --%>

		<div id="right">

			<div id="bandmember">
				<c:set value="${dtolist }" var="listdto"></c:set>
				<span>멤버</span>
				<ul class="list-group" style="width: 350px;">
					<c:forEach items="${listdto }" var="memberdto">
						<li class="list-group-item"><a
							href="memboard.do?bandcode=${bandcode }&userid=${memberdto.getUserid() }">${memberdto.getUsername() }</a></li>
					</c:forEach>
				</ul>
			</div>

		</div>
		<%-- id=right --%>

	</div>
	<%-- id=main end--%>
</body>
</html>
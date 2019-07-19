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
$(window).scroll(function(){
	if($(window).scrollTop() >= $(document).height() - $(window).height()){
		scroll();
	}
});
var bandcode = ${bandcode };
var userid = '${userid }';
function scroll(lastbno){
	var lastbno = $(".scrolling:last").attr("data-bno");
	$.ajax({
    	url : 'memboard2.do',
    	type : 'get',
    	dataType: "json",
    	data : {'bandcode':bandcode, 'lastbno':lastbno, 'userid': userid },
    	success : function(retVal){
    		var userid = retVal.userid;
    		values = retVal.mboardlist;
       		var a ='';
       		if(values == ""){
   				alert("더 이상 게시물이 없습니다.");
   			}
       		$.each(values, function(index, value){
       			
       			a += '<div class="boardlist">';
            	a += '<form method="post">';
            	a += '<input type="hidden" value="'+value.boardimage+'" name="boardimage">';
            	a += '<input type="hidden" value="'+value.boardcode+'" name="boardcode" data-bno="'+value.boardcode+'" class="scrolling">';
            	a += '<table class="board_table table-bordered">';
            	a += '<tr>';
            	a += '<th class="board_username" align="center">'+value.username+'</th>';
            	a += '<td class="board_date">'+value.boarddate+'</td>';
            	a += '<td class="board_button" align="center">';
            	if(userid == value.userid){
            		a += '<input class="btn btn-light" type="button" value="수정" onclick="updateboard2(this.form)" >';
            		a += '<input class="btn btn-light" type="button" value="삭제" onclick="deleteboard(this.form, ${bandcode}, '+value.boardcode+')">';
            	}
            	a += '</td></tr>';
            	a += '<tr>';
            	a += '<td colspan="3" class="board_content">';
            	a += '<textarea class="form-control" rows="3" readonly="readonly" name="boardcontent">'+value.boardcontent+'</textarea>';
            	a += '</td></tr>';
            	a += '<tr>';
            	if(value.boardimage != 'no_file'){
            		a += '<td colspan="3" align="center" class="board_image">';
            		a += '<img class="img-rounded" src="<c:url value="resources/upload/'+value.boardimage+'"/>">';
            		a += '</td>';
            	}
            	a += '</tr></table>';
            	a += '</form>';
            	a += '<div class="replylist"></div>';
            	a += '<div class="replywrite"></div>';
            	a += '</div>';
       			
       		});
       		if(a != ''){
        		$("#center").append(a);
       		}
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
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
								role="button" aria-haspopup="true" aria-expanded="false">
								<i class="fas fa-user-alt"></i>
								<c:if test="${invite != 0 }">
									<i class="fas fa-exclamation" style="color: red;"></i>
								</c:if></a>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="mypage_info_${dto.getUserid() }.do">내정보
								<c:if test="${invite != 0 }">
									<i class="fas fa-exclamation" style="color: red;"></i>
								</c:if></a> 
								<a class="dropdown-item" href="#">설정</a>
								<div role="separator" class="dropdown-divider"></div>
								<a class="dropdown-item" href="logout.do">로그아웃</a>
							</div></li>
					</ul>
				</div>
			</nav>
		<%-- id=header end --%>

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
						src='<c:url value="resources/upload/${banddto.getBandimage() }"/>' style="width: 200px;" >
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
			<br>
			<c:if test="${result != 1 }">
				<img src='<c:url value="resources/images/her3.png"/>' style="" >
			</c:if>

			<c:if test="${result == 1 }">

				<c:set value="${mboardlist }" var="mlist"></c:set>
				
				<c:if test="${empty mlist}">
					<img
						src='<c:url value="resources/images/her2.png"/>' style="" >
				</c:if>
				
				<c:forEach items="${mlist }" var="mdto">
				

						<div class="boardlist">
							<form method="post">
								<input type="hidden" value="${mdto.getBoardimage() }"
									name="boardimage"> <input type="hidden"
									value="${mdto.getBoardcode() }" name="boardcode" data-bno="${mdto.getBoardcode() }" class="scrolling">
								<table class="board_table table-bordered">
									<tr>
										<th class="board_username" align="center">${mdto.getUsername() }</th>
										<td class="board_date">${mdto.getBoarddate() }</td>
										<td class="board_button" align="center"></td>
									</tr>
									<tr>
										<td colspan="3" class="board_content"><textarea
												class="form-control" rows="3" readonly="readonly"
												name="boardcontent">${mdto.getBoardcontent() }</textarea></td>
									</tr>
									<tr>
										<c:if test="${mdto.getBoardimage() != 'no_file' }">
											<td colspan="3" align="center" class="board_image"><img
												class="img-rounded"
												src="<c:url value="resources/upload/${mdto.getBoardimage() }"/>">
											</td>
										</c:if>
									</tr>
								</table>
							</form>
						</div>

				</c:forEach>
			</c:if>

		</div>
		<%-- id=center --%>

		<div id="right">

			<div id="bandmember">
				<c:set value="${dtolist }" var="listdto"></c:set>
				<span>멤버</span>
				<ul class="list-group" style="width: 350px;">
					<c:forEach items="${listdto }" var="memberdto">
						<li class="list-group-item"><a href="memboard.do?bandcode=${bandcode }&userid=${memberdto.getUserid() }">${memberdto.getUsername() }</a></li>
					</c:forEach>
				</ul>
			</div>

		</div>
		<%-- id=right --%>

	</div>
	<%-- id=main end--%>
</body>
</html>
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
<script type="text/javascript"
	src='<c:url value="/resources/js/bandproject.js" />'></script>
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
<script type="text/JavaScript">

	function search(bandcode){
		if($("#invite").val()==""){
			alert("이름을 입력하세요");
			return false;
		}else{
			var invitename = $("#invite").val();
			$.ajax({
				url : 'search2.do',
				type : 'get',
				datatype : 'json',
				data : {'invitename':invitename},
				success : function(retVal){
					values = retVal.mdto;
					var a = '';
					if(values == ""){
						a += '<span>찾으시는 멤버가 없습니다.</span>';
					}else{
						a += '<span>멤버</span>';
						a += '<ul class="list-group" style="width: 350px;">';
						$.each(values, function(index, value){
							a += '<li class="list-group-item">'+value.username+'<input class="btn btn-primary" style="float: right; margin-left:70px; margin-right: 10px;" type="button" value="초대하기" onclick="invite('+value.usercode+',${bandcode })"></li>';	
						});
						a += '</ul>';
					}
					$("#memlist").html(a);
					$("#invite").val(""); 
				}
			});
		}
	}
	function invite(usercode, bandcode){
		var result = confirm("초대하시겠습니까?");
		if(result){
			$.ajax({
				url : 'invite.do',
				type : 'get',
				data : {'usercode': usercode, 'bandcode': bandcode},
				success : function(data){
					if(data == 1){
						alert("초대 되었습니다.");
					}else if(data == 2){
						alert("이미 밴드에 가입한 멤버입니다.");
					}else if(data == 3){
						alert("이미 초대된 멤버 입니다.")
					}
				}
			});
		}else{
			return false;
		}
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

<div id="followquick">
<a class="nav-link btn-primary" href="#headernav"
					data-scroll="popband">top</a>
</div>
	<c:set value="${banddto }" var="banddto"></c:set>
	<div id="main">

		<div id="headernav">

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
			<%--id=nav end --%>

		</div>
		<%--id=headernav end --%>

		<div class="clear"></div>

		<div id="left">

			<div id="leftcontent">

				<div>
					<img src='<c:url value="resources/upload/${banddto.getBandimage() }"/>' style="width: 200px;">
				</div>

				<div>
					<p>${banddto.getBandname() }</p>
					<p>${banddto.getBandinfo() }</p>
				</div>

				<div>
					<c:if test="${result == 1 }">
						<input type="button" value="밴드 탈퇴"
							onclick="bandout(${bandcode })">
					</c:if>
					<c:if test="${result != 1 }">
						<input type="button" value="밴드 가입하기"
							onclick="joinband(${bandcode })">
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
				<br>
				<div>
					<span><strong>멤버 초대</strong> </span>
					<br><br>
					<form class="form-inline" style="margin-left: 400px;">
						<input class="form-control mr-sm-2" type="search" id="invite"
							placeholder="Search" aria-label="Search">
						
						<input class="btn btn-outline-success my-2 my-sm-0" type="button" value="search" onclick="search(${bandcode })">
					</form>
					<br>
				</div>
				
			</c:if>
			
			<div id="memlist"></div>

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
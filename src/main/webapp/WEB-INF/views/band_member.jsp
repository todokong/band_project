<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/boardmember.css" />'>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.js" />'></script>
<script type="text/javascript" src='<c:url value="/resources/js/bandproject.js" />'></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</head>
<body>
	<c:set value="${banddto }" var="banddto"></c:set>
	<div id="main">
		<div id="header">
			<a href="#" id="logo"><img src='<c:url value="resources/images/bandlogo2.png"/>'></a>
			<a href="#" id="profile">${dto.getUsername() }의 프로필 </a>			
			<a href="#" id="search">찾기</a>
		</div><%-- id=header end --%>
		
		<div id="nav">
			<ul class="nav justify-content-center">
  <li class="nav-item">
    <a class="nav-link active" href="select.do?bandcode=${bandcode }&userid=${dto.getUserid() }">전체글</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="bandimage.do?bandcode=${bandcode }">사진첩</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#">Link</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="bandmember.do?bandcode=${bandcode }">멤버</a>
  </li>
</ul>
		</div>
		
		<div class="clear"></div>
		
		<div id="left">
		
			<div id="leftcontent">
			
				<div>
					<img src='<c:url value="resources/upload/${banddto.getBandimage() }"/>'>
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
				
			</div><%-- id=leftcontent --%>
			
		</div><%-- id=left --%>
		
		<div id="center">
		
			<div class="board_member">
			<c:if test="${result != 1 }">
				밴드 회원이 아닙니다. 밴드에 가입해주세요.
			</c:if>

				<span>멤버</span>
				<form action="membersearch.do">
				<div class="input-group mb-3">
					<input type="hidden" value="${bandcode }" name="bandcode">
					<input type="text" class="form-control" placeholder="멤버 검색" name="username"
						aria-label="Recipient's username" aria-describedby="basic-addon2">
					<div class="input-group-append">
						<input class="btn btn-secondary" type="submit" value="검색">
					</div>
				</div>
				</form>
				<c:set value="${memberlist }" var="listdto"></c:set>
				
				<ul class="list-group">
				<c:forEach items="${listdto }" var="memberdto">
					<li class="list-group-item">${memberdto.getUserid() }</li>
					</c:forEach>
				</ul>
  					
			</div>
			
		</div><%-- id=center --%>
		
		<div id="right">
			
		</div><%-- id=right --%>
		
	</div><%-- id=main end--%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/24e2aa92d8.js"></script>

<style type="text/css">
body {
	background-color: #EAEAEA;
	position: relative;
}

.navex:hover {
	background-color: #EAEAEA;
}

.navex {
	text-align: left;
}

.c {
	border-bottom: 3px solid #EAEAEA;
}

.card-body:hover {
	background-color: #D8D8D8;
}
</style>

<script type="text/javascript">
	
		function modal(title,content) {
			
			$('#exampleModalLabel').text(title);
			$('#modalcontent').text(content);
			
			$('#myModal').modal('show'); 
		}

</script>

</head>
<body>

	<c:set var="dto" value="${list }"></c:set>

	<nav id="navbar-example2"
		class="navbar navbar-light bg-light sticky-top">
		<div class="container a">
			<a class="navbar-brand"
				href="<%=request.getContextPath() %>/bandlist.do?userid=${userid }">BAND</a>


			<form class="form-inline">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>

			<ul class="nav nav-pills" role="tablist">
				<li class="nav-item"><a class="nav-link disabled" href="#"
					data-toggle="modal" data-target="#exampleModal"
					aria-disabled="true">밴드 추가 </a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath() %>/bandlist.do?userid=${userid }&target=#pupual">인기글</a>
				</li>

				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath() %>/bandlist.do?userid=${userid }&target=#popband">인기밴드</a>
				</li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
					role="button" aria-haspopup="true" aria-expanded="false"><i
						class="fas fa-user-alt"></i></a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">내정보</a> <a class="dropdown-item"
							href="#">설정</a>
						<div role="separator" class="dropdown-divider"></div>
						<a class="dropdown-item" href="logout.do">로그아웃</a>
					</div></li>
			</ul>



		</div>
	</nav>
	<br>
	<br>
	<br>
	<div class="container">
		<div class="row">
			<div class="col-3">
				<div class="nav flex-column nav-pills" id="v-pills-tab"
					role="tablist" aria-orientation="vertical"
					style="background-color: white;">
					<a class="btn btn-light navex active" id="v-pills-home-tab"
						data-toggle="pill" href="#v-pills-home" role="tab"
						aria-controls="v-pills-home" aria-selected="true">공지사항</a> <a
						class="btn btn-light navex" id="v-pills-profile-tab"
						data-toggle="pill" href="#v-pills-profile" role="tab"
						aria-controls="v-pills-profile" aria-selected="false">도움말</a> <a
						class="btn btn-light navex" id="v-pills-messages-tab"
						data-toggle="pill" href="#v-pills-messages" role="tab"
						aria-controls="v-pills-messages" aria-selected="false">설정</a> <a
						class="btn btn-light navex" id="v-pills-settings-tab"
						data-toggle="pill" href="#v-pills-settings" role="tab"
						aria-controls="v-pills-settings" aria-selected="false">밴드초대확인</a>
				</div>
			</div>
			<div class="col-9">
				<div class="tab-content" id="v-pills-tabContent">
					<div class="tab-pane fade show active" id="v-pills-home"
						role="tabpanel" aria-labelledby="v-pills-home-tab">
						<div class="card">
							<h5 class="card-header">공지사항</h5>
							<c:if test="${!empty dto}">
								<c:forEach items="${dto }" var="i">
									<div class="card-body c"
										onclick="modal('${i.getGongjititle()}','${i.getGongjicontent() }')">
										<div class="row">
											<div class="col-11">
												<p class="card-title">${i.getGongjititle() }</p>
												<p class="card-text">${i.getGongjidate() }</p>
											</div>
											<div class="col-1">
												<i class="fas fa-chevron-down"></i>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:if>
							<c:if test="${empty dto}">
								<div class="card-body c">
									<h5 class="card-title">공지사항 없음</h5>
								</div>

							</c:if>

						</div>

					</div>
					<div class="tab-pane fade" id="v-pills-profile" role="tabpanel"
						aria-labelledby="v-pills-profile-tab"></div>
					<div class="tab-pane fade" id="v-pills-messages" role="tabpanel"
						aria-labelledby="v-pills-messages-tab"></div>
					<div class="tab-pane fade" id="v-pills-settings" role="tabpanel"
						aria-labelledby="v-pills-settings-tab"></div>
				</div>
			</div>
		</div>
	</div>


	<!-- modal -->
	<div class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true"
	id="myModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalcontent">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        
      </div>
    </div>
  </div>
</div>
	<!-- modal end -->

</body>
</html>
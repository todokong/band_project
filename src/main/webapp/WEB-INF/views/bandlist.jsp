<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
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

.pagewidth {
   width: 900px;
}

.right {
   margin-top: 10px;
   margin-right: 10px;
   margin-bottom: 10px;
   width: 150px;
   height: 150px;
   width: 150px;
}

.cardb {
   height: 150px;
}

.cardband {
   width: 150px;
   height: 100px;
}

p {
   font-size: 15px;
}

.card-band {
   text-overflow: ellipsis;
   white-space: nowrap;
   word-wrap: normal;
   width: 200px;
   overflow: hidden;
}

nav {
   background-color: white;
   margin-bottom: 30px;
}

.myband {
   margin-bottom: 100px;
}

</style>
<script type="text/javascript">
   $(function() {
      var link = $('#navbar-example2 a.nav-link');
      link.on('click', function(e) {
         var target = $($(this).attr('href'));
         $('html,body').animate({
            scrollTop : target.offset().top
         }, 600);
         $(this).addClass('active');
         e.preventDefault();
      });
      $(window).on('scroll', function() {
         findPosition();
      });
      function findPosition() {
         $('section').each(
               function() {
                  if ($(this).offset().top - $(window).scrollTop() < 20) {
                     link.removeClass('active');
                     $('#navbar-example2').find(
                           '[data-scroll="' + $(this).attr('id')
                                 + '"]').addClass('active');
                  }
               });
      }
   });
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
<body data-spy="scroll" data-target=".navbar">
   <nav id="navbar-example2"
      class="navbar navbar-light bg-light sticky-top">
      <div class="container pagewidth">
         <a class="navbar-brand"
            href="<%=request.getContextPath() %>/bandlist.do?userid=${userid }">BAND</a>

         <!--  현욱 -->
         <form method="post" action="find.do" id="frm" name="frm" class="form-inline">
            <input type="hidden" name="pageNo" />
            <!-- //페이지 번호 -->
            <input type="hidden" name="searchValue" id="searchValue"
               value="${Paging.searchValue }" />
            <!-- //검색어 -->
            <!--  <a href="search.do" id="logo">이미지</a> -->

            <div class="box" align="center">
               <div class="container-1">

                  <input class="form-control mr-sm-2" type="text" name="search" id="search"
                     placeholder="Search..." onkeypress="JavaScript:Enter_Check();" />
                  <input class="btn btn-outline-success my-2 my-sm-0" type="button" value="SEARCH" onclick="fn_search();" />
               </div>
            </div>

         </form>

         <!--  현욱 end -->
         <ul class="nav nav-pills" role="tablist">
            <li class="nav-item"><a class="nav-link" href="#"
               data-toggle="modal" data-target="#exampleModal">밴드 추가 </a></li>
            <li class="nav-item"><a class="nav-link active" href="#home"
               data-scroll="home">홈</a></li>
            <li class="nav-item"><a class="nav-link" href="#popular"
               data-scroll="popular">인기글</a></li>
            <li class="nav-item"><a class="nav-link" href="#popband"
               data-scroll="popband">인기밴드</a></li>
            <li class="nav-item dropdown"><a
               class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
               role="button" aria-haspopup="true" aria-expanded="false"><i
                  class="fas fa-user-alt"></i><c:if test="${invite != 0 }">
									<i class="fas fa-exclamation" style="color: red;"></i>
								</c:if></a>
               <div class="dropdown-menu">
                  <a class="dropdown-item" href="mypage_info_${userid }.do">내정보
                  <c:if test="${invite != 0 }">
									<i class="fas fa-exclamation" style="color: red;"></i>
								</c:if></a> <a class="dropdown-item"
                     href="#">설정
                     </a>
                  <div role="separator" class="dropdown-divider"></div>
                  <a class="dropdown-item" href="logout.do">로그아웃</a>
               </div></li>
         </ul>
      </div>
   </nav>
   <!-- Modal -->
   <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
      aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">밴드 추가</h5>
               <button type="button" class="close" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
               <form action="bandCreateOk.do" method="post"
                  enctype="multipart/form-data">
                  <input type="hidden" name="userid" value="${userid }">
                  <div class="form-group">
                     <label for="exampleInputName2">밴드이름</label> <input type="text"
                        class="form-control" id="exampleInputName2" name="bandname"
                        placeholder="밴드 이름을 입력하시오">
                  </div>
                  <div class="form-group">
                     <label for="exampleInputName2">밴드 소개</label>
                     <textarea class="form-control" rows="3"
                        placeholder="무엇을 하는 밴드입니까?" name="bandinfo"></textarea>
                  </div>
                  <div class="form-group">
                     <label for="exampleInputFile">밴드이미지</label> <input type="file"
                        id="exampleInputFile" name="upfile">
                     <p class="help-block">밴드의 이미지를 선택할 수 있어요!!</p>
                  </div>
                  <div class="checkbox">
                     <label> <input type="checkbox">비밀밴드
                     </label>
                  </div>
                  <button type="submit" class="btn btn-success">만들기</button>
               </form>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-secondary"
                  data-dismiss="modal">Close</button>
            </div>
         </div>
      </div>
   </div>
   <div class="jumbotron jumbotron-fluid cotainer">
      <div class="container">
         <h6 class="display-4">내가 가입한 밴드</h6>
         
      </div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
   </div>

   <c:set var="list" value="${bandlist }"></c:set>
   <c:set var="pop" value="${pop }"></c:set>
   <c:set var="popboard" value="${popboard }"></c:set>

   <div class="myband" id="home">
      <div class="container pagewidth" data-spy="scroll"
         data-target="#navbar-example2" data-offset="0">
         <div class="row">
            <c:if test="${!empty list }">
               <c:forEach items="${list }" var="i">
                  <div class="col-md-4">
                     <div class="card mb-4 shadow-sm">
                     
                        <c:if test="${'no_file'ne i.getBandimage()}">
                           <img style="height: 180px;"
                           src='<c:url value="resources/bandimage/${i.getBandimage() }"/>'
                           class="img-fluid" >
                        </c:if>
                        <c:if test="${'no_file'eq i.getBandimage()}">
                           <img style="height: 180px;"
                           src='<c:url value="resources/bandimage/no_file.png"/>'
                           class="img-fluid" >
                        </c:if>
                        
                        <div class="card-body">
                           <h6 class="card-title">${i.getBandname() }</h6>

                           <div class="d-flex justify-content-between align-items-center">
                              <div class="btn-group">
                                 <button type="button" class="btn btn-sm btn-outline-success"
                                    onclick="location.href='select2.do?bandcode=${i.getBandcode()}&userid=${userid }'">들어가기</button>

                              </div>
                              <small class="text-muted">멤버 ${i.getBandcount()}명</small>
                           </div>
                        </div>
                     </div>
                  </div>
               </c:forEach>
            </c:if>
            <c:if test="${empty list }">
            </c:if>
            <!-- col-md-4 end -->
         </div>
         <!-- row end -->
      </div>
      <!--  container end -->
   </div>
   <!--  인기글 시작 -->
   <div class="popmargin" id="popular" style="padding-top: 60px;">
      <div class="card bg-dark text-white"
         style="height: 500px; background-color: black;">
         <div class="card-img-overlay">
            <h3 class="card-title text-center">인기글</h3>
            <div class="container pagewidth" style="margin-top: 20px;">
               <div class="row mb-2">
                  

                     <c:forEach items="${popboard }" var="i">

                        <div class="col-sm-6">
                           <div class="card flex-md-row mb-4 shadow-sm cardb">
                              <div class="card-body d-flex flex-column align-items-start">

                                 <p class="card-text mb-auto" style="color: black;">${i.getBoardcontent() }</p>
                                 <div class="mb-1 text-muted">${i.getBoarddate() }</div>
                              </div>
                              <img class="card-img-right flex-auto d-none d-lg-block right"
                                 src='<c:url value="resources/bandimage/${i.getBoardimage() }"/>'
                                 style="margin: 0;">
                           </div>
                        </div>
                        <!--  하나의 인기글 -->
                     </c:forEach>
              
               </div>
            </div>

         </div>
         <!-- 인기글 CONTAINER END -->
      </div>
   </div>
   <br>
   <br>
   <br>
   <br>
   <br>
   <br>
   <!--  구분 그룹 -->
   <div class="jumbotron jumbotron-fluid" id="popband"
      style="background-color: #3ec729 !important;">
      <div class="container">
         <h1 class="display-4">
            <strong>이런 밴드는 어때요</strong>
         </h1>
         <p class="lead">현재 뜨고있는 인기밴드 소개</p>
      </div>
   </div>
   <!-- 인기밴드 시작 -->
   <div class="popular">
      <div class="container pagewidth">
         <div class="row">

            <c:if test="${!empty pop }">
               <c:forEach items="${pop }" var="i">
                  <div class="col-md-6 mt-3">
                     <div class="card" style="border-color: white;">
                        <div class="row no-gutters">
                           <div class="col-4">
                              <img
                                 src='<c:url value="resources/bandimage/${i.getBandimage() }"/>'
                                 class="card-img cardband" />
                           </div>
                           <div class="col-8">
                              <div class="card-body">
                                 <h5 class="card-title">
                                    <a href="select2.do?bandcode=${i.getBandcode()}&userid=${userid }">   <strong><span class="badge badge-info">${i.getBandname() }</span></strong></a>
                                 </h5>
                                 <p class="card-text card-band">${i.getBandinfo() }</p>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <!-- col-md-4 end -->
               </c:forEach>
            </c:if>
         </div>
         <!-- row end -->
      </div>
   </div>
   <!--  container end -->
   <!--  인기밴드 end -->
   <br>
   <br>
   <br>
   <br>
   <br>
   <div class="w-100 p-3" style="background-color: white; height: 50px;">
      <ul class="nav justify-content-center">
         <li class="nav-item"><a class="nav-link active"
            href="<%=request.getContextPath()%>/adminboard.do"
            style="color: #4C4C4C;">공지사항</a></li>
         <li class="nav-item"><a class="nav-link" href="#">이용약관</a></li>
         <li class="nav-item"><a class="nav-link" href="#">개인정보처리방침</a></li>
         <li class="nav-item"><a class="nav-link disabled" href="#"
            tabindex="-1" aria-disabled="true">활동정책</a></li>
      </ul>
   </div>
</body>
</html>
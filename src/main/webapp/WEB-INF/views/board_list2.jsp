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
	var bandcode = ${bandcode };
	$(function(){
    	bandboard(); //페이지 로딩시 댓글 목록 출력 
    	$("#updateboardBtn").hide();
    	
	});
	$(window).scroll(function(){
		if($(window).scrollTop() >= $(document).height() - $(window).height()){
			scroll();
		}
	});
	
	function scroll(lastbno){
		var lastbno = $(".scrolling:last").attr("data-bno");
		$.ajax({
        	url : 'replylist4.do',
        	type : 'get',
        	dataType: "json",
        	data : {'bandcode':bandcode, 'lastbno':lastbno },
        	success : function(retVal){
        		var userid = retVal.userid;
        		values = retVal.boardlist;
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
                		a += '<img class="img-rounded" src="<c:url value="resources/bandimage/'+value.boardimage+'"/>">';
                		a += '</td>';
                	}
                	a += '</tr>';
                	a += '<tr>';
                	a += '<td colspan="3"><input class="viewreply btn btn-light" type="button" value="댓글보기" onclick="replyview('+value.boardcode+', this.form)">';
                	a += '<input class="reply btn btn-light" type="button" value="댓글쓰기" onclick="reply('+value.boardcode+', this.form)"></td>';
                	a += '</tr></table>';
                	a += '</form>';
                	a += '<div class="replylist"></div>';
                	a += '<div class="replywrite"></div>';
                	a += '</div>';
           			
           		});
           		if(a != ''){
            		$("#board").append(a);
           		}
        	}
   		});
	}
	
	function bandboard(){
    	$.ajax({
        	url : 'replylist3.do',
        	type : 'get',
        	dataType: "json",
        	data : {'bandcode':bandcode },
        	success : function(retVal){
        		var userid = retVal.userid;
        		values = retVal.boardlist;
           		var a ='';
           		if(values == ""){
       				a = '<img src="<c:url value="resources/images/her2.png"/>" style="" >';
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
                		a += '<img class="img-rounded" src="<c:url value="resources/bandimage/'+value.boardimage+'"/>">';
                		a += '</td>';
                	}
                	a += '</tr>';
                	a += '<tr>';
                	a += '<td colspan="3"><input class="viewreply btn btn-light" type="button" value="댓글보기" onclick="replyview('+value.boardcode+', this.form)">';
                	a += '<input class="reply btn btn-light" type="button" value="댓글쓰기" onclick="reply('+value.boardcode+', this.form)"></td>';
                	a += '</tr></table>';
                	a += '</form>';
                	a += '<div class="replylist"></div>';
                	a += '<div class="replywrite"></div>';
                	a += '</div>';
           			
           		});
           		if(a != ''){
            		$("#board").html(a);
           		}
        	}
   		});
	}
	function replyview(boardcode, frm){
		$.ajax({
			url : 'replyview.do',
			type : 'get',
			dataType: "json",
			data : {'bandcode':bandcode, 'boardcode':boardcode},
			success : function(retVal){
				var userid = retVal.userid;
				values = retVal.replylist2;
				if(values.length == 0){
					alert("댓글이 없습니다.");
				}else{
					var a = '';
					$.each(values, function(index, value){
						a += '<form method="post">'; 
						a += '<table class="reply_table table-bordered">';	
						a += '<tr class="replycontent">';
						a += '<td class="reply_username" rowspan="2">'+value.username+'</td>';
						a += '<td class="reply_content">'+value.replycontent+'</td>'
						a += '<td class="reply_button" align="center">';
						if(userid == value.userid){
							a += '<input class="btn btn-light" type="button" value="수정" onclick="updatereply(this.form,'+value.replycode+','+value.bandcode+','+value.boardcode+')">';
							a += '<input class="btn btn-light updatecancel" type="button" value="삭제" onclick="deletereply(this.form,'+value.replycode+','+value.boardcode+')">';
						}
						a += '</td>';
						a += '</tr>';
						a += '<tr>';
						a += '<td colspan="3">'+value.replydate+'</td>';
						a += '</tr>';	
						a += '</table>';
						a += '</form>';
					});
					$(frm).next().html(a);
					$(frm).find(".viewreply").replaceWith('<input class="btn btn-light viewreply" type="button" value="댓글접기" onclick="removereply(this.form, '+boardcode+')">');
					/* $(frm).find(".viewreply").attr("disabled","disabled"); */
				}
			}
		});
		
	}
	function removereply(frm, boardcode){
		$(frm).next().empty();
		$(frm).find(".viewreply").replaceWith('<input class="viewreply btn btn-light" type="button" value="댓글보기" onclick="replyview('+boardcode+', this.form)">');
	}
	function deleteboard(frm, bandcode, boardcode){
		var result = confirm("게시글을 삭제하시겠습니까?");
		if(result){
			$.ajax({
				url : 'deleteboard.do',
				type : 'get',
				data : {'boardcode': boardcode},
				success : function(){
					$(frm).parent().empty();
				}
			});
		}else{
			return false;
		}
	}
	function reply(boardcode, frm){
		var a = '';
		a += '<form method="post">';
		a += '<input type="hidden" name="boardcode" value="'+boardcode+'">';
		a += '<table class="replywrite_table table-bordered">';
		a += '<tr>';
		a += '<td><input class="replycont" name="replycontent" placeholder="댓글을 남겨주세요.">';
		a += '<input class="btn btn-light" type="button" value="댓글쓰기" onclick="writereply(this.form,'+boardcode+')"></td>';
		a += '</tr></table>';
		a += '</form>';
		$(frm).find(".reply").replaceWith('<input class="reply btn btn-light" type="button" value="접기" onclick="removereply2('+boardcode+', this.form)">');
		$(frm).next().next().append(a);
	}
	function removereply2(boardcode, frm){
		$(frm).next().next().empty();
		$(frm).find(".reply").replaceWith('<input class="reply btn btn-light" type="button" value="댓글쓰기" onclick="reply('+boardcode+', this.form)">');
	}
	function writereply(frm, boardcode){
		var replycontent = $("[name='replycontent']").val();
		if(replycontent==""){
			alert("내용을 입력하세요.");
			return false;
		}else{
			$.ajax({
				url : 'writereply.do',
				type : 'get',
				datatype : 'json',
				data : {'bandcode': bandcode, 'boardcode': boardcode, 'replycontent': replycontent},
				success : function(retVal){
					var userid = retVal.userid;
					value = retVal.replydto;
					var a = '';
					a += '<form method="post">'; 
					a += '<table class="reply_table table-bordered" id="replytable">';	
					a += '<tr class="replycontent">';
					a += '<td class="reply_username" rowspan="2">'+value.username+'</td>';
					a += '<td class="reply_content">'+value.replycontent+'</td>'
					a += '<td class="reply_button" aligh="center">';
					if(userid == value.userid){
						a += '<input class="btn btn-light updatebtn" type="button" value="수정" onclick="updatereply(this.form,'+value.replycode+','+value.bandcode+','+value.boardcode+')">';
						a += '<input class="btn btn-light updatecancel" type="button" value="삭제" onclick="deletereply(this.form,'+value.replycode+','+value.boardcode+')">';
					}
					a += '</td>';
					a += '</tr>';
					a += '<tr>';
					a += '<td colspan="3">'+value.replydate+'</td>';
					a += '</tr>';
					a += '</table>';
					a += '</form>';
					$(frm).parent().prev().prepend(a);
					$("[name='replycontent']").val("");
				}
			});
		}	
	}
	function updatereply(frm, replycode, bandcode, boardcode){
		var replycontent = $(frm).find(".reply_content").text();
		$(frm).find(":button").first().replaceWith('<input class="btn btn-light updatebtn" type="button" value="수정" onclick="updatereplyOk(this.form,'+replycode+')">');
		$(frm).find(":button").last().replaceWith('<input class="btn btn-light updatecancel" type="button" value="취소" onclick="updatecancel(this.form,'+bandcode+','+boardcode+','+replycode+')">');
		$(frm).find(".reply_content").replaceWith('<input class="reply_content" name="replycontent" value="'+replycontent+'">');
	}
	function deletereply(frm, replycode, boardcode){
		var result = confirm("댓글을 삭제하시겠습니까?");
		if(result){
			$.ajax({
				url : 'deletereply.do',
				type : 'get',
				data : {'replycode':replycode, 'boardcode':boardcode},
				success : function(retVal){
					$(frm).empty();
				}
			});
		}else{
			return false;
		}
	}
	var sel_file;
	$(document).ready(function(){
		$("#input_img").on("change", handleImgFileSelect);
		$("#input_img2").on("change", handleImgFileSelect2);
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
	function handleImgFileSelect2(e){
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
				$("#img2").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
	function updatereplyOk(frm, replycode){
		var replycontent = $(frm [name='replycontent']).val();
		var result = confirm("댓글을 수정하시겠습니까?");
		if(result){
			$.ajax({
				url : 'updatereply.do',
				type : 'get',
				datatype : 'json',
				data : {'replycode':replycode,'replycontent':replycontent},
				success : function(retVal){
					var replydto = retVal.replydto;
					$(frm [name='replycontent']).replaceWith('<td class="reply_content">'+replydto.replycontent+'</td>');
					$(frm).find(":button").first().replaceWith('<input class="btn btn-light" type="button" value="수정" onclick="updatereply(this.form,'+replydto.replycode+')">');
					$(frm).find(":button").last().replaceWith('<input class="btn btn-light updatecancel" type="button" value="삭제" onclick="deletereply(this.form,'+replydto.replycode+','+replydto.boardcode+')">');
				}
			});
		}else{
			return false;
		}
	}
	function updatecancel(frm, bandcode, boardcode, replycode){
		var result = confirm("수정을 취소하시겠습니까?");
		if(result){
		$.ajax({
			url : 'replydto.do',
			type : 'get',
			dataType: "json",
			data : {'replycode':replycode},
			success : function(retVal){
				var replydto = retVal.replydto;
				$(frm [name='replycontent']).replaceWith('<td class="reply_content">'+replydto.replycontent+'</td>');
				$(frm).find(":button").first().replaceWith('<input class="btn btn-light" type="button" value="수정" onclick="updatereply(this.form,'+replydto.replycode+','+replydto.bandcode+','+replydto.boardcode+')">');
				$(frm).find(":button").last().replaceWith('<input class="btn btn-light updatecancel" type="button" value="삭제" onclick="deletereply(this.form,'+replydto.replycode+','+replydto.boardcode+')">');
			}
		});
		}else{
			return false;
		}
	}
	function writeboard(frm){
		var boardcontent = $("[name='boardcontent']").val();
		if(boardcontent == ""){
			alert("글을 입력해 주세요");
			return false;
		}else{
			frm.submit();
		}
	}

	function updateboard2(frm){
	
		var boardcontent = $(frm [name='boardcontent']).val();
		var boardcode = $(frm [name='boardcode']).val();
		var boardimage = $(frm [name='boardimage']).val();
		$("[name='boardcontent']").val(boardcontent);
		$("[name='boardcode']").val(boardcode);
		$("#img2").attr("src", "<c:url value='resources/bandimage/"+boardimage+"'/>");
		$("#updateboardBtn").click();
	}
	function updateboardOk(frm){
		var boardcontent = $(frm [name='boardcontent']).val();
		if(boardcontent == ""){
			alert("글을 입력해 주세요");
			return false;
		}else{
			frm.submit();
		}
	}
	function bandout(bandcode){
		result = confirm("밴드를 탈퇴하시겠습니까?");
		if(result){
			location.href='bandout.do?bandcode='+bandcode;
		}else{
			return false;
		}
	}
	function joinband(bandcode){
		result = confirm("밴드에 가입하시겠습니까?");
		if(result){
			location.href='joinband.do?bandcode='+bandcode;
		}else{
			return false;
		}
	}
	$(window).scroll(function(){
		var scrollTop = $(document).scrollTop();
		if (scrollTop < 180) {
		 scrollTop = 180;
		}
		$("#followquick").stop();
		$("#followquick").animate( { "top" : scrollTop });
		});
	//페이지 이동
   function fn_movePage(val){
       jQuery("input[name=pageNo]").val(val);
       jQuery("form[name=frm]").attr("method", "post");
       jQuery("form[name=frm]").attr("action","find.do").submit();
   }
   //검색 버튼 //
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
						
						<li class="nav-item"><a class="nav-link" href="#" data-toggle="modal"
					data-target="#exampleModal">글쓰기 </a></li>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
								role="button" aria-haspopup="true" aria-expanded="false">
								<i class="fas fa-user-alt"></i>
								<c:if test="${invite != 0 }">
									<i class="fas fa-exclamation" style="color: red;"></i>
								</c:if>
								</a>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="mypage_info_${dto.getUserid() }.do">내정보
								<c:if test="${invite != 0 }">
									<i class="fas fa-exclamation" style="color: red;"></i>
								</c:if>   
								</a> 
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
					<img src='<c:url value="resources/bandimage/${banddto.getBandimage() }"/>' style="width: 200px;">
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

				<!-- <a class="nav-link" href="#" data-toggle="modal"
					data-target="#exampleModal">글쓰기 </a> -->
				<a class="nav-link" href="#" data-toggle="modal"
					data-target="#exampleModal2" id="updateboardBtn">글쓰기</a>

				<!-- 글쓰기 Modal -->
				<div class="modal fade bd-example-modal-xl" id="exampleModal"
					tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
					aria-hidden="true">
					<div class="modal-dialog modal-xl" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">글쓰기</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form method="post" enctype="multipart/form-data"
									action="writeboard.do">
									<input type="hidden" value="${bandcode }" name="bandcode">
									<%-- <input type="hidden" name="userid" value="${dto.getUserid() }"> --%>
									<div class="form-group">
										<label for="exampleInputName2">글내용</label>
										<textarea class="form-control" rows="3" name="boardcontent"
											placeholder="글내용을 입력하세요."></textarea>
									</div>
									<div class="form-group">
										<img id="img">
									</div>
									<div class="form-group">
										<label for="exampleInputFile">사진</label> <input type="file"
											id="input_img" name="file">
									</div>
									<button type="button" class="btn btn-success"
										onclick="writeboard(this.form)">글쓰기</button>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>

				<!-- 글수정 Modal -->
				<div class="modal fade bd-example-modal-xl" id="exampleModal2"
					tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
					aria-hidden="true">
					<div class="modal-dialog modal-xl" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">글수정</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form method="post" enctype="multipart/form-data"
									action="writeboardOk.do">
									<input type="hidden" value="${bandcode }" name="bandcode">
									<input type="hidden" name="boardcode">
									<%-- <input type="hidden" name="userid" value="${dto.getUserid() }"> --%>
									<div class="form-group">
										<label for="exampleInputName2">글내용</label>
										<textarea class="form-control" rows="3" name="boardcontent"
											placeholder="글내용을 입력하세요."></textarea>
									</div>
									<div class="form-group">
										<img id="img2">
									</div>
									<div class="form-group">
										<label for="exampleInputFile">사진</label> <input type="file"
											id="input_img2" name="file">
									</div>
									<button type="button" class="btn btn-success"
										onclick="updateboardOk(this.form)">수정하기</button>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<div id="board"><br></div>

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
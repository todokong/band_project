<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/boardlist.css" />'>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.js" />'></script>
<script type="text/javascript" src='<c:url value="/resources/js/bandproject.js" />'></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script type="text/javascript">
	function imagereply(boardcode, bandcode){
		var imagecontent = $("#imagecontent").val();
		if(imagecontent == ""){
			alert("댓글을 입력하세요");
		}else{
			$.ajax({
				url : 'imagereply.do',
				type : 'get',
				data : {'replycontent': imagecontent, 'boardcode':boardcode, 'bandcode': bandcode},
				success : function(retVal){
					var userid = retVal.userid;
					value = retVal.replydto;
					var a = '';
					a += '<form>';
					a += '<div class="card" style="margin-bottom: 2px;" >';
					a += '<div class="card-body" style="padding: 3px;">';
					a += '<div class="form-group row">';
					a += '<p class="font-weight-light rename">'+value.username+'</p>';
					if(userid == value.userid){
						a += '<input class="btn btn-light updatebtn" type="button" value="수정" onclick="updatereply(this.form,'+value.replycode+','+value.bandcode+','+value.boardcode+')">';
						a += '<input class="btn btn-light updatecancel" type="button" value="삭제" onclick="deletereply(this.form,'+value.replycode+','+value.boardcode+')">';
					}
					a += '</div>';
					a += '<p class="reply_content">'+value.replycontent+'</p>';
					a += '</div></div>';
					a += '</form>';
					$("#imagereply").prepend(a);
					$("#imagecontent").val("");
				}
			});
		}
	}
	function updatereply(frm, replycode, bandcode, boardcode){
		var replycontent = $(frm).find(".reply_content").text();
		$(frm).find(":button").first().replaceWith('<input class="btn btn-light updatebtn" type="button" value="수정" onclick="updatereplyOk(this.form,'+replycode+')">');
		$(frm).find(":button").last().replaceWith('<input class="btn btn-light updatecancel" type="button" value="취소" onclick="updatecancel(this.form,'+bandcode+','+boardcode+','+replycode+')">');
		$(frm).find(".reply_content").replaceWith('<p><input class="reply_content reinput" name="replycontent" value="'+replycontent+'"><p>');
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
					$(frm [name='replycontent']).replaceWith('<p class="reply_content">'+replydto.replycontent+'</p>');
					$(frm).find(":button").first().replaceWith('<input class="btn btn-light" type="button" value="수정" onclick="updatereply(this.form,'+replydto.replycode+','+replydto.bandcode+','+replydto.boardcode+')">');
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
				$(frm [name='replycontent']).replaceWith('<p class="reply_content">'+replydto.replycontent+'</p>');
				$(frm).find(":button").first().replaceWith('<input class="btn btn-light" type="button" value="수정" onclick="updatereply(this.form,'+replydto.replycode+','+replydto.bandcode+','+replydto.boardcode+')">');
				$(frm).find(":button").last().replaceWith('<input class="btn btn-light updatecancel" type="button" value="삭제" onclick="deletereply(this.form,'+replydto.replycode+','+replydto.boardcode+')">');
			}
		});
		}else{
			return false;
		}
	}
	function deletereply(frm, replycode, boardcode){
		var result = confirm("댓글을 삭제하시겠습니까?");
		if(result){
			$.ajax({
				url : 'deletereply.do',
				type : 'get',
				data : {'replycode':replycode, 'boardcode':boardcode},
				success : function(retVal){
					$(frm).remove();
				}
			});
		}else{
			return false;
		}
	}
	function deleteimage(bandcode, boardcode){
		var result = confirm("사진을 삭제하시겠습니까?");
		if(result){
			location.href = 'deleteimage.do?bandcode='+bandcode+'&boardcode='+boardcode;
		}else{
			return false;
		}
	}
</script>
<style type="text/css">
.container {
   background-color: black;
   max-width: 100%;
   height: 740px;
}
/* .row{
padding: 0px;
} */
img { display: block; margin: 0px auto; }
.rename{margin-left: 20px; width: 250px;}
.reinput{width: 300px;}
</style>
</head>
<body style="background-color: black;">
	<c:set value="${boardDTO }" var="boarddto"></c:set>	
               
	<div class="container">
      <div class="row h-100 w-100">
         <div class="col-9">
         	<button type="button" class="close pos" data-dismiss="modal" aria-label="Close" onclick="location.href='bandimage.do?bandcode=${bandcode }'">
               <span aria-hidden="true">&times;</span>
            </button>
            <div id="carouselExampleControls" class="carousel slide "
               data-interval="false" data-ride="carousel" style="margin-top: 100px;">
               
               <div class="carousel-inner ">
               
               	
                  <div class="carousel-item active "> <!--  클릭한 이미지 active가 있어야 함 -->
                     <img src='<c:url value="resources/upload/${boarddto.getBoardimage() }"/>'
                        class="d-block " alt="...">
                  </div>
                
               </div>
               <a class="carousel-control-prev" href="preimage.do?boardcode=${boarddto.getBoardcode() }&bandcode=${bandcode }"
                  role="button" data-slide="prev"> <span
                  class="carousel-control-prev-icon" aria-hidden="true"></span> <span
                  class="sr-only">Previous</span>
               </a> <a class="carousel-control-next" href="nextimage.do?boardcode=${boarddto.getBoardcode() }&bandcode=${bandcode }"
                  role="button" data-slide="next"> <span
                  class="carousel-control-next-icon" aria-hidden="true"></span> <span
                  class="sr-only">Next</span>
               </a>
            </div>
         </div>
         
         <div class="col-3 reply ">
            <!--  댓글 -->
            
            <div class="card h-100" style="width: 400px;">
					<div class="card-header">

						<p>
							<strong>${boarddto.getUsername() }</strong> 
							<c:if test="${boarddto.getUserid() == dto.getUserid() }">
							<input
								class="btn btn-outline-primary" type="button" value="삭제"
								style="margin-left: 250px;"
								onclick="deleteimage(${bandcode}, ${boarddto.getBoardcode() })"></c:if>
						</p>
						<P>${boarddto.getBoarddate() }</P>
						<p>댓글</p>
					</div>

					<div class="card-body" style="padding: 3px; ma" >
                  <!--  댓글을 보여주는 화면 -->
                  <div id="imagereply"></div>
                  
                  <c:set value="${replylist }" var="reply"></c:set>
                  
                  <c:forEach items="${reply }" var="replydto">
                  <form action="">
                  <div class="card" style="margin-bottom: 2px;" >
                     <div class="card-body" style="padding: 3px;">
                     
                     	<div class="form-group row">
                        <p class="font-weight-light rename">${replydto.getUsername() }</p>
                        <c:if test="${replydto.getUserid() == dto.getUserid() }">
                        <input class="btn btn-light updatebtn" type="button" value="수정" onclick="updatereply(this.form,${replydto.getReplycode()},${bandcode },${replydto.getBoardcode() })">
						<input class="btn btn-light updatecancel" type="button" value="삭제" onclick="deletereply(this.form,${replydto.getReplycode()},${replydto.getBoardcode() })">
						</c:if>
                      	</div>
                        <p class="reply_content">${replydto.getReplycontent() }</p>
                     </div>
                  </div>
                  </form>
                 </c:forEach>
                 
               </div>
               
               <div class="card-footer text-muted">
                  <div class="input-group mb-3">
                     <input type="text" class="form-control" placeholder="댓글을 작성해주세요." id="imagecontent"
                        aria-label="Recipient's username"
                        aria-describedby="button-addon2">
                     <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="button"
                           id="button-addon2" onclick="imagereply(${boardcode}, ${bandcode })">댓글쓰기</button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- card end -->
            
         </div>
         <!--  col-3 end -->
      </div>
      <!--  row end -->
   </div>
   <!--  container end -->
   
				
</body>
</html>
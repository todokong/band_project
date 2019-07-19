
// 이미지 미리보기
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

/*  게시물 삭제 확인 메서드 */
function deleteboard(frm, boardcode, bandcode){
	var result = confirm("게시물을 삭제 하시겠습니까?");
	if(result){
		frm.action = "deleteboard.do?boardcode="+boardcode+"&bandcode="+bandcode;
		frm.submit();
	}else{
		return false;
	}
} 

/* 댓글 삭제 확인 메서드 */
function deletereply(frm, replycode, bandcode){
	var result = confirm("댓글을 삭제 하시겠습니까?");
	if(result){
		frm.action = "deletereply.do?replycode="+replycode+"&bandcode="+bandcode;
		frm.submit();
	}else{
		return false;
	}
}

/* 댓글 수정 메서드 */
/*$(function(){
	$(".replycontent").hide();
	$(".updatebtn").click(function(){
		$(this).parents("tr").hide();
		$(this).parents("tr").siblings().show();
	});
	
	$(".updatecancel").click(function(){
		var result = confirm("수정을 취소하시겠습니까?");
		if(result){
			$(this).parents("tr").hide();
			$(this).parents("tr").siblings().show();
		}else{
			return false;
		}
	});
});*/

/* 댓글 수정 확인 메서드 */
function updatereply(frm, replycode, bandcode){
	var result = confirm("댓글을 수정 하시겠습니까?");
	if(result){
		frm.action = "updatereply.do?replycode="+replycode+"&bandcode="+bandcode;
		frm.submit();
	}else{
		return false;
	}
}

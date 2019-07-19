	
$(function(){
    	bandboard(); //페이지 로딩시 댓글 목록 출력 
    	$("#updateboardBtn").hide();
	});
	
	function bandboard(){
    	$.ajax({
        	url : 'replylist2.do',
        	type : 'get',
        	dataType: "json",
        	data : {'bandcode':bandcode },
        	success : function(retVal){
        		var userid = retVal.userid;
        		values = retVal.boardlist;
           		var a ='';
           		$.each(values, function(index, value){
           			a += '<div class="boardlist">';
                	a += '<form method="post">';
                	a += '<input type="hidden" value="'+value.boardimage+'" name="boardimage">';
                	a += '<input type="hidden" value="'+value.boardcode+'" name="boardcode">';
                	a += '<table class="board_table table-bordered">';
                	a += '<tr>';
                	a += '<th class="board_username" align="center">'+value.username+'</th>';
                	a += '<td class="board_date">'+value.boarddate+'</td>';
                	a += '<td class="board_button" align="right">';
                	if(userid == value.userid){
                		a += '<input class="btn btn-info btn-sm" type="button" value="수정" onclick="updateboard2(this.form)" >';
                		a += '<input class="btn btn-info btn-sm" type="button" value="삭제" onclick="deleteboard(this.form, ${bandcode}, '+value.boardcode+')">';
                	}
                	a += '</td></tr>';
                	a += '<tr>';
                	a += '<td colspan="3" class="board_content">';
                	a += '<textarea class="form-control" rows="3" readonly="readonly" name="boardcontent">'+value.boardcontent+'</textarea>';
                	a += '</td></tr>';
                	a += '<tr>';
                	if(value.boardimage != 'no_file'){
                		a += '<td colspan="3" align="center" class="board_image">';
                		a += '<img class="img-rounded"src="<c:url value="resources/upload/'+value.boardimage+'"/>">';
                		a += '</td>';
                	}
                	a += '</tr>';
                	a += '<tr>';
                	a += '<td><input class="viewreply" type="button" value="댓글보기" onclick="replyview('+value.boardcode+', this.form)"></td>';
                	a += '<td><input class="reply" type="button" value="댓글쓰기" onclick="reply('+value.boardcode+', this.form)"></td>';
                	a += '</tr></table>';
                	a += '</form>';
                	a += '<div class="replylist"></div>';
                	a += '<div class="replywrite"></div>';
                	a += '</div>';
           		});
            	$("#board").prepend(a);
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
						a += '<table class="reply_table table-bordered" id="replytable">';	
						a += '<tr class="replycontent">';
						a += '<td class="reply_username" rowspan="2">'+value.username+'</td>';
						a += '<td class="reply_content">'+value.replycontent+'</td>'
						a += '<td class="reply_button">';
						if(userid == value.userid){
							a += '<input class="btn btn-info btn-sm" type="button" value="수정" onclick="updatereply(this.form,'+value.replycode+','+value.bandcode+','+value.boardcode+')">';
							a += '<input class="btn btn-info btn-sm updatecancel" type="button" value="삭제" onclick="deletereply(this.form,'+value.replycode+','+value.boardcode+')">';
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
					$(frm).find(".viewreply").attr("disabled","disabled");
				}
			}
		});
		
	}
	function deleteboard(frm, bandcode, boardcode){
		var result = confirm("게시글을 삭제하시겠습니까?");
		if(result){
			$.ajax({
				url : 'deleteboard.do',
				type : 'get',
				data : {'boardcode': boardcode},
				success : function(){
					$(frm).parent().remove();
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
		a += '<table>';
		a += '<tr>';
		a += '<td><input name="replycontent" placeholder="댓글을 남겨주세요."></td>';
		a += '<td><input class="btn btn-info btn-sm" type="button" value="댓글쓰기" onclick="writereply(this.form,'+boardcode+')"></td>';
		a += '</tr></table>';
		a += '</form>';
		$(frm).find(".reply").attr("disabled","disabled");
		$(frm).next().next().append(a);
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
					a += '<td class="reply_button">';
					if(userid == value.userid){
						a += '<input class="btn btn-info btn-sm updatebtn" type="button" value="수정" onclick="updatereply(this.form,'+value.replycode+','+value.bandcode+','+value.boardcode+')">';
						a += '<input class="btn btn-info btn-sm updatecancel" type="button" value="삭제" onclick="deletereply(this.form,'+value.replycode+','+value.boardcode+')">';
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
		$(frm).find(":button").first().replaceWith('<input class="btn btn-info btn-sm updatebtn" type="button" value="수정ok" onclick="updatereplyOk(this.form,'+replycode+')">');
		$(frm).find(":button").last().replaceWith('<input class="btn btn-info btn-sm updatecancel" type="button" value="취소r" onclick="updatecancel(this.form,'+bandcode+','+boardcode+','+replycode+')">');
		$(frm).find(".reply_content").unwrap().wrap('<input class="reply_content" name="replycontent" value="'+replycontent+'">');
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
					$(frm).find(":button").first().replaceWith('<input class="btn btn-info btn-sm" type="button" value="수정" onclick="updatereply(this.form,'+replydto.replycode+')">');
					$(frm).find(":button").last().replaceWith('<input class="btn btn-info btn-sm updatecancel" type="button" value="삭제" onclick="deletereply(this.form,'+replydto.replycode+','+replydto.boardcode+')">');
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
				$(frm).find(":button").first().replaceWith('<input class="btn btn-info btn-sm" type="button" value="수정" onclick="updatereply(this.form,'+replydto.replycode+','+replydto.bandcode+','+replydto.boardcode+')">');
				$(frm).find(":button").last().replaceWith('<input class="btn btn-info btn-sm updatecancel" type="button" value="삭제" onclick="deletereply(this.form,'+replydto.replycode+','+replydto.boardcode+')">');
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
		$("#img2").attr("src", "<c:url value='resources/upload/"+boardimage+"'/>");
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
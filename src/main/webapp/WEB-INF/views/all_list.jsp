<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/search.css" />'>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.js" />'></script>
<script type="text/javascript" src='<c:url value="/resources/js/band.js" />'></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
<script type="text/javascript">
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
<body>

	<div id="main">
	<fieldset id="searchTop" style="height: 40px">
		<div id="header">
			<form method="post" action="find.do" id="frm" name="frm">
			<input type="hidden" name="pageNo" /><!-- //페이지 번호 -->
    	<input type="hidden" name="searchValue" id="searchValue" value="${Paging.searchValue }" /><!-- //검색어 -->
			<a href="search.do" id="logo"><img src='<c:url value="/resources/images/bandlogo2.png"/>'></a>
			
			<div class="box" align="center">
  				<div class="container-1">
      				
      				<input type="text" name="search" id="search" placeholder="Search..."  
      				onkeypress="JavaScript:Enter_Check();"/>
      				<input type="button" value="SEARCH" onclick="fn_search();"/>
  				</div>
			</div>
			
			<a href="#" id="profile" style="float: right; ">${dto.getUsername() }의 프로필</a>
			</form>
			
		</div><%-- id=header end --%>
		</fieldset>
		<div class="clear"></div>
		
	<fieldset style="border: none; background-color: lightgray">
	<fieldset id="searchCenter" style="border: none">
	<legend>밴드 전체 리스트</legend>
	<div id="center" align="center">	
	<c:set var="list" value="${allList }"></c:set>
	<c:if test="${!empty list }">
	<c:set var="i" value="0" />
	<c:set var="j" value="2" />
		<table>
		<a href="search.do" style="float: right;">돌아가기></a>
		<c:forEach items="${list }" var="dto"> 	
		<c:if test="${i%j == 0 }">
				<tr>
				</c:if>
				<td>
				<fieldset style="background-color: white; border: none;">
				<a href="#">
				<img src='<c:url value="resources/bandimage/${dto.getBandimage() }"/>' height="50px" width="100px"><br>
				${dto.getBandname() }
				</a>
				</fieldset>
				</td>
				<c:if test="${i%j == j-1 }">
				</tr>
				</c:if>
				<c:set var="i" value="${i+1 }" />
		</c:forEach>
		</table>
		</c:if> 
		
		<c:if test="${empty list }">
				<h3>검색된 밴드가 존재하지 않습니다.</h3>	
		</c:if>
	
	</div>
	</fieldset>
	</fieldset>
	</div>
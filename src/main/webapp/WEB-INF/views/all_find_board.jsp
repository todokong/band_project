<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">


</style>
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/search.css" />'>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.js" />'></script>
<script type="text/javascript" src='<c:url value="/resources/js/band.js" />'></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>

	
	<div id="main">
	<fieldset id="searchTop">
		<div id="header">
			<form method="post" action="find.do">
			<a href="search.do" id="logo"><img src='<c:url value="/resources/images/bandlogo2.png"/>'></a>
			<div class="box" align="center">
  				<div class="container-1">
      				<span class="icon"><i class="fa fa-search"></i></span>
      				<input type="search" name="search" id="search" placeholder="Search..." />
  				</div>
			</div>
			<a href="#" id="profile">${dto.getUsername() }의 프로필</a>
			</form>
					
		</div><%-- id=header end --%>
		</fieldset>
		<div class="clear"></div>
		
		<fieldset style="border: none; background-color: lightgray;">
	<fieldset id="searchCenter" style="border: none;">
	<legend>검색된 게시글</legend>
	<a href="search.do" style="float: right;">돌아가기></a>
	<div id="center" align="center">	
	<c:set var="bList" value="${bList }"></c:set>
	<c:if test="${!empty bList }">
	<c:set var="i" value="0" />
	<c:set var="j" value="2" />
		<table>
		<c:forEach items="${bList }" var="dto"> 	
				<tr>
				<td>
				<fieldset style="background-color: white; border: none; width: 300px; height: 180px">
				<p>
				${dto.getBandname() }<br>
				${dto.getUsername() }<br>
				<textarea rows="7" cols="80" readonly>${dto.getBoardcontent() }</textarea>  
				</p>
				</fieldset>
				</td>
				</tr>
				
		</c:forEach>
		</table>
		</c:if>
		<c:if test="${empty bList }">
				<h3>검색된 게시글이 존재하지 않습니다.</h3>	
		</c:if> 
		</div>
		</fieldset>
		</fieldset>
		
		
	</div>	

</body>
</html>
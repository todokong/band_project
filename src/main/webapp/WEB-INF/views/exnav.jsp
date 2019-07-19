<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
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

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/24e2aa92d8.js"></script>

<style type="text/css">
* {
    box-sizing: border-box;
}

html,
body {
    margin: 0;
    padding: 0;
}
/* Start Section Styles */
section {
    width: 100%;
    min-height: 800px;
}

#home {
    background-color: green;
}

#one {
    background-color: blue;
}

#two {
    background-color: yellow;
}

#three {
    background-color: salmon;
}

#four {
    background-color: purple;
}

</style>
<script type="text/javascript">
	$(function(){
		var link =$('#navbar-example2 a.nav-link');
		link.on('click',function(e){
				var target=$($(this).attr('href'));
				$('html,body').animate({scrollTop:target.offset().top},600);
				$(this).addClass('active');
				e.preventDefault();
		});
		$(window).on('scroll',function(){
			findPosition();
		});
		function findPosition(){
			$('section').each(function(){
				if($(this).offset().top - $(window).scrollTop() <20){
					link.removeClass('active');
					$('#navbar-example2').find('[data-scroll="'+$(this).attr('id')+'"]').addClass('active');
					
				}
			});
		}
	});
</script>
</head>
<body>
	<nav id="navbar-example2"
		class="navbar navbar-light bg-light sticky-top">
		<div class="container a">
			<a class="navbar-brand" href="#">BAND</a>
			
			
			<form class="form-inline">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
			
			<ul class="nav nav-pills" role="tablist">
				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#exampleModal">밴드 추가 </a></li>
				<li class="nav-item"><a class="nav-link active" href="#home" data-scroll="home">홈</a>
				</li>

				<li class="nav-item"><a class="nav-link" href="#one" data-scroll="one">하나</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#two" data-scroll="two">둘</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#three" data-scroll="three">셋</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="#four" data-scroll="four">넷</a>
				</li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
					role="button" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user-alt"></i></a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#">내정보</a> <a class="dropdown-item"
							href="#">설정</a>
						<div role="separator" class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">로그아웃</a>
					</div></li>
			</ul>



		</div>
	</nav>

<section id="home"></section>
<section id="one"></section>
<section id="two"></section>
<section id="three"></section>
<section id="four"></section>

</body>
</html>
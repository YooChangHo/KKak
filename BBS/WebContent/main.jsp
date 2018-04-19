
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 실행할 수 있도록 라이브러리를 불러옴. -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"  content="width=device-width" , initial-scale="1">
<!-- 반응형 웹에 사용될 수 있는 메타태크를 위에 써준 것  -->
<link rel="stylesheet" href="css/bootstrap.css">
<!--  stylesheet 을 참조하겠다. css 폴더안에 있는 부트스트랩파일을 참조하겠다.  -->
<link rel="stylesheet" href="css/custom.css">
<!-- 우리가 만든 글씨체를 적용 -->
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null)/*  현재 세션이 존재하는 사람이라면 그 아이디값을 그대로 받아서 관리할 수 있음. */
		{
			userID = (String) session.getAttribute("userID"); /* String형태로 형변환해준다음 세션에 있는 값을 그대로 가져옴. 
			로그인을 한 사람이라면  유저ID라는 변수에 해당아이디 담기고 그렇지 않으면 null 값이 들어감. */
		}
	%>
	<nav class="navbar navbar-default"> 
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<!-- 오른쪽 상단 짝대기 3개 -->
				</button>
				<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
				<!-- brand는 로고같은 걸 의미한다. -->
		</div>
		<div class="callapse navbar-collapse" id="bs-example-navbar-callapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a> <!-- main이라는 하나의 링크를 검 -->
				<!-- active 는 현재 선택된 현재의 페이지를 의미. 단 한개의 페이지에만 들어갈수잇음.  -->
				<li><a href="bbs.jsp">게시판</a>
			</ul>
			<%
				if (userID == null) { /* 로그인이 되어 있지 않다면 회원가입이나 로그인을 할 수 있도록 네비게이션을 만듬. */
			%>
			<ul class="nav navbar-nav navbar-right">
				<!-- list를 하나더 만들어 오른쪽에다 -->
				<li class="dropdown">
					<!-- 원소를 넣어줌 --> 
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a> <!-- #은 현재가르키고있는 링크가 없다. caret 은 하나의 아이콘 같은 것이다.  -->
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
				else 
				{
			%>
			<ul class="nav navbar-nav navbar-right">
				<!-- list를 하나더 만들어 오른쪽에다 -->
				<li class="dropdown">
					<!-- 원소를 넣어줌 --> 
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a> <!-- #은 현재가르키고있는 링크가 없다. caret 은 하나의 아이콘 같은 것이다.  -->
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1>
				<p>이 웹사이트는 부트스트랩으로 만든 JSP 웹 사이트입니다. 최소한의 간단한  로직만을 이용해서 개발했습니다. 디자인 템플릿으로는 부트스트래을 이용했습니다.</p>
				<p><a class="btn btn-primary btn-pull" href="#" role-"button">자세히 알아보기</a></p> 
				<!-- 일반 적으로 점보트론 안에는 a태그를 이용해서 어떠한 페이지로 이동할 수 있도록 버튼을 만들어줌. a태그를 p태그로 한번 감쌈. -->
			</div>
		</div>
	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/1.jpg">
				</div>
				<div class="item">
					<img src="images/2.jpg">
				</div>
				<div class="item">
					<img src="images/3.jpg">
				</div>
			</div>
			<a class="lef carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevran-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevran-right"></span>
			</a>
		</div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"> </script>
	<!-- 애니메이션 담당하는 자바스크립트 참조. -->
	<script src="js/bootstrap.js"></script>
	<!-- 부트스트랩에서 기본적으로 제공해주는 자바스크립트 파일 참조. js 폴더안에 있는 bootstrap file  -->
</body>
</html>
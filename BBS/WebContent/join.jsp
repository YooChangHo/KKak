
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<li><a href="main.jsp">메인</a> <!-- main이라는 하나의 링크를 검 -->
				<li><a href="bbs.jsp">게시판</a>
			</ul>
			<!-- ul은 하나의 list같은 것을 보여줄 때 사용 -->
			<ul class="nav navbar-nav navbar-right"> 
			<!-- list를 하나더 만들어 오른쪽에다 -->
				<li class="dropdown"> <!-- 원소를 넣어줌 -->
					<a href="#" class="dropdown-toggle" 
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a> 
						<!-- #은 현재가르키고있는 링크가 없다. caret 은 하나의 아이콘 같은 것이다.  -->
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<!-- active 는 현재 선택된 현재의 페이지를 의미. 단 한개의 페이지에만 들어갈수잇음.  -->
						<li class="active"><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container"> <!-- 로그인 양식을 만든다. 하나의 컨테이너처럼. -->
		<div class="col-lg-4"></div>
		<div class="col-lg-4"> <!-- 중간에 로그인 양식이 들어가는 것 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="joinAction.jsp"> <!-- form은 하나의 양식이 들어가는 것. post는 정보를 숨기고 보낼때 쓰는 하나의 메소드, 정보를 joinAction 페이지로 보냄. -->
					<h3 style="text-align: center;">회원가입 화면</h3> <!-- 가운데 정렬 -->
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div> <!-- 어떤 정보를 넣을 수 있는 input. holder는 아무것도 입력이 되지 않았을때 나타나는 것. name는 서버프로그램 작성할때 사용되는 중요한 정보(매개변수). -->
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
					<!-- 아래부분부터는 남자인지 여자인지 성별 선택하도록. 버튼그룹이 들어감. -->
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active"> <!-- active는 기본적으로 선택이 된것. 처음에는 남자부분이 선택되어있게. -->
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
							</label>
						</div>
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
					 </div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입"> <!-- 로그인 버튼 생성 -->
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"> </script>
	<!-- 애니메이션 담당하는 자바스크립트 참조. -->
	<script src="js/bootstrap.js"></script>
	<!-- 부트스트랩에서 기본적으로 제공해주는 자바스크립트 파일 참조. js 폴더안에 있는 bootstrap file  -->
</body>
</html>
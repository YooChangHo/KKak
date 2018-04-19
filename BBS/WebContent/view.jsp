
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 실행할 수 있도록 라이브러리를 불러옴. -->
<%@ page import="bbs.Bbs" %> <!-- bbs클래스를 그대로 가져오고 -->
<%@ page import="bbs.BbsDAO" %> <!-- 데이터베이스접근객체도 가져오자. -->
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
		int bbsID = 0;
		if (request.getParameter("bbsID") !=null){ /* 만약에 매개변수로 넘어온 bbsID가 존재한다면 */
			bbsID = Integer.parseInt(request.getParameter("bbsID")); /* bbsID에 담음 */
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'"); 
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID); /* bbsID아이디가 0이 아니라서 유효한 글이라면 구체적인 정보를 bbs라는 인스턴스안에 담음. */
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
				<li><a href="main.jsp">메인</a> <!-- main이라는 하나의 링크를 검 -->
				<li class="active"><a href="bbs.jsp">게시판</a>
				<!-- active 는 현재 선택된 현재의 페이지를 의미. 단 한개의 페이지에만 들어갈수잇음.  -->
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
	<!-- 테이블을 만듦으로써 디자인을 할 수 있음 -->
	<div class="container">
		<div class="row"> 
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
						</tr>
						<!-- colspan="3"은 총 3개만큼의 열을 잡아먹을 수 있게. -->
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td> <!-- 글 제목을 넣어줌 -->
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%= bbs.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %> </td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
							<!-- .replaceAll<>은 공백이나 특수문자를 허용하게 해주는 것이다. html 특수문자를 이용해서 치환해서 출력 -->
						</tr>
					</tbody>
				</table>
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<%
					if(userID !=null && userID.equals(bbs.getUserID())){
				%>
					<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
				<% 
					}
				%>
		</div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"> </script>
	<!-- 애니메이션 담당하는 자바스크립트 참조. -->
	<script src="js/bootstrap.js"></script>
	<!-- 부트스트랩에서 기본적으로 제공해주는 자바스크립트 파일 참조. js 폴더안에 있는 bootstrap file  -->
</body>
</html>
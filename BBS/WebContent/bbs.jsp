
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 실행할 수 있도록 라이브러리를 불러옴. -->
<%@ page import="bbs.BbsDAO" %> <!-- bbs 패키지에있는 BbsDAO를 가져옴. -->
<%@ page import="bbs.Bbs" %> 
<%@ page import="java.util.ArrayList" %> <!-- ArrayList는 게시판목록을 출력하기 위해 필요함. -->
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
<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null)/*  현재 세션이 존재하는 사람이라면 그 아이디값을 그대로 받아서 관리할 수 있음. */
		{
			userID = (String) session.getAttribute("userID"); /* String형태로 형변환해준다음 세션에 있는 값을 그대로 가져옴. 
			로그인을 한 사람이라면  유저ID라는 변수에 해당아이디 담기고 그렇지 않으면 null 값이 들어감. */
		}
		int pageNumber = 1; /* 1은 기본페이지 1페이지 의미 */
		if (request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} /* parseInt -> 정수형으로 바꿔줌 */
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
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++){
					%>
					<tr> <!-- 이 부분에 게시글이 실제로 출력됨 -->
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber !=1){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if(bbsDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"> </script>
	<!-- 애니메이션 담당하는 자바스크립트 참조. -->
	<script src="js/bootstrap.js"></script>
	<!-- 부트스트랩에서 기본적으로 제공해주는 자바스크립트 파일 참조. js 폴더안에 있는 bootstrap file  -->
</body>
</html>
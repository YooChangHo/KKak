
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> <!-- 스크립트 문장을 실행할 수 있도록 라이브러리를 불러옴. -->
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
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
		if (userID ==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'"); 
			script.println("</script>");
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
		Bbs bbs = new BbsDAO().getBbs(bbsID); /* 현재 작성한 글이 작성 본인인지 확인하기 위한 세션관리 */
		 /* 넘어온 bbsID값을 가지고 해당글을 가져온다음 실제로 글을 작성사람이 맞는지 확인 */
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'"); 
			script.println("</script>");
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
				<li><a href="main.jsp">메인</a> <!-- main이라는 하나의 링크를 검 -->
				<li class="active"><a href="bbs.jsp">게시판</a>
				<!-- active 는 현재 선택된 현재의 페이지를 의미. 단 한개의 페이지에만 들어갈수잇음.  -->
			</ul>
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
		</div>
	</nav>
	<!-- 테이블을 만듦으로써 디자인을 할 수 있음 -->
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>"> 
			<!-- method:post 로 해서 보내지는 내용이 숨겨지도록 만들어주고 글제목과 내용은 writeAction으로 보내줌.   -->
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 수정 양식</th>
						</tr>
						<!-- colspan="2"은 총 2개만큼의 열을 잡아먹을 수 있게. -->
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
							<!-- input 은 특정한 정보를 action 페이지로 보내기 위해 사용 -->
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"><%= bbs.getBbsContent() %></textarea></td>
							<!-- textarea은 어떤 장문의 글을 작성할때 사용.  -->
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
					<!-- 글쓰기 버튼을 만들었고 이걸 눌렀을 경우 실제로 어떠한 데이터를 action 페이지로 보낼 수 있는 것이다. -->
			</form>
		</div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"> </script>
	<!-- 애니메이션 담당하는 자바스크립트 참조. -->
	<script src="js/bootstrap.js"></script>
	<!-- 부트스트랩에서 기본적으로 제공해주는 자바스크립트 파일 참조. js 폴더안에 있는 bootstrap file  -->
</body>
</html>
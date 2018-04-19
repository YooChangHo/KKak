<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- 우리가 만든 클래스를 사용하기 위해 불러옴 (그대로가져옴)-->
<%@ page import="java.io.PrintWriter  " %> <!-- java scirpt 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8 받을 수 있도록 -->
<jsp:useBean id="user" class="user.User" scope="page" /> <!-- 자바빈즈를 사용한다. user라는 아이디를 만듬. scope=page 는 현재 페이지에서안에서만 빈즈사용.  -->
<jsp:setProperty name="user" property="userID" /> <!-- login 페이지에서 넘겨준 userID 받아서 한명의 사용자의 유저아이디에 넣어주는 것. -->
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!-- 그럼 이 페이지 안에 넘어온 유저아이디와 패스워드 그리고 나머지가가 그대로 담김. -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'"); /* 이전 페이지로 사용자를 돌려 보냄. 즉 로그인 페이지로 */
			script.println("</script>");
		}
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
				|| user.getUserGender() == null || user.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); /* 이전 페이지로 사용자를 돌려 보냄. 즉 로그인 페이지로 */
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO(); /* userDAO라는 데이터베이스에 접근할 수 있는 하나의 인스턴스(객체)를 만듬. */
			int result = userDAO.join(user);
			/* 각각의 변수들을 다 입력받아서 만들어진 하나의 user라는 인스턴스(객체)가 join함수를 수행하도록 join 함수를 수행하도록
			매개변수로 들어가는 것이다. 즉, 입력받은 데이터를 가지고 실제로 회원가입을 수행하도록 명령어를 넣어준 것. */
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()"); /* 이전 페이지로 사용자를 돌려 보냄. 즉 로그인 페이지로 */
				script.println("</script>");
			} else {
				session.setAttribute("userID",
						user.getUserID()); /* userID라는 이름으로 세션 부여. 세션 값으로는 getUserID라 해서 해당 회원 아이디를 세션값으로 넣음. */
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}

		}
	%>
	<!-- 이렇게 함으로써 회원가입 처리가 완료! -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %> <!-- 우리가 만든 클래스를 사용하기 위해 불러옴 (그대로가져옴)-->
<%@ page import="java.io.PrintWriter  " %> <!-- java scirpt 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8 받을 수 있도록 -->
<jsp:useBean id="user" class="user.User" scope="page" /> <!-- 자바빈즈를 사용한다. user라는 아이디를 만듬. scope=page 는 현재 페이지에서안에서만 빈즈사용.  -->
<jsp:setProperty name="user" property="userID" /> <!-- login 페이지에서 넘겨준 userID 받아서 한명의 사용자의 유저아이디에 넣어주는 것. -->
<jsp:setProperty name="user" property="userPassword" />
<!-- 그럼 이 페이지 안에 넘어온 유저아이디와 패스워드가 그대로 담김. -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") !=null)
		{
			userID = (String) session.getAttribute("userID");	
		}
		if(userID !=null)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO(); /* userDAO라는 하나의 인스턴스를 만듬. */
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); 
		/* 로그인을 시도 함. login 페이지에서 user 아이디와 패스워드가 각각 입력된 값으로 여기로 넘어와서 그 값을 로그인 함수에 넣어 실행.
		아까 설정한 Result 값이 여기로 반환됨. */
		if(result == 1)
		{
			session.setAttribute("userID", user.getUserID()); /* userID라는 이름으로 세션 부여. 세션 값으로는 getUserID라 해서 해당 회원 아이디를 세션값으로 넣음. */
			PrintWriter script = response.getWriter(); /* 하나의 스크립트 문장을 넣어줄 수 있도록 함 */
			script.println("<script>"); /* 스크립트 문장을 유동적으로 실행할수 있도록 함. */
			script.println("location.href = 'main.jsp'"); /* 링크를 넣어 main.jsp 로 이동하게 함. */
			script.println("</script>");
		}
		else if(result == 0)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()"); /* 이전 페이지로 사용자를 돌려 보냄. 즉 로그인 페이지로 */
			script.println("</script>");
		}
		else if(result == -1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history .back()");
			script.println("</script>");
		}
		else if(result == -2)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	
	<!-- 이렇게 함으로써 완벽하게 로그인 처리가 완료. -->
</body>
</html>
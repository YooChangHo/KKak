<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> <!-- 우리가 만든 클래스를 사용하기 위해 불러옴 (그대로가져옴, BbsDAO 객체를 이용)-->
<%@ page import="java.io.PrintWriter  " %> <!-- java scirpt 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든 데이터를 UTF-8 받을 수 있도록 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" /> <!-- 자바빈즈를 사용한다. bbs라는 아이디를 만듬. scope=page 는 현재 페이지에서안에서만 빈즈사용.  -->
<jsp:setProperty name="bbs" property="bbsTitle" /> 
<jsp:setProperty name="bbs" property="bbsContent" />
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
		if (userID == null) { /* 로그인이 안된경우 */
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'"); /* 로그인 페이지로 */
			script.println("</script>");
		} else {
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
				/* 사용자가 글제목이나 내용을 읿력 하지 x -> 오류발생 */
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); /* 이전 페이지로 사용자를 돌려 보냄. 즉 로그인 페이지로 */
				script.println("</script>");
			} else { 
				BbsDAO bbsDAO = new BbsDAO(); /* userDAO라는 데이터베이스에 접근할 수 있는 하나의 인스턴스(객체)를 만듬. */
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				/* 각각의 변수들을 다 입력받아서 만들어진 하나의 bbs라는 인스턴스(객체)가 write함수를 수행하도록
				매개변수로 들어가는 것이다. 즉, 입력받은 데이터를 가지고 실제로 게시글작성을 수행하도록 명령어를 넣어준 것. */
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()"); /* 이전 페이지로 사용자를 돌려보냄. */
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}

			}
		}
		
	%>
</body>
</html>
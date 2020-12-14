<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String boardPw = request.getParameter("boardPw");
	System.out.println("param boardPw : "+boardPw);
	String boardTitle = request.getParameter("boardTitle");
	System.out.println("param boardTitle : "+boardTitle);
	String boardContent = request.getParameter("boardContent");
	System.out.println("param boardContent : "+boardContent);
	String boardUser = request.getParameter("boardUser");
	System.out.println("param boardUser : "+boardUser);
	String dbUrl = "jdbc:mariadb://localhost:3306/board";
	String dbUser = "root";
	String dbPw = "java1004";
	Connection connection = null;
	PreparedStatement statement = null;
	try {
		Class.forName("org.mariadb.jdbc.Driver");
		connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		String sql = "INSERT INTO board(board_pw, board_title, board_content, board_user, board_date) values(?,?,?,?,now())";
		statement = connection.prepareStatement(sql);
        statement.setString(1,boardPw);
        statement.setString(2,boardTitle);
        statement.setString(3,boardContent);
        statement.setString(4,boardUser);
        // insert 쿼리실행
        statement.executeUpdate();
        // boardList.jsp 이동
        response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
	} catch(Exception e) {
		e.printStackTrace();
		out.print("입력 예외 발생");
	} finally {
		try {statement.close();} catch(Exception e) {}
		try {connection.close();} catch(Exception e) {}
	}
%>
</body>
</html>
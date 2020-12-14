<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD MODIFY ACTION</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
	// boardNo, boardPw가 넘어오지않으면 리스트로
    if(request.getParameter("boardNo") == null || request.getParameter("boardPw") == null) {
        response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } else {
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        System.out.println("boardModifyAction param boardNo :"+boardNo);
        String boardPw = request.getParameter("boardPw");
        System.out.println("boardModifyAction param boardPw :"+boardPw);
        String boardTitle = request.getParameter("boardTitle");
        System.out.println("boardModifyAction param boardTitle :"+boardTitle);
        String boardContent = request.getParameter("boardContent");
        System.out.println("boardModifyAction param boardContent :"+boardContent);
        
        String dbUrl = "jdbc:mariadb://127.0.0.1:3306/board";
        String dbUser = "root";
        String dbPw = "java1004";
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
            String selectSql = "UPDATE board SET board_title=?, board_content=? WHERE board_no=? AND board_pw=?";
            statement = connection.prepareStatement(selectSql);
            statement.setString(1, boardTitle);
            statement.setString(2, boardContent);
            statement.setInt(3, boardNo);
            statement.setString(4, boardPw);
            statement.executeUpdate();
            response.sendRedirect(request.getContextPath()+"/jsp_board/boardView.jsp?boardNo="+boardNo);
        } catch(Exception e) {
            e.printStackTrace();
            out.print("BOARD MODIFY ERROR!");
        } finally {
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
    }
%>
</body>
</html>
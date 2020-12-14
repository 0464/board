<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOARD REMOVE ACTION</title>
</head>
<body>
<%
    // boardNo, boardPw값이 넘어오지 않으면 리스트로
    if(request.getParameter("boardNo") == null || request.getParameter("boardPw") == null) {
        response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } else {
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        // System.out.println("boardNo :"+boardNo);
        String boardPw = request.getParameter("boardPw");
        // System.out.println("boardPw :"+boardPw);
        String dbUrl = "jdbc:mariadb://127.0.0.1:3306/board";
        String dbUser = "root";
        String dbPw = "java1004";
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
            String sql = "DELETE FROM board WHERE board_no=? AND board_pw=?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, boardNo);
            statement.setString(2, boardPw);
            if(statement.executeUpdate()==1){
                response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
            } else {
                response.sendRedirect(request.getContextPath()+"/jsp_board/boardRemoveForm.jsp?boardNo="+boardNo);
            }
        } catch(Exception e) {
            e.printStackTrace();
            out.print("BOARD REMOVE ERROR!");
        } finally {
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
    }
%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>BOARD VIEW</title>
</head>
<body class="container">
<h1>BOARD VIEW</h1>
<%
	// boardNo가 없으면 리스트로 다시
    if(request.getParameter("boardNo") == null) {
        response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } else {
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        System.out.println("boardNo :"+boardNo);
        String dbUrl = "jdbc:mariadb://127.0.0.1:3306/board";
        String dbUser = "root";
        String dbPw = "java1004";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPw);
            String sql = "SELECT board_title, board_content, board_user, board_date FROM board WHERE board_no=?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, boardNo);
            resultSet = statement.executeQuery();
            if(resultSet.next()) {
%>
                <table class="table table-border table-hover">
                    <tbody>
                        <tr>
                            <td>board_no : </td>
                            <td><%=boardNo%></td>
                        </tr>
                        <tr>
                            <td>board_title : </td>
                            <td><%=resultSet.getString("board_title")%></td>
                        </tr>
                        <tr>
                            <td>board_content : </td>
                            <td><%=resultSet.getString("board_content")%></td>
                        </tr>
                        <tr>
                            <td>board_user : </td>
                            <td><%=resultSet.getString("board_user")%></td>
                        </tr>
                        <tr>
                            <td>board_date : </td>
                            <td><%=resultSet.getString("board_date")%></td>
                        </tr>
                    </tbody>
                </table>
                  <a class="btn btn-default" href="<%=request.getContextPath()%>/jsp_board/boardModifyForm.jsp?boardNo=<%=boardNo%>">수정</a>
                <a class="btn btn-default" href="<%=request.getContextPath()%>/jsp_board/boardRemoveForm.jsp?boardNo=<%=boardNo%>">삭제</a>
                <a class="btn btn-default" href="<%=request.getContextPath()%>/jsp_board/boardList.jsp">글목록</a>
<%
			}
        } catch(Exception e) {
            e.printStackTrace();
            out.println("BOARD VIEW ERROR!");
        } finally {
            try {resultSet.close();} catch(Exception e){}
            try {statement.close();} catch(Exception e){}
            try {connection.close();} catch(Exception e){}
        }
    }
%>
</body>
</html>
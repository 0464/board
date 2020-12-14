<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jquery CDN주소 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- 부트스트랩  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script>
    $(document).ready(function(){
        $('#removeButton').click(function(){
            if($('#boardPw').val().length <4) {
                alert('boardPw는 4자이상 이어야 합니다');
                $('#boardPw').focus();
            } else {
                $('#removeForm').submit();
            }
        });
    });
</script>
<title>BOARD REMOVE FORM</title>
</head>
<body class="container">
<%
    // boardNo가 없으면 리스트로 다시
    if(request.getParameter("boardNo") == null) {
     response.sendRedirect(request.getContextPath()+"/jsp_board/boardList.jsp");
    } else {
%>
		<form  class="form-inline" id="removeForm" action="<%=request.getContextPath()%>/jsp_board/boardRemoveAction.jsp" method="post">
            <!-- boardPw와 함께 boardNo값도 숨겨서(hidden값으로) 넘김 -->
            <input name="boardNo" value="<%=request.getParameter("boardNo")%>" type="hidden"/>
            <div class="form-group">
                <label for="boardPw">비밀번호확인 : </label>
                <input class="form-control" id="boardPw" name="boardPw" type="password">
            </div>
            <div class="form-group">
                <input class="btn btn-default" id="removeButton" type="button" value="삭제"/>
            </div>
        </form>
<%    
    }
%>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Integer userId = (Integer) session.getAttribute("user_id");
    String nickname = (String) session.getAttribute("nickname");

    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>

<h1>글쓰기</h1>

<form action="<%= request.getContextPath() %>/write" method="post">
    <p>작성자: <%= nickname %></p>

    <p>
        제목<br>
        <input type="text" name="title" required style="width:500px;">
    </p>

    <p>
        내용<br>
        <textarea name="content" rows="12" cols="70" required></textarea>
    </p>

    <button type="submit">등록</button>
    <a href="<%= request.getContextPath() %>/board/board.jsp">취소</a>
</form>

</body>
</html>
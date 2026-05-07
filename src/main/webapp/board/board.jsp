<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBUtil" %>

<%
    String nickname = (String) session.getAttribute("nickname");

    if (nickname == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>

<h1>게시판</h1>

<p><%= nickname %>님 환영합니다.</p>

<a href="<%= request.getContextPath() %>/board/write.jsp">글쓰기</a>
<a href="<%= request.getContextPath() %>/main.jsp">메인으로</a>
<a href="<%= request.getContextPath() %>/logout">로그아웃</a>

<hr>

<table border="1" width="800">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회수</th>
    </tr>

<%
    String sql = "SELECT * FROM board ORDER BY post_id DESC";

    try (
        Connection conn = DBUtil.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()
    ) {
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("post_id") %></td>
        <td>
            <a href="<%= request.getContextPath() %>/board/detail.jsp?post_id=<%= rs.getInt("post_id") %>">
                <%= rs.getString("title") %>
            </a>
        </td>
        <td><%= rs.getString("writer") %></td>
        <td><%= rs.getTimestamp("created_at") %></td>
        <td><%= rs.getInt("view_count") %></td>
    </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <tr>
        <td colspan="5">게시글을 불러오지 못했습니다.</td>
    </tr>
<%
    }
%>

</table>

</body>
</html>
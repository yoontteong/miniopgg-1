package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import util.DBUtil;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String id = request.getParameter("login_id");
        String pw = request.getParameter("password");
        String nick = request.getParameter("nickname");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String birth = request.getParameter("birthdate");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");

        try (
            Connection conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO users " +
                "(login_id, password, nickname, email, name, birthdate, gender, phone) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
            )
        ) {
            ps.setString(1, id);
            ps.setString(2, pw);
            ps.setString(3, nick);
            ps.setString(4, email);
            ps.setString(5, name);
            ps.setString(6, birth);
            ps.setString(7, gender);
            ps.setString(8, phone);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            } else {
                response.getWriter().println("<h2>회원가입 실패</h2>");
                response.getWriter().println("<a href='" + request.getContextPath() + "/user/signup.jsp'>다시 회원가입</a>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h2>오류 발생</h2>");
            response.getWriter().println("<a href='" + request.getContextPath() + "/user/signup.jsp'>다시 회원가입</a>");
        }
    }
}
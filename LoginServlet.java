package com.mangestudent.signup;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String DB_URL =
        "jdbc:mysql://localhost:3306/diffusers?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "2005";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String table = "";

        if ("admin".equals(role)) {
            table = "adminusers";
        } else if ("teacher".equals(role)) {
            table = "techusers";
        } else if ("student".equals(role)) {
            table = "stusers";
        } else {
            request.setAttribute("errorMsg", "Invalid role selected!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "SELECT * FROM " + table +
                         " WHERE username=? AND password=? AND role=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                // Redirect based on role
                if (role.equals("admin")) {
                    response.sendRedirect("adminDashboard.jsp");
                } else if (role.equals("teacher")) {
                    response.sendRedirect("teacherDashboard.jsp");
                } else if (role.equals("student")) {
                    response.sendRedirect("studentDashboard.jsp");
                }

            } else {
                request.setAttribute("errorMsg", "Invalid username or password!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

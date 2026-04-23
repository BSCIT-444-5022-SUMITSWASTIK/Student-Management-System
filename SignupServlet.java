package com.mangestudent.signup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String DB_URL =
        "jdbc:mysql://localhost:3306/diffusers?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "2005";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("fullname"); // username
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        String tableName = "";

        // Decide table based on role
        if ("admin".equalsIgnoreCase(role)) {
            tableName = "adminusers";
        } else if ("teacher".equalsIgnoreCase(role)) {
            tableName = "techusers";
        } else if ("student".equalsIgnoreCase(role)) {
            tableName = "stusers";
        } else {
            request.setAttribute("errorMsg", "Invalid role selected!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create Connection
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // SQL Insert
            String sql = "INSERT INTO " + tableName +
                         " (username, password, role) VALUES (?, ?, ?)";

            ps = con.prepareStatement(sql);
            ps.setString(1, fullname);
            ps.setString(2, password);   // Plain text (hash later)
            ps.setString(3, role);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                request.setAttribute("successMsg", "Signup successful! Please login.");
            } else {
                request.setAttribute("errorMsg", "Signup failed. Try again.");
            }

            request.getRequestDispatcher("signup.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database Error!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);

        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}


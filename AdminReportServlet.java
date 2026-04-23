package com.sms.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.sms.dao.AdminReportDAO;

@WebServlet("/AdminReportServlet")
public class AdminReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        AdminReportDAO dao = new AdminReportDAO();

        // First load → only dropdown
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("students", dao.getAllStudentNames());
            request.getRequestDispatcher("adminReport.jsp")
                   .forward(request, response);
            return;
        }

        // Report load
        request.setAttribute("students", dao.getAllStudentNames());
        request.setAttribute("student", dao.getStudent(username));
        request.setAttribute("attendanceList", dao.getAttendance(username));
        request.setAttribute("marksList", dao.getMarks(username));

        request.getRequestDispatcher("adminReport.jsp")
               .forward(request, response);
    }
}

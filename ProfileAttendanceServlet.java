package com.sms.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.sms.dao.ProfileAttendanceDAO;
import com.sms.model.ProfileAttendance;

@WebServlet("/ProfileAttendance")
public class ProfileAttendanceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentName = session.getAttribute("username").toString();

        ProfileAttendanceDAO dao = new ProfileAttendanceDAO();
        List<ProfileAttendance> attendanceList =
                dao.getAttendanceByStudent(studentName);

        request.setAttribute("attendanceList", attendanceList);
        request.getRequestDispatcher("profileAttendance.jsp")
               .forward(request, response);
    }
}

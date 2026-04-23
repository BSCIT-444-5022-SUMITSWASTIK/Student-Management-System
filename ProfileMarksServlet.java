package com.sms.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.sms.dao.ProfileMarksDAO;
import com.sms.model.ProfileMarks;

@WebServlet("/ProfileMarks")
public class ProfileMarksServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String studentName =
            session.getAttribute("username").toString();

        ProfileMarksDAO dao = new ProfileMarksDAO();
        List<ProfileMarks> marksList =
            dao.getMarksByStudent(studentName);

        request.setAttribute("marksList", marksList);
        request.getRequestDispatcher("profileMarks.jsp")
               .forward(request, response);
    }
}

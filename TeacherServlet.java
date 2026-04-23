package com.sms.controller;

import com.sms.dao.TeacherDAO;
import com.sms.model.Teacher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/TeacherServlet")
public class TeacherServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private TeacherDAO dao = new TeacherDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Teacher t = new Teacher();
            t.setTeacherName(req.getParameter("name"));
            t.setTeacherEmail(req.getParameter("email"));
            t.setTeacherContact(req.getParameter("contact"));
            dao.addTeacher(t);
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteTeacher(id);
        }

        resp.sendRedirect("manageTeachers.jsp");
    }
}

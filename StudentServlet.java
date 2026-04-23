package com.sms.controller;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private StudentDAO dao = new StudentDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        // ======================
        // ADD STUDENT
        // ======================
        if ("add".equals(action)) {

            Student s = new Student();
            s.setRollNo(Integer.parseInt(req.getParameter("roll")));
            s.setStudentName(req.getParameter("name"));
            s.setEmail(req.getParameter("email"));
            s.setContact(req.getParameter("contact"));
            s.setCourse(req.getParameter("course"));

            dao.addStudent(s);
        }

        // ======================
        // DELETE STUDENT
        // ======================
        if ("delete".equals(action)) {
            int rollNo = Integer.parseInt(req.getParameter("roll"));
            dao.deleteStudent(rollNo);
        }

        // ======================
        // REDIRECT
        // ======================
        resp.sendRedirect("manageStudents.jsp");
    }
}

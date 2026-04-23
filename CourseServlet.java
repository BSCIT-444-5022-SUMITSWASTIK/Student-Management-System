package com.sms.controller;

import com.sms.dao.CourseDAO;
import com.sms.model.Course;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/CourseServlet")
public class CourseServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CourseDAO dao = new CourseDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Course c = new Course();
            c.setCourseName(req.getParameter("name"));
            c.setCourseDuration(req.getParameter("duration"));
            c.setCourseDesc(req.getParameter("desc"));

            dao.addCourse(c);
        }
        else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteCourse(id);
        }

        resp.sendRedirect("manageCourses.jsp");
    }
}


package com.sms.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.sms.dao.SubjectAssignDAO;
import com.sms.model.SubjectAssign;

@WebServlet("/SubjectAssignServlet")
public class SubjectAssignServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        SubjectAssignDAO dao = new SubjectAssignDAO();
        String action = req.getParameter("action");

        if ("assign".equals(action)) {
            SubjectAssign s = new SubjectAssign();
            s.setTeacherName(req.getParameter("teacher"));
            s.setCourseName(req.getParameter("course"));
            s.setSubjectName(req.getParameter("subject"));
            dao.assignSubject(s);
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteAssignment(id);
        }

        resp.sendRedirect("assignSubjects.jsp");
    }
}

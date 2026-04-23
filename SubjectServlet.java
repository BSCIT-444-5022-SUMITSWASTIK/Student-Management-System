package com.sms.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.sms.dao.SubjectDAO;

@WebServlet("/SubjectServlet")
public class SubjectServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String subjectName = req.getParameter("subject");

        if (subjectName != null && !subjectName.trim().isEmpty()) {
            SubjectDAO dao = new SubjectDAO();
            dao.addSubject(subjectName.trim());
        }

        resp.sendRedirect(req.getContextPath() + "/manageSubjects.jsp?success=1");
    }
}

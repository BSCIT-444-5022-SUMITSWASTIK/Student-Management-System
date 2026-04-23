package com.sms.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.sms.dao.MarksDAO;
import com.sms.model.Marks;

@WebServlet("/MarksServlet")
public class MarksServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String subject = req.getParameter("subject");
        String[] rollNos = req.getParameterValues("rollNo[]");
        String[] names = req.getParameterValues("name[]");
        String[] marksArr = req.getParameterValues("marks[]");

        MarksDAO dao = new MarksDAO();

        for (int i = 0; i < rollNos.length; i++) {
            Marks m = new Marks();
            m.setRollNo(rollNos[i]);
            m.setStudentName(names[i]);
            m.setSubjectName(subject);
            m.setMarks(Integer.parseInt(marksArr[i]));

            dao.saveMarks(m);
        }

        resp.sendRedirect(req.getContextPath() + "/enterMarks.jsp?success=1");
    }
}

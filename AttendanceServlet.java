package com.sms.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.sms.dao.AttendanceDAO;
import com.sms.model.Attendance;

@WebServlet("/AttendanceServlet")
public class AttendanceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String dateStr = req.getParameter("date");
        String subName = req.getParameter("sub_name");

        String[] rollNos = req.getParameterValues("rollNo[]");
        String[] studentNames = req.getParameterValues("studentName[]");
        String[] statuses = req.getParameterValues("status[]");

        Date attendanceDate = Date.valueOf(dateStr);

        AttendanceDAO dao = new AttendanceDAO();

        for (int i = 0; i < rollNos.length; i++) {

            Attendance a = new Attendance();
            a.setRollNo(rollNos[i]);
            a.setStudentName(studentNames[i]);
            a.setStatus(statuses[i]);
            a.setAttendanceDate(attendanceDate);
            a.setSubName(subName);

            dao.saveAttendance(a);
        }

        resp.sendRedirect(req.getContextPath()
            + "/markAttendance.jsp?success=1");
    }
}

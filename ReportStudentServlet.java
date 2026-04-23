package com.sms.controller;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.sms.model.*;

@WebServlet("/ReportStudent")
public class ReportStudentServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/admindb",
            "root",
            "2005"
        );
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try (Connection con = getConnection()) {

            /* ========= STUDENT ========= */
            ReportStudent student = null;
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT * FROM mngstudent WHERE studentname=?"
            );
            ps1.setString(1, username);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                student = new ReportStudent();
                student.setRollno(rs1.getString("rollno"));
                student.setStudentname(rs1.getString("studentname"));
                student.setCourse(rs1.getString("course"));
                student.setEmail(rs1.getString("email"));
            }

            /* ========= ATTENDANCE ========= */
            List<ReportAttendance> attendanceList = new ArrayList<>();
            PreparedStatement ps2 = con.prepareStatement(
                "SELECT attendance_date, sub_name, status FROM attendance WHERE studentname=?"
            );
            ps2.setString(1, username);
            ResultSet rs2 = ps2.executeQuery();

            while (rs2.next()) {
                ReportAttendance a = new ReportAttendance();
                a.setAttendanceDate(rs2.getDate("attendance_date"));
                a.setSubName(rs2.getString("sub_name"));
                a.setStatus(rs2.getString("status"));
                attendanceList.add(a);
            }

            /* ========= MARKS ========= */
            List<ReportMarks> marksList = new ArrayList<>();
            PreparedStatement ps3 = con.prepareStatement(
                "SELECT subject_name, marks FROM marks WHERE student_name=?"
            );
            ps3.setString(1, username);
            ResultSet rs3 = ps3.executeQuery();

            while (rs3.next()) {
                ReportMarks m = new ReportMarks();
                m.setSubjectName(rs3.getString("subject_name"));
                m.setMarks(rs3.getInt("marks"));
                marksList.add(m);
            }

            req.setAttribute("student", student);
            req.setAttribute("attendanceList", attendanceList);
            req.setAttribute("marksList", marksList);

            req.getRequestDispatcher("reportStudent.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("studentDashboard.jsp");
        }
    }
}

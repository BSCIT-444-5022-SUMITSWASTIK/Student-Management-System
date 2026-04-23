package com.sms.dao;

import java.sql.*;
import java.util.*;
import com.sms.model.*;

public class AdminReportDAO {

    Connection con;

    public AdminReportDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/admindb",
                "root",
                "2005"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 🔹 Student List (for dropdown)
    public List<String> getAllStudentNames() {
        List<String> list = new ArrayList<>();
        try {
            PreparedStatement ps =
                con.prepareStatement("select studentname from mngstudent");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("studentname"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🔹 Student Profile
    public AdminReportStudent getStudent(String username) {
        AdminReportStudent s = null;
        try {
            PreparedStatement ps =
                con.prepareStatement(
                    "select studentname, rollno, course, email from mngstudent where studentname=?"
                );
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                s = new AdminReportStudent();
                s.setStudentname(rs.getString("studentname"));
                s.setRollno(rs.getString("rollno"));
                s.setCourse(rs.getString("course"));
                s.setEmail(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    // 🔹 Attendance
    public List<AdminReportAttendance> getAttendance(String username) {
        List<AdminReportAttendance> list = new ArrayList<>();
        try {
            PreparedStatement ps =
                con.prepareStatement(
                    "select attendance_date, sub_name, status from attendance where studentname=?"
                );
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AdminReportAttendance a = new AdminReportAttendance();
                a.setAttendanceDate(rs.getString("attendance_date"));
                a.setSubName(rs.getString("sub_name"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🔹 Marks
    public List<AdminReportMarks> getMarks(String username) {
        List<AdminReportMarks> list = new ArrayList<>();
        try {
            PreparedStatement ps =
                con.prepareStatement(
                    "select subject_name, marks from marks where student_name=?"
                );
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AdminReportMarks m = new AdminReportMarks();
                m.setSubjectName(rs.getString("subject_name"));
                m.setMarks(rs.getInt("marks"));
                list.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

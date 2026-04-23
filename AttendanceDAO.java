package com.sms.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.sms.model.Attendance;

public class AttendanceDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/admindb",
            "root",
            "2005"
        );
    }

    // 🔹 Get subjects for dropdown
    public List<String> getAllSubjects() {

        List<String> subjects = new ArrayList<>();
        String sql = "SELECT sub_name FROM subjects";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                subjects.add(rs.getString("sub_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return subjects;
    }

    // 🔹 Save attendance with subject & student name
    public void saveAttendance(Attendance a) {

        String sql =
          "INSERT INTO attendance " +
          "(roll_no, attendance_date, status, studentname, sub_name) " +
          "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, a.getRollNo());
            ps.setDate(2, a.getAttendanceDate());
            ps.setString(3, a.getStatus());
            ps.setString(4, a.getStudentName());
            ps.setString(5, a.getSubName());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

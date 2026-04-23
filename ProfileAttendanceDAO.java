package com.sms.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.sms.model.ProfileAttendance;

public class ProfileAttendanceDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/admindb",
            "root",
            "2005"
        );
    }

    public List<ProfileAttendance> getAttendanceByStudent(String studentName) {

        List<ProfileAttendance> list = new ArrayList<>();

        String sql =
            "SELECT attendance_date, sub_name, status " +
            "FROM attendance WHERE studentname = ? " +
            "ORDER BY attendance_date DESC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, studentName);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProfileAttendance a = new ProfileAttendance();
                a.setAttendanceDate(rs.getDate("attendance_date"));
                a.setSubName(rs.getString("sub_name"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}

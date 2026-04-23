package com.sms.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.sms.model.ProfileMarks;

public class ProfileMarksDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/admindb",
            "root",
            "2005"
        );
    }

    public List<ProfileMarks> getMarksByStudent(String studentName) {

        List<ProfileMarks> list = new ArrayList<>();

        String sql =
            "SELECT subject_name, marks " +
            "FROM marks WHERE student_name = ?";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, studentName);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProfileMarks m = new ProfileMarks();
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

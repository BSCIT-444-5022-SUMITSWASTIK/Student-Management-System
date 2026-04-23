package com.sms.dao;

import java.sql.*;
import java.util.*;
import com.sms.model.Subject;

public class SubjectDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/admindb",
            "root",
            "2005"
        );
    }

    /* Insert subject */
    public void addSubject(String subjectName) {
        String sql = "INSERT INTO subjects(sub_name) VALUES(?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, subjectName);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* Fetch all subjects */
    public List<Subject> getAllSubjects() {
        List<Subject> list = new ArrayList<>();
        String sql = "SELECT * FROM subjects ORDER BY sub_name";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Subject s = new Subject();
                s.setSubjectId(rs.getInt("sub_id"));
                s.setSubjectName(rs.getString("sub_name"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

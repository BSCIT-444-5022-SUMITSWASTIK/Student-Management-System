package com.sms.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.sms.model.ProfileStudent;

public class ProfileStudentDAO {

    private static final String URL =
        "jdbc:mysql://localhost:3306/admindb";
    private static final String USER = "root";
    private static final String PASS = "2005";

    public ProfileStudent getStudentByUsername(String username) {

        ProfileStudent student = null;

        String sql =
            "SELECT rollno, studentname, email, contact, course " +
            "FROM mngstudent WHERE studentname = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, USER, PASS);

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                student = new ProfileStudent();
                student.setRollno(rs.getInt("rollno"));
                student.setStudentname(rs.getString("studentname"));
                student.setEmail(rs.getString("email"));
                student.setContact(rs.getString("contact"));
                student.setCourse(rs.getString("course"));
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return student;
    }
}

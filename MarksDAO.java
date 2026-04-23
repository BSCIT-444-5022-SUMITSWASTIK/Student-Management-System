package com.sms.dao;

import java.sql.*;
import java.util.*;

import com.sms.model.Marks;
import com.sms.model.Student;

public class MarksDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/admindb",
            "root",
            "2005"
        );
    }

    /* Fetch subjects for dropdown */
    public List<String> getSubjects() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT sub_name FROM subjects";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(rs.getString("sub_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /* Fetch students */
    public List<Student> getStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT rollno, studentname FROM mngstudent";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Student s = new Student();
                s.setRollNo(rs.getInt("rollno"));
                s.setStudentName(rs.getString("studentname"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /* Save marks */
    public void saveMarks(Marks m) {
        String sql = "INSERT INTO marks (roll_no, student_name, subject_name, marks) VALUES (?,?,?,?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, m.getRollNo());
            ps.setString(2, m.getStudentName());
            ps.setString(3, m.getSubjectName());
            ps.setInt(4, m.getMarks());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

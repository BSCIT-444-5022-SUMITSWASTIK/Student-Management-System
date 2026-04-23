package com.sms.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.sms.model.Student;
import com.sms.util.DBConnection;

public class StudentDAO {

    // ===============================
    // ADD STUDENT
    // ===============================
    public void addStudent(Student s) {

        String sql = "INSERT INTO mngstudent (rollno, studentname, email, contact, course) VALUES (?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, s.getRollNo());
            ps.setString(2, s.getStudentName());
            ps.setString(3, s.getEmail());
            ps.setString(4, s.getContact());
            ps.setString(5, s.getCourse());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ===============================
    // FETCH ALL STUDENTS
    // ===============================
    public List<Student> getAllStudents() {

        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM mngstudent";

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Student s = new Student();
                s.setRollNo(rs.getInt("rollno"));
                s.setStudentName(rs.getString("studentname"));
                s.setEmail(rs.getString("email"));
                s.setContact(rs.getString("contact"));
                s.setCourse(rs.getString("course"));

                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===============================
    // DELETE STUDENT
    // ===============================
    public void deleteStudent(int rollNo) {

        String sql = "DELETE FROM mngstudent WHERE rollno=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, rollNo);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

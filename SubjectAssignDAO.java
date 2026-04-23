package com.sms.dao;

import java.sql.*;
import java.util.*;
import com.sms.model.SubjectAssign;

public class SubjectAssignDAO {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/admindb", "root", "2005");
    }

    /* Dropdown Data */
    public List<String> getTeachers() {
        List<String> list = new ArrayList<>();
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT teacher_name FROM mngteachers")) {
            while (rs.next()) list.add(rs.getString(1));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<String> getCourses() {
        List<String> list = new ArrayList<>();
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT course_name FROM mngcourses")) {
            while (rs.next()) list.add(rs.getString(1));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<String> getSubjects() {
        List<String> list = new ArrayList<>();
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT sub_name FROM subjects")) {
            while (rs.next()) list.add(rs.getString(1));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    /* Insert */
    public void assignSubject(SubjectAssign s) {
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(
               "INSERT INTO subject_assign(teacher_name,course_name,subject_name) VALUES(?,?,?)")) {
            ps.setString(1, s.getTeacherName());
            ps.setString(2, s.getCourseName());
            ps.setString(3, s.getSubjectName());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    /* Fetch */
    public List<SubjectAssign> getAllAssignments() {
        List<SubjectAssign> list = new ArrayList<>();
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM subject_assign")) {

            while (rs.next()) {
                SubjectAssign s = new SubjectAssign();
                s.setAssignId(rs.getInt("assign_id"));
                s.setTeacherName(rs.getString("teacher_name"));
                s.setCourseName(rs.getString("course_name"));
                s.setSubjectName(rs.getString("subject_name"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    /* Delete */
    public void deleteAssignment(int id) {
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(
               "DELETE FROM subject_assign WHERE assign_id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}

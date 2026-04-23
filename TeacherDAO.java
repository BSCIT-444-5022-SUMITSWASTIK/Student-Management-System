package com.sms.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.sms.model.Teacher;
import com.sms.util.DBConnection;

public class TeacherDAO {

    // ADD TEACHER
    public void addTeacher(Teacher t) {
        String sql = "INSERT INTO mngteachers(teacher_name, teacher_email, teacher_contact) VALUES (?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, t.getTeacherName());
            ps.setString(2, t.getTeacherEmail());
            ps.setString(3, t.getTeacherContact());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // FETCH ALL TEACHERS
    public List<Teacher> getAllTeachers() {
        List<Teacher> list = new ArrayList<>();
        String sql = "SELECT * FROM mngteachers";

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Teacher t = new Teacher();
                t.setTeacherId(rs.getInt("teacher_id"));
                t.setTeacherName(rs.getString("teacher_name"));
                t.setTeacherEmail(rs.getString("teacher_email"));
                t.setTeacherContact(rs.getString("teacher_contact"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // DELETE TEACHER
    public void deleteTeacher(int id) {
        String sql = "DELETE FROM mngteachers WHERE teacher_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

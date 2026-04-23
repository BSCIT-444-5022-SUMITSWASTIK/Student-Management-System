package com.sms.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.sms.model.Course;
import com.sms.util.DBConnection;

public class CourseDAO {

    // INSERT
    public boolean addCourse(Course c) {
        String sql = "INSERT INTO mngcourses(course_name, course_duration, course_desc) VALUES (?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getCourseName());
            ps.setString(2, c.getCourseDuration());
            ps.setString(3, c.getCourseDesc());
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // FETCH ALL
    public List<Course> getAllCourses() {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT * FROM mngcourses";

        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Course c = new Course();
                c.setCourseId(rs.getInt("course_id"));
                c.setCourseName(rs.getString("course_name"));
                c.setCourseDuration(rs.getString("course_duration"));
                c.setCourseDesc(rs.getString("course_desc"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // DELETE
    public void deleteCourse(int id) {
        String sql = "DELETE FROM mngcourses WHERE course_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

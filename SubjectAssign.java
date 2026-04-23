package com.sms.model;

public class SubjectAssign {

    private int assignId;
    private String teacherName;
    private String courseName;
    private String subjectName;

    public int getAssignId() {
        return assignId;
    }
    public void setAssignId(int assignId) {
        this.assignId = assignId;
    }

    public String getTeacherName() {
        return teacherName;
    }
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getCourseName() {
        return courseName;
    }
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getSubjectName() {
        return subjectName;
    }
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
}

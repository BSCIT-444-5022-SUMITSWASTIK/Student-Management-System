package com.sms.model;

public class Teacher {

    private int teacherId;
    private String teacherName;
    private String teacherEmail;
    private String teacherContact;

    public int getTeacherId() {
        return teacherId;
    }
    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTeacherEmail() {
        return teacherEmail;
    }
    public void setTeacherEmail(String teacherEmail) {
        this.teacherEmail = teacherEmail;
    }

    public String getTeacherContact() {
        return teacherContact;
    }
    public void setTeacherContact(String teacherContact) {
        this.teacherContact = teacherContact;
    }
}

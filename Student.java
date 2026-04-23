package com.sms.model;

public class Student {

    private int rollNo;
    private String studentName;
    private String email;
    private String contact;
    private String course;

    public int getRollNo() {
        return rollNo;
    }
    public void setRollNo(int rollNo) {
        this.rollNo = rollNo;
    }

    public String getStudentName() {
        return studentName;
    }
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getContact() {
        return contact;
    }
    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getCourse() {
        return course;
    }
    public void setCourse(String course) {
        this.course = course;
    }
}

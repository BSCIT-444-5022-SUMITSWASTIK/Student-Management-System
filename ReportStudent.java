package com.sms.model;

public class ReportStudent {

    private String rollno;
    private String studentname;
    private String course;
    private String email;

    public String getRollno() {
        return rollno;
    }
    public void setRollno(String rollno) {
        this.rollno = rollno;
    }

    public String getStudentname() {
        return studentname;
    }
    public void setStudentname(String studentname) {
        this.studentname = studentname;
    }

    public String getCourse() {
        return course;
    }
    public void setCourse(String course) {
        this.course = course;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
}

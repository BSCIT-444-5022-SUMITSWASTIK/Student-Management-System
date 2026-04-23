package com.sms.model;

import java.sql.Date;

public class Attendance {

    private String rollNo;
    private String studentName;
    private String subName;
    private Date attendanceDate;
    private String status;

    public String getRollNo() {
        return rollNo;
    }
    public void setRollNo(String rollNo) {
        this.rollNo = rollNo;
    }

    public String getStudentName() {
        return studentName;
    }
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getSubName() {
        return subName;
    }
    public void setSubName(String subName) {
        this.subName = subName;
    }

    public Date getAttendanceDate() {
        return attendanceDate;
    }
    public void setAttendanceDate(Date attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}

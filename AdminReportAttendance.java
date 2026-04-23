package com.sms.model;

public class AdminReportAttendance {
    private String attendanceDate;
    private String subName;
    private String status;

    public String getAttendanceDate() {
        return attendanceDate;
    }
    public void setAttendanceDate(String attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    public String getSubName() {
        return subName;
    }
    public void setSubName(String subName) {
        this.subName = subName;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}

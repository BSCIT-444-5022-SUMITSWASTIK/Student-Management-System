package com.sms.model;

import java.sql.Date;

public class ReportAttendance {

    private Date attendanceDate;
    private String subName;
    private String status;

    public Date getAttendanceDate() {
        return attendanceDate;
    }
    public void setAttendanceDate(Date attendanceDate) {
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

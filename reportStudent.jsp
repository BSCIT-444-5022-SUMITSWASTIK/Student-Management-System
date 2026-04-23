<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
}
%>
<%@ page import="java.util.*" %>
<%@ page import="com.sms.model.ReportStudent" %>
<%@ page import="com.sms.model.ReportAttendance" %>
<%@ page import="com.sms.model.ReportMarks" %>

<%
    ReportStudent student =
        (ReportStudent) request.getAttribute("student");

    List<ReportAttendance> attendanceList =
        (List<ReportAttendance>) request.getAttribute("attendanceList");

    List<ReportMarks> marksList =
        (List<ReportMarks>) request.getAttribute("marksList");

    int presentCount = 0, totalCount = 0;
    if(attendanceList != null){
        totalCount = attendanceList.size();
        for(ReportAttendance a : attendanceList){
            if("Present".equalsIgnoreCase(a.getStatus())) presentCount++;
        }
    }
    double attendancePercent = totalCount == 0 ? 0 : (presentCount * 100.0 / totalCount);

    int totalMarks = 0, subjectCount = 0;
    if(marksList != null){
        for(ReportMarks m : marksList){ totalMarks += m.getMarks(); subjectCount++; }
    }
    double avgMarks = subjectCount == 0 ? 0 : (totalMarks * 1.0 / subjectCount);
    String grade;
    if(avgMarks >= 85) grade="A";
    else if(avgMarks >= 70) grade="B";
    else if(avgMarks >= 50) grade="C";
    else if(avgMarks >= 35) grade="D";
    else grade="Fail";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Student Report</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.29/jspdf.plugin.autotable.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
*{ box-sizing:border-box; margin:0; padding:0; font-family:"Segoe UI",Tahoma,sans-serif; }
body{ background:#f4f6ff; color:#333; }

/* Wrapper */
.wrapper{ display:flex; min-height:100vh; }

/* Sidebar */
.sidebar{
    width:220px;
    background:#4338ca;
    color:white;
    padding:20px;
}
.sidebar h2{ text-align:center; margin-bottom:30px; }
.sidebar a{
    display:block;
    padding:12px 15px;
    color:white;
    text-decoration:none;
    border-radius:8px;
    margin-bottom:10px;
    transition:0.3s;
}
.sidebar a:hover, .sidebar a.active{ background:#3730a3; }

/* Main content */
.main{ flex:1; padding:30px; }

/* Container sections */
.container{
    background:#fff;
    padding:25px;
    border-radius:12px;
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
    margin-bottom:30px;
}
h2,h3{ text-align:center; color:#4338ca; margin-bottom:20px; }
.profile-row{ display:flex; justify-content:space-between; padding:10px 0; border-bottom:1px solid #eee; font-weight:600; }

/* Tables */
table{ width:100%; border-collapse:collapse; margin-top:15px; }
th,td{ border:1px solid #ddd; padding:12px; text-align:center; }
th{ background:#667eea; color:white; }
tr:nth-child(even){ background:#f8f9ff; }

/* Buttons */
.btn{ margin-top:20px; width:100%; padding:12px; border:none; border-radius:6px; cursor:pointer; font-size:15px; }
.pdf-btn{ background:#28a745; color:white; }
.pdf-btn:hover{ background:#218838; }
.back-btn{ background:#007bff; color:white; }
.back-btn:hover{ background:#4338ca; }
</style>
</head>

<body>
<div class="wrapper">
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>👨‍🎓 Student</h2>
        <a href="studentDashboard.jsp"><i class="fa fa-home"></i> Dashboard</a>
        <a href="ProfileStudent"><i class="fa fa-user"></i> Profile</a>
        <a href="ProfileAttendance"><i class="fa fa-calendar-check"></i> Attendance</a>
        <a href="ProfileMarks"><i class="fa fa-pen"></i> Marks</a>
        <a href="ReportStudent" class="active"><i class="fa fa-file-alt"></i> Report</a>
        <form action="LogoutServlet" method="post" style="margin-top:20px;">
            <button type="submit" class="back-btn"><i class="fa fa-sign-out-alt"></i> Logout</button>
        </form>
    </div>

    <!-- Main content -->
    <div class="main">

        <!-- Student Details -->
        <div class="container">
            <h2>🎓 Student Academic Report</h2>
            <% if(student != null){ %>
                <div class="profile-row"><span>Name:</span><span id="sname"><%= student.getStudentname() %></span></div>
                <div class="profile-row"><span>Roll No:</span><span id="roll"><%= student.getRollno() %></span></div>
                <div class="profile-row"><span>Course:</span><span><%= student.getCourse() %></span></div>
                <div class="profile-row"><span>Email:</span><span><%= student.getEmail() %></span></div>
            <% } %>
        </div>

        <!-- Attendance -->
        <div class="container">
            <h3>📊 Attendance ( <%= String.format("%.2f", attendancePercent) %>% )</h3>
            <table id="attendanceTable">
                <tr>
                    <th>Date</th>
                    <th>Subject</th>
                    <th>Status</th>
                </tr>
                <% if(attendanceList != null && !attendanceList.isEmpty()){
                    for(ReportAttendance a : attendanceList){ %>
                    <tr>
                        <td><%= a.getAttendanceDate() %></td>
                        <td><%= a.getSubName() %></td>
                        <td><%= a.getStatus() %></td>
                    </tr>
                <% } } else { %>
                    <tr><td colspan="3">No attendance records</td></tr>
                <% } %>
            </table>
        </div>

        <!-- Marks -->
        <div class="container">
            <h3>🧮 Marks ( Grade: <%= grade %> )</h3>
            <table id="marksTable">
                <tr>
                    <th>Subject</th>
                    <th>Marks</th>
                </tr>
                <% if(marksList != null && !marksList.isEmpty()){
                    for(ReportMarks m : marksList){ %>
                    <tr>
                        <td><%= m.getSubjectName() %></td>
                        <td><%= m.getMarks() %></td>
                    </tr>
                <% } } else { %>
                    <tr><td colspan="2">No marks records</td></tr>
                <% } %>
            </table>
        </div>

        <button class="btn pdf-btn" onclick="downloadPDF()">📄 Download PDF</button>
        <button class="btn back-btn" onclick="location.href='studentDashboard.jsp'">⬅ Back to Dashboard</button>

    </div>
</div>

<script>
function downloadPDF(){
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    const name = document.getElementById("sname").innerText;
    const roll = document.getElementById("roll").innerText;

    doc.setFontSize(16);
    doc.text("Student Academic Report",14,15);
    doc.setFontSize(11);
    doc.text("Name: " + name,14,25);
    doc.text("Roll No: " + roll,14,32);

    doc.autoTable({ startY:40, html:"#attendanceTable" });
    doc.autoTable({ startY:doc.lastAutoTable.finalY+10, html:"#marksTable" });

    doc.save(roll + "_" + name + "_Report.pdf");
}
</script>

</body>
</html>

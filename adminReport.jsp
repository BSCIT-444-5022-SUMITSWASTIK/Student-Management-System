<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.sms.model.*" %>

<%
AdminReportStudent student =
    (AdminReportStudent) request.getAttribute("student");

List<AdminReportAttendance> attendanceList =
    (List<AdminReportAttendance>) request.getAttribute("attendanceList");

List<AdminReportMarks> marksList =
    (List<AdminReportMarks>) request.getAttribute("marksList");

int total = 0, present = 0;
if (attendanceList != null) {
    for (AdminReportAttendance a : attendanceList) {
        total++;
        if ("Present".equalsIgnoreCase(a.getStatus())) present++;
    }
}
int attendancePercent = total == 0 ? 0 : (present * 100 / total);

int totalMarks = 0;
if (marksList != null) {
    for (AdminReportMarks m : marksList) totalMarks += m.getMarks();
}
int avg = (marksList == null || marksList.size() == 0) ? 0 : totalMarks / marksList.size();

String grade =
    avg >= 90 ? "A+" :
    avg >= 80 ? "A" :
    avg >= 70 ? "B" :
    avg >= 60 ? "C" : "Fail";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Student Report</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    background:#f4f6fb;
    font-family:"Segoe UI",sans-serif;
}
.card{
    border-radius:14px;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
}
.stat-card{
    text-align:center;
    padding:20px;
    font-weight:600;
}
.stat-card i{
    font-size:28px;
    margin-bottom:8px;
}
</style>
</head>

<body>

<div class="container py-4">

<h3 class="text-center mb-4 text-primary">
    <i class="fa fa-chart-line"></i> Student Performance Report (Admin)
</h3>

<!-- Student Selector -->
<div class="card mb-4 p-3">
<form class="row g-3 justify-content-center" method="get" action="AdminReportServlet">
    <div class="col-md-4">
        <select name="username" class="form-select" required>
            <option value="">-- Select Student --</option>
            <%
            List<String> students = (List<String>) request.getAttribute("students");
            if (students != null) {
                for (String s : students) {
            %>
            <option value="<%= s %>"><%= s %></option>
            <% }} %>
        </select>
    </div>
    <div class="col-md-2">
        <button class="btn btn-primary w-100">
            <i class="fa fa-search"></i> View
        </button>
    </div>
</form>
</div>

<% if (student != null) { %>

<!-- Profile -->
<div class="card mb-4 p-4">
<h5 class="mb-3"><i class="fa fa-user"></i> Student Profile</h5>
<div class="row">
    <div class="col-md-3"><b>Name:</b><br><%= student.getStudentname() %></div>
    <div class="col-md-3"><b>Roll No:</b><br><%= student.getRollno() %></div>
    <div class="col-md-3"><b>Course:</b><br><%= student.getCourse() %></div>
    <div class="col-md-3"><b>Email:</b><br><%= student.getEmail() %></div>
</div>
</div>

<!-- Summary Cards -->
<div class="row mb-4">
    <div class="col-md-4">
        <div class="card stat-card text-success">
            <i class="fa fa-calendar-check"></i>
            Attendance<br>
            <span class="fs-4"><%= attendancePercent %>%</span>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card stat-card text-primary">
            <i class="fa fa-chart-bar"></i>
            Average Marks<br>
            <span class="fs-4"><%= avg %></span>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card stat-card text-warning">
            <i class="fa fa-award"></i>
            Grade<br>
            <span class="fs-4"><%= grade %></span>
        </div>
    </div>
</div>

<!-- Attendance Table -->
<div class="card mb-4 p-3">
<h5><i class="fa fa-list"></i> Attendance Details</h5>
<table class="table table-bordered table-hover mt-2">
<tr class="table-primary">
<th>Date</th><th>Subject</th><th>Status</th>
</tr>
<% for (AdminReportAttendance a : attendanceList) { %>
<tr>
<td><%= a.getAttendanceDate() %></td>
<td><%= a.getSubName() %></td>
<td><%= a.getStatus() %></td>
</tr>
<% } %>
</table>
</div>

<!-- Marks Table -->
<div class="card mb-4 p-3">
<h5><i class="fa fa-pen"></i> Marks Details</h5>
<table class="table table-bordered table-hover mt-2">
<tr class="table-primary">
<th>Subject</th><th>Marks</th>
</tr>
<% for (AdminReportMarks m : marksList) { %>
<tr>
<td><%= m.getSubjectName() %></td>
<td><%= m.getMarks() %></td>
</tr>
<% } %>
</table>
</div>

<!-- Charts -->
<div class="row mb-4">
    <div class="col-md-6">
        <div class="card p-3">
            <canvas id="attendanceChart"></canvas>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card p-3">
            <canvas id="marksChart"></canvas>
        </div>
    </div>
</div>

<script>
new Chart(document.getElementById("attendanceChart"),{
    type:'doughnut',
    data:{
        labels:['Present','Absent'],
        datasets:[{ data:[<%= present %>,<%= total-present %>] }]
    }
});

new Chart(document.getElementById("marksChart"),{
    type:'bar',
    data:{
        labels:[
            <% for(AdminReportMarks m:marksList){ %>
            "<%= m.getSubjectName() %>",
            <% } %>
        ],
        datasets:[{
            label:'Marks',
            data:[
                <% for(AdminReportMarks m:marksList){ %>
                <%= m.getMarks() %>,
                <% } %>
            ]
        }]
    },
    options:{ scales:{ y:{ beginAtZero:true } } }
});
</script>

<% } %>

<div class="text-center mt-3">
<button class="btn btn-secondary"
onclick="location.href='adminDashboard.jsp'">
<i class="fa fa-arrow-left"></i> Back to Dashboard
</button>
</div>

</div>
</body>
</html>

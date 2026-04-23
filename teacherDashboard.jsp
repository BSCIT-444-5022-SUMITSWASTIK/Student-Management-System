<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
    return;
}

String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");

if (!"teacher".equals(role)) {
    response.sendRedirect("login.jsp");
    return;
}

/* ================= REAL DB STATS ================= */
int totalSubjects = 0;
int totalStudents = 0;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/admindb","root","2005");

    // Count assigned subjects
    PreparedStatement ps1 = con.prepareStatement(
        "SELECT COUNT(*) FROM subject_assign WHERE teacher_name=?");
    ps1.setString(1, username);
    ResultSet rs1 = ps1.executeQuery();
    if(rs1.next()) totalSubjects = rs1.getInt(1);

    // Count students from assigned courses
    PreparedStatement ps2 = con.prepareStatement(
        "SELECT COUNT(*) FROM mngstudent WHERE course IN " +
        "(SELECT DISTINCT course_name FROM subject_assign WHERE teacher_name=?)");
    ps2.setString(1, username);
    ResultSet rs2 = ps2.executeQuery();
    if(rs2.next()) totalStudents = rs2.getInt(1);

    con.close();
}catch(Exception e){
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Teacher Dashboard</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body{
    font-family:"Segoe UI",sans-serif;
    background:#f4f6fb;
}

/* Sidebar */
.sidebar{
    width:260px;
    height:100vh;
    position:fixed;
    background:#1f2937;
    color:white;
    padding:20px;
}
.sidebar h4{
    text-align:center;
    margin-bottom:30px;
}
.sidebar a{
    display:block;
    color:#d1d5db;
    padding:12px;
    border-radius:8px;
    text-decoration:none;
    margin-bottom:6px;
}
.sidebar a:hover{
    background:#374151;
    color:white;
}

/* Main */
.main{
    margin-left:270px;
    padding:30px;
}

/* Cards */
.stat-card{
    border-radius:16px;
    padding:25px;
    text-align:center;
    box-shadow:0 10px 25px rgba(0,0,0,0.1);
}
.stat-card i{
    font-size:32px;
    margin-bottom:10px;
}

/* Dark Mode */
.dark{
    background:#020617;
    color:white;
}
.dark .stat-card,
.dark .card{
    background:#1f2937;
    color:white;
}
.dark .sidebar{
    background:#020617;
}
</style>
</head>

<body id="body">

<!-- SIDEBAR -->
<div class="sidebar">
    <h4><i class="fa fa-chalkboard-teacher"></i> Teacher Panel</h4>

    <a href="teacherDashboard.jsp"><i class="fa fa-home"></i> Dashboard</a>
    <a href="teacherProfile.jsp"><i class="fa fa-user"></i> My Profile</a>
    <a href="markAttendance.jsp"><i class="fa fa-calendar-check"></i> Attendance</a>
    <a href="enterMarks.jsp"><i class="fa fa-pen"></i> Enter Marks</a>
    <a href="ViewStudents.jsp"><i class="fa fa-user-graduate"></i> Students</a>

    <a href="#" onclick="toggleDark()">
        <i class="fa fa-moon"></i> Dark Mode
    </a>

    <form action="LogoutServlet" method="post">
        <button class="btn btn-danger w-100 mt-3">
            <i class="fa fa-sign-out-alt"></i> Logout
        </button>
    </form>
</div>

<!-- MAIN CONTENT -->
<div class="main">

<h3 class="mb-4">
    Welcome, <b><%= username %></b>
</h3>

<!-- STATS -->
<div class="row g-4 mb-4">

    <div class="col-md-6">
        <div class="stat-card bg-primary text-white">
            <i class="fa fa-book"></i><br>
            Assigned Subjects<br>
            <span class="fs-3"><%= totalSubjects %></span>
        </div>
    </div>

    <div class="col-md-6">
        <div class="stat-card bg-success text-white">
            <i class="fa fa-user-graduate"></i><br>
            Assigned Students<br>
            <span class="fs-3"><%= totalStudents %></span>
        </div>
    </div>

</div>

<!-- QUICK ACTIONS -->
<div class="card p-4">
<h5>Quick Actions</h5>

<div class="row g-3">
    <div class="col-md-4">
        <a href="markAttendance.jsp" class="btn btn-outline-primary w-100">
            <i class="fa fa-calendar-check"></i> Attendance
        </a>
    </div>
    <div class="col-md-4">
        <a href="enterMarks.jsp" class="btn btn-outline-success w-100">
            <i class="fa fa-pen"></i> Enter Marks
        </a>
    </div>
    <div class="col-md-4">
        <a href="ViewStudents.jsp" class="btn btn-outline-info w-100">
            <i class="fa fa-users"></i> Students
        </a>
    </div>
</div>

</div>

</div>

<script>
function toggleDark(){
    document.getElementById("body").classList.toggle("dark");
}
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
    return;
}

String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");

if(!"teacher".equals(role)){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Teacher Profile</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<style>
body{
    font-family:"Segoe UI",sans-serif;
    background:#f4f6fb;
}
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
.main{
    margin-left:270px;
    padding:30px;
}
.profile-card{
    border-radius:16px;
    box-shadow:0 12px 30px rgba(0,0,0,0.15);
}
.dark{
    background:#020617;
    color:white;
}
.dark .card,
.dark table{
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

<!-- MAIN -->
<div class="main">

<h3 class="mb-4"><i class="fa fa-user"></i> Teacher Profile</h3>

<!-- PROFILE INFO -->
<div class="card profile-card p-4 mb-4">
    <div class="row align-items-center">
        <div class="col-md-3 text-center">
            <i class="fa fa-user-circle fa-6x text-primary"></i>
        </div>
        <div class="col-md-9">
            <h4><%= username %></h4>
            <p class="mb-1"><b>Role:</b> Teacher</p>
            <p class="mb-0 text-muted">
                Assigned subjects and courses are shown below
            </p>
        </div>
    </div>
</div>

<!-- ASSIGNED SUBJECTS -->
<div class="card p-4">
<h5 class="mb-3"><i class="fa fa-book"></i> Assigned Subjects & Courses</h5>

<table class="table table-bordered text-center">
<thead class="table-primary">
<tr>
    <th>#</th>
    <th>Course</th>
    <th>Subject</th>
</tr>
</thead>
<tbody>

<%
int count = 1;
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/admindb","root","2005");

    PreparedStatement ps = con.prepareStatement(
        "SELECT course_name, subject_name FROM subject_assign WHERE teacher_name=?");
    ps.setString(1, username);

    ResultSet rs = ps.executeQuery();

    boolean found = false;
    while(rs.next()){
        found = true;
%>
<tr>
    <td><%= count++ %></td>
    <td><%= rs.getString("course_name") %></td>
    <td><%= rs.getString("subject_name") %></td>
</tr>
<%
    }

    if(!found){
%>
<tr>
    <td colspan="3">No subjects assigned</td>
</tr>
<%
    }

    con.close();
}catch(Exception e){
    e.printStackTrace();
}
%>

</tbody>
</table>
</div>

</div>

<script>
function toggleDark(){
    document.getElementById("body").classList.toggle("dark");
}
</script>

</body>
</html>
    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
}
%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page import="java.sql.*" %>

<%
int studentCount = 0;
int teacherCount = 0;
int courseCount  = 0;
int reportCount  = 0;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/admindb",
        "root",
        "2005"   // password (keep empty if none)
    );

    Statement st = con.createStatement();

    // Total Students
    ResultSet rs1 = st.executeQuery("SELECT COUNT(rollno) FROM mngstudent");
    if (rs1.next()) studentCount = rs1.getInt(1);

    // Total Teachers
    ResultSet rs2 = st.executeQuery("SELECT COUNT(teacher_id) FROM mngteachers");
    if (rs2.next()) teacherCount = rs2.getInt(1);

    // Total Courses
    ResultSet rs3 = st.executeQuery("SELECT COUNT(course_id) FROM mngcourses");
    if (rs3.next()) courseCount = rs3.getInt(1);

    // Total Reports (Attendance + Marks)
    ResultSet rs4 = st.executeQuery(
        "SELECT (SELECT COUNT(id) FROM attendance) + " +
        "(SELECT COUNT(id) FROM marks) AS totalReports"
    );
    if (rs4.next()) reportCount = rs4.getInt("totalReports");

    con.close();

} catch (Exception e) {
    e.printStackTrace();
}
%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:#f4f6fb;
    transition:0.3s;
}
.dark-mode{
    background:#121212;
    color:#f1f1f1;
}

/* Sidebar */
.sidebar{
    width:260px;
    min-height:100vh;
    background:linear-gradient(180deg,#1d2671,#c33764);
    color:white;
    position:fixed;
}
.sidebar h4{
    text-align:center;
    padding:20px 0;
    border-bottom:1px solid rgba(255,255,255,0.2);
}
.sidebar a{
    display:block;
    padding:14px 20px;
    color:white;
    text-decoration:none;
    transition:0.3s;
}
.sidebar a:hover{
    background:rgba(255,255,255,0.15);
}

/* Main Content */
.main{
    margin-left:260px;
    padding:30px;
}

/* Cards */
.stat-card{
    border-radius:16px;
    padding:25px;
    color:white;
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
}
.bg1{background:linear-gradient(135deg,#667eea,#764ba2);}
.bg2{background:linear-gradient(135deg,#43cea2,#185a9d);}
.bg3{background:linear-gradient(135deg,#f7971e,#ffd200);}
.bg4{background:linear-gradient(135deg,#ff416c,#ff4b2b);}

/* Dashboard Action Cards */
.action-card{
    background:white;
    border-radius:14px;
    padding:25px;
    text-align:center;
    cursor:pointer;
    transition:0.3s;
}
.action-card:hover{
    transform:translateY(-5px);
    box-shadow:0 15px 30px rgba(0,0,0,0.2);
}
.dark-mode .action-card{
    background:#1e1e1e;
}

/* Dark button */
.toggle-btn{
    position:absolute;
    top:15px;
    right:20px;
}
</style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4>🛠 Admin Panel</h4>
    <a href="#"><i class="fa fa-gauge"></i> Dashboard</a>
    <a href="manageStudents.jsp"><i class="fa fa-user-graduate"></i> Students</a>
    <a href="manageTeachers.jsp"><i class="fa fa-chalkboard-teacher"></i> Teachers</a>
    <a href="manageCourses.jsp"><i class="fa fa-book"></i> Courses</a>
    <a href="assignSubjects.jsp"><i class="fa fa-clipboard"></i> Assign Subjects</a>
    <a href="signup.jsp"><i class="fa fa-user-plus"></i> Add User</a>
    <a href="AdminReportServlet"><i class="fa fa-chart-line"></i> Reports</a>
</div>

<!-- Main Content -->
<div class="main">

    <button class="btn btn-dark toggle-btn" onclick="toggleDark()">
        <i class="fa fa-moon"></i>
    </button>

    <h3 class="mb-4">Welcome, <b><%= username %></b></h3>

    <!-- Stats Cards -->
    <div class="row g-4 mb-4">

    <div class="col-md-3">
        <div class="stat-card bg1">
            <h5>Total Students</h5>
            <h2><%= studentCount %></h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat-card bg2">
            <h5>Total Teachers</h5>
            <h2><%= teacherCount %></h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat-card bg3">
            <h5>Total Courses</h5>
            <h2><%= courseCount %></h2>
        </div>
    </div>

    <div class="col-md-3">
        <div class="stat-card bg4">
            <h5>Total Reports</h5>
            <h2><%= reportCount %></h2>
        </div>
    </div>

</div>
    

    <!-- Action Cards -->
    <div class="row g-4">
        <div class="col-md-4">
            <div class="action-card" onclick="go('manageStudents.jsp')">
                <i class="fa fa-user-graduate fa-2x mb-2"></i>
                <h5>Manage Students</h5>
            </div>
        </div>
        <div class="col-md-4">
            <div class="action-card" onclick="go('manageTeachers.jsp')">
                <i class="fa fa-chalkboard-teacher fa-2x mb-2"></i>
                <h5>Manage Teachers</h5>
            </div>
        </div>
        <div class="col-md-4">
            <div class="action-card" onclick="go('manageCourses.jsp')">
                <i class="fa fa-book fa-2x mb-2"></i>
                <h5>Manage Courses</h5>
            </div>
        </div>
    </div>

    <!-- Logout -->
    <form action="LogoutServlet" method="post" class="mt-5">
        <button class="btn btn-danger w-100">
            <i class="fa fa-sign-out-alt"></i> Logout
        </button>
    </form>

</div>

<script>
function go(page){
    window.location.href = page;
}
function toggleDark(){
    document.body.classList.toggle("dark-mode");
}
</script>

</body>
</html>

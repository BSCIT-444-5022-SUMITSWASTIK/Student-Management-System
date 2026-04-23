<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
}
%>

<%@ page import="java.util.*" %>
<%@ page import="com.sms.dao.StudentDAO" %>
<%@ page import="com.sms.model.Student" %>

<%
    StudentDAO dao = new StudentDAO();
    List<Student> students = dao.getAllStudents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Students</title>

<link rel="stylesheet"
 href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
*{ box-sizing:border-box; }
body{
    margin:0;
    font-family:"Segoe UI",Tahoma,sans-serif;
    background:#f4f6ff;
}

/* Layout */
.wrapper{
    display:flex;
    min-height:100vh;
}

/* Sidebar */
.sidebar{
    width:240px;
    background:#4338ca;
    color:white;
    padding:20px;
}
.sidebar h2{
    text-align:center;
    margin-bottom:30px;
}
.sidebar a{
    display:block;
    padding:12px 15px;
    color:white;
    text-decoration:none;
    border-radius:8px;
    margin-bottom:8px;
    transition:0.3s;
}
.sidebar a:hover,
.sidebar a.active{
    background:#3730a3;
}

/* Main content */
.main{
    flex:1;
    padding:30px;
}

/* Card */
.card{
    background:white;
    padding:25px;
    border-radius:14px;
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
}

/* Header */
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}
.header h2{
    color:#4338ca;
}

/* Buttons */
.btn{
    padding:10px 16px;
    border:none;
    border-radius:8px;
    cursor:pointer;
    font-size:14px;
}
.back-btn{
    background:#6b7280;
    color:white;
    margin-bottom:15px;
}

/* Table */
table{
    width:100%;
    border-collapse:collapse;
    margin-top:10px;
}
th,td{
    padding:12px;
    border-bottom:1px solid #ddd;
    text-align:center;
}
th{
    background:#4f46e5;
    color:white;
}
tr:hover{
    background:#eef1ff;
}
</style>
</head>

<body>

<div class="wrapper">

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>👩‍🏫 Teacher</h2>
        <a href="teacherDashboard.jsp"><i class="fa fa-home"></i> Dashboard</a>
        <a href="markAttendance.jsp"><i class="fa fa-calendar-check"></i> Attendance</a>
        <a href="enterMarks.jsp"><i class="fa fa-pen"></i> Enter Marks</a>
        <a href="ViewStudents.jsp" class="active"><i class="fa fa-users"></i> Students</a>
        <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>

    <!-- Main -->
    <div class="main">
        <div class="card">

            <div class="header">
                <h2><i class="fa fa-users"></i> View Students</h2>
                <button class="btn back-btn" onclick="goBack()">
                    <i class="fa fa-arrow-left"></i> Back
                </button>
            </div>

            <table>
                <tr>
                    <th>Roll No</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Course</th>
                </tr>

                <%
                if(students == null || students.isEmpty()){
                %>
                <tr>
                    <td colspan="5">No students found</td>
                </tr>
                <%
                } else {
                    for(Student s : students){
                %>
                <tr>
                    <td><%= s.getRollNo() %></td>
                    <td><%= s.getStudentName() %></td>
                    <td><%= s.getEmail() %></td>
                    <td><%= s.getContact() %></td>
                    <td><%= s.getCourse() %></td>
                </tr>
                <%
                    }
                }
                %>
            </table>

        </div>
    </div>

</div>

<script>
function goBack(){
    window.location.href = "teacherDashboard.jsp";
}
</script>

</body>
</html>

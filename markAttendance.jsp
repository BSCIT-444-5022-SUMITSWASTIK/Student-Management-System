<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
}
%>

<%@ page import="java.util.*" %>
<%@ page import="com.sms.dao.StudentDAO" %>
<%@ page import="com.sms.dao.AttendanceDAO" %>
<%@ page import="com.sms.model.Student" %>

<%
    StudentDAO studentDao = new StudentDAO();
    List<Student> students = studentDao.getAllStudents();

    AttendanceDAO attendanceDao = new AttendanceDAO();
    List<String> subjects = attendanceDao.getAllSubjects();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Mark Attendance</title>

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

/* Main */
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

/* Filters */
.filters{
    display:flex;
    gap:20px;
    flex-wrap:wrap;
    margin-bottom:20px;
}
.filters label{
    font-weight:600;
}
.filters input,
.filters select{
    padding:8px 12px;
    border-radius:8px;
    border:1px solid #ccc;
}

/* Table */
table{
    width:100%;
    border-collapse:collapse;
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

/* Status */
.status{
    padding:6px 10px;
    border-radius:6px;
}

/* Buttons */
.actions{
    margin-top:20px;
}
.btn{
    padding:10px 18px;
    border:none;
    border-radius:8px;
    cursor:pointer;
    font-size:15px;
}
.save-btn{
    background:#22c55e;
    color:white;
}
.back-btn{
    background:#6b7280;
    color:white;
    margin-left:10px;
}

/* Success */
.success{
    margin-top:15px;
    color:#16a34a;
    font-weight:600;
}
</style>
</head>

<body>

<div class="wrapper">

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>👩‍🏫 Teacher</h2>
        <a href="teacherDashboard.jsp"><i class="fa fa-home"></i> Dashboard</a>
        <a href="markAttendance.jsp" class="active">
            <i class="fa fa-calendar-check"></i> Attendance
        </a>
        <a href="enterMarks.jsp"><i class="fa fa-pen"></i> Enter Marks</a>
        <a href="ViewStudents.jsp"><i class="fa fa-users"></i> Students</a>
        <a href="LogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>
    </div>

    <!-- Main -->
    <div class="main">
        <div class="card">

            <div class="header">
                <h2><i class="fa fa-calendar-check"></i> Mark Attendance</h2>
            </div>

            <form action="<%=request.getContextPath()%>/AttendanceServlet" method="post">

                <!-- Filters -->
                <div class="filters">
                    <div>
                        <label>Date</label><br>
                        <input type="date" name="date" required>
                    </div>

                    <div>
                        <label>Subject</label><br>
                        <select name="sub_name" required>
                            <option value="">Select Subject</option>
                            <% for(String sub : subjects){ %>
                                <option value="<%= sub %>"><%= sub %></option>
                            <% } %>
                        </select>
                    </div>
                </div>

                <!-- Table -->
                <table>
                    <tr>
                        <th>Roll No</th>
                        <th>Student Name</th>
                        <th>Status</th>
                    </tr>

                    <% for(Student s : students){ %>
                    <tr>
                        <td><%= s.getRollNo() %></td>
                        <td><%= s.getStudentName() %></td>
                        <td>
                            <input type="hidden" name="rollNo[]" value="<%= s.getRollNo() %>">
                            <input type="hidden" name="studentName[]" value="<%= s.getStudentName() %>">

                            <select name="status[]" class="status">
                                <option value="Present">Present</option>
                                <option value="Absent">Absent</option>
                                <option value="NA">NA</option>
                            </select>
                        </td>
                    </tr>
                    <% } %>
                </table>

                <!-- Buttons -->
                <div class="actions">
                    <button class="btn save-btn">
                        <i class="fa fa-save"></i> Save Attendance
                    </button>

                    <button type="button" class="btn back-btn"
                        onclick="location.href='teacherDashboard.jsp'">
                        <i class="fa fa-arrow-left"></i> Back
                    </button>
                </div>
            </form>

            <% if(request.getParameter("success")!=null){ %>
            <div class="success">
                <i class="fa fa-check-circle"></i>
                Attendance saved successfully!
            </div>
            <% } %>

        </div>
    </div>

</div>

</body>
</html>

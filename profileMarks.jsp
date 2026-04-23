<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
}
%>
<%@ page import="java.util.*" %>
<%@ page import="com.sms.model.ProfileMarks" %>

<%
    List<ProfileMarks> list =
        (List<ProfileMarks>) request.getAttribute("marksList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Marks Profile</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
*{ box-sizing:border-box; }
body{ margin:0; font-family:"Segoe UI",Tahoma,sans-serif; background:#f4f6ff; }

/* Wrapper */
.wrapper{
    display:flex;
    min-height:100vh;
}

/* Sidebar */
.sidebar{
    width:220px;
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
    margin-bottom:10px;
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

/* Container */
.container{
    background:#fff;
    padding:25px;
    border-radius:12px;
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
    max-width:700px;
    margin:auto;
}

/* Heading */
h2{
    text-align:center;
    color:#4338ca;
    margin-bottom:20px;
}

/* Table styling */
table{
    width:100%;
    border-collapse:collapse;
    margin-top:15px;
}
th, td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #eee;
}
th{
    background:#667eea;
    color:white;
}
tr:nth-child(even){
    background:#f8f9ff;
}

/* Status */
.pass{ color:green; font-weight:bold; }
.fail{ color:red; font-weight:bold; }

/* Back button */
.back-btn{
    margin-top:20px;
    width:100%;
    padding:12px;
    border:none;
    background:#667eea;
    color:#fff;
    border-radius:6px;
    cursor:pointer;
    font-size:16px;
}
.back-btn:hover{
    background:#4338ca;
}
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
        <a href="ProfileMarks" class="active"><i class="fa fa-pen"></i> Marks</a>
        <a href="ReportStudent"><i class="fa fa-file-download"></i> Download Report</a>
        <form action="LogoutServlet" method="post" style="margin-top:20px;">
            <button type="submit" class="back-btn"><i class="fa fa-sign-out-alt"></i> Logout</button>
        </form>
    </div>

    <!-- Main content -->
    <div class="main">
        <div class="container">
            <h2>📘 Marks Record</h2>

            <% if (list != null && !list.isEmpty()) { %>
            <table>
                <tr>
                    <th>Subject</th>
                    <th>Marks</th>
                </tr>
                <% for(ProfileMarks m : list){ %>
                <tr>
                    <td><%= m.getSubjectName() %></td>
                    <td class="<%= m.getMarks() >= 35 ? "pass" : "fail" %>">
                        <%= m.getMarks() %>
                    </td>
                </tr>
                <% } %>
            </table>
            <% } else { %>
            <p style="text-align:center;color:red; margin-top:20px;">
                No marks records found.
            </p>
            <% } %>

            <button class="back-btn" onclick="goBack()">⬅ Back to Dashboard</button>
        </div>
    </div>
</div>

<script>
function goBack(){
    window.location.href='studentDashboard.jsp';
}
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.sms.model.ProfileStudent" %>

<%
    ProfileStudent s = (ProfileStudent) request.getAttribute("profileStudent");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Student Profile</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
* { box-sizing: border-box; }
body{
    margin:0;
    font-family:"Segoe UI",Tahoma,sans-serif;
    background:#f4f6ff;
}

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

/* Profile Card */
.container{
    max-width:600px;
    margin:auto;
    background:#fff;
    padding:30px;
    border-radius:12px;
    box-shadow:0 15px 30px rgba(0,0,0,0.2);
}

h2{
    text-align:center;
    color:#4338ca;
    margin-bottom:25px;
}

/* Avatar */
.profile-pic{
    display:flex;
    justify-content:center;
    margin-bottom:25px;
}
.avatar{
    width:130px;
    height:130px;
    border-radius:50%;
    color:#fff;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:42px;
    font-weight:bold;
    letter-spacing:2px;
    box-shadow:0 8px 20px rgba(0,0,0,0.25);
}

/* Profile details */
.profile-row{
    display:flex;
    justify-content:space-between;
    padding:12px 0;
    border-bottom:1px solid #eee;
}
.profile-row span{
    font-weight:600;
}

/* Back Button */
.back-btn{
    margin-top:20px;
    width:100%;
    padding:12px;
    border:none;
    background:#667eea;
    color:#fff;
    border-radius:6px;
    cursor:pointer;
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
        <a href="ProfileStudent" class="active"><i class="fa fa-user"></i> Profile</a>
        <a href="ProfileAttendance"><i class="fa fa-calendar-check"></i> Attendance</a>
        <a href="ProfileMarks"><i class="fa fa-pen"></i> Marks</a>
        <a href="ReportStudent"><i class="fa fa-file-download"></i> Download Report</a>
        <form action="LogoutServlet" method="post" style="margin-top:20px;">
            <button type="submit" class="back-btn"><i class="fa fa-sign-out-alt"></i> Logout</button>
        </form>
    </div>

    <!-- Main content -->
    <div class="main">
        <div class="container">
            <h2>Student Profile</h2>

            <% if (s != null) { %>
            <!-- Avatar -->
            <div class="profile-pic">
                <div class="avatar" id="avatar"></div>
            </div>

            <!-- Profile Details -->
            <div class="profile-row">
                <span>Name:</span>
                <span id="name"><%= s.getStudentname() %></span>
            </div>
            <div class="profile-row">
                <span>Roll No:</span>
                <span><%= s.getRollno() %></span>
            </div>
            <div class="profile-row">
                <span>Course:</span>
                <span><%= s.getCourse() %></span>
            </div>
            <div class="profile-row">
                <span>Email:</span>
                <span><%= s.getEmail() %></span>
            </div>
            <div class="profile-row">
                <span>Phone:</span>
                <span><%= s.getContact() %></span>
            </div>
            <% } else { %>
                <p style="text-align:center;color:red;">No student record found.</p>
            <% } %>

            <button class="back-btn" onclick="goToDashboard()">⬅ Back</button>
        </div>
    </div>
</div>

<script>
function goToDashboard() {
    window.location.href = "studentDashboard.jsp";
}

/* Generate initials dynamically */
const nameText = document.getElementById("name")?.innerText || "";
const initials = nameText
    .split(" ")
    .map(word => word.charAt(0))
    .join("")
    .toUpperCase();
const avatar = document.getElementById("avatar");
avatar.innerText = initials || "ST";

/* Random background colors */
const colors = [
    "#667eea","#764ba2","#ff6b6b","#1dd1a1",
    "#54a0ff","#f368e0","#ff9f43","#48dbfb",
    "#576574","#10ac84"
];
avatar.style.background = colors[Math.floor(Math.random()*colors.length)];
</script>

</body>
</html>

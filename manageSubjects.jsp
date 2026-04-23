<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
}
%>
<%@ page import="java.util.*" %>
<%@ page import="com.sms.dao.SubjectDAO" %>
<%@ page import="com.sms.model.Subject" %>

<%
SubjectDAO dao = new SubjectDAO();
List<Subject> subjects = dao.getAllSubjects();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Subjects</title>

<style>
body{
    font-family:"Segoe UI",Tahoma,sans-serif;
    background:linear-gradient(135deg,#667eea,#764ba2);
}
.container{
    max-width:600px;
    margin:40px auto;
    background:#fff;
    padding:30px;
    border-radius:12px;
}
h2{
    text-align:center;
    color:#667eea;
}
input{
    width:100%;
    padding:12px;
    margin:10px 0;
}
button{
    width:100%;
    padding:12px;
    color:white;
    border:none;
    border-radius:6px;
    cursor:pointer;
    font-size:16px;
    margin-top:10px;
}
.add-btn{ background:#007bff; }
.add-btn:hover{ background:#0056b3; }
.back-btn{ background:#6c757d; }
.back-btn:hover{ background:#5a6268; }
ul{ margin-top:20px; padding:0; }
li{
    list-style:none;
    padding:10px;
    border-bottom:1px solid #ddd;
}
.success{
    color:green;
    text-align:center;
}
</style>
</head>

<body>
<div class="container">
<h2>📚 Manage Subjects</h2>

<form method="post" action="<%=request.getContextPath()%>/SubjectServlet">
    <input type="text" name="subject" placeholder="Enter Subject Name" required>
    <button class="add-btn">Add Subject</button>
</form>

<% if(request.getParameter("success") != null){ %>
<p class="success">Subject added successfully!</p>
<% } %>

<ul>
<% for(Subject s : subjects){ %>
    <li><%= s.getSubjectName() %></li>
<% } %>
</ul>

<button class="back-btn"
onclick="location.href='<%=request.getContextPath()%>/teacherDashboard.jsp'">
⬅ Back to Teacher Dashboard
</button>

</div>
</body>
</html>
 
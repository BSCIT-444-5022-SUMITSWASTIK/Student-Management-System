<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
}
%>

<%@ page import="java.util.*" %>
<%@ page import="com.sms.dao.SubjectAssignDAO" %>
<%@ page import="com.sms.model.SubjectAssign" %>

<%
SubjectAssignDAO dao = new SubjectAssignDAO();
List<String> teachers = dao.getTeachers();
List<String> courses  = dao.getCourses();
List<String> subjects = dao.getSubjects();
List<SubjectAssign> list = dao.getAllAssignments();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Assign Subjects</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:linear-gradient(135deg,#1d2671,#c33764);
    min-height:100vh;
}
.card{
    border-radius:16px;
    box-shadow:0 15px 30px rgba(0,0,0,0.25);
}
.form-select{
    border-radius:10px;
}
.btn{
    border-radius:10px;
}
.table th{
    background:#1d2671;
    color:#fff;
}
.table tbody tr:hover{
    background:#f1f3ff;
}
</style>
</head>

<body>

<div class="container py-4">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4 text-white">
        <h3><i class="fa fa-clipboard-list"></i> Assign Subjects</h3>
        <button class="btn btn-light" onclick="goBack()">
            <i class="fa fa-arrow-left"></i> Dashboard
        </button>
    </div>

    <!-- Assign Subject Card -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <i class="fa fa-plus-circle"></i> Assign Subject to Teacher
        </div>
        <div class="card-body">
            <form method="post" action="<%=request.getContextPath()%>/SubjectAssignServlet">
                <input type="hidden" name="action" value="assign">

                <div class="row g-3">
                    <div class="col-md-4">
                        <select name="teacher" class="form-select" required>
                            <option value="">Select Teacher</option>
                            <% for(String t : teachers){ %>
                                <option value="<%=t%>"><%=t%></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <select name="course" class="form-select" required>
                            <option value="">Select Course</option>
                            <% for(String c : courses){ %>
                                <option value="<%=c%>"><%=c%></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <select name="subject" class="form-select" required>
                            <option value="">Select Subject</option>
                            <% for(String s : subjects){ %>
                                <option value="<%=s%>"><%=s%></option>
                            <% } %>
                        </select>
                    </div>
                </div>

                <div class="text-end mt-3">
                    <button class="btn btn-success">
                        <i class="fa fa-plus"></i> Assign Subject
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Assignment Table -->
    <div class="card">
        <div class="card-header bg-dark text-white">
            <i class="fa fa-table"></i> Assigned Subjects
        </div>
        <div class="card-body table-responsive">
            <table class="table table-bordered align-middle text-center">
                <thead>
                    <tr>
                        <th>Teacher</th>
                        <th>Course</th>
                        <th>Subject</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% if(list.isEmpty()){ %>
                    <tr>
                        <td colspan="4">No assignments found</td>
                    </tr>
                <% } else {
                    for(SubjectAssign s : list){ %>
                    <tr>
                        <td><%= s.getTeacherName() %></td>
                        <td><%= s.getCourseName() %></td>
                        <td><%= s.getSubjectName() %></td>
                        <td>
                            <form method="post" action="<%=request.getContextPath()%>/SubjectAssignServlet">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= s.getAssignId() %>">
                                <button class="btn btn-danger btn-sm">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                <% }} %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<script>
function goBack(){
    window.location.href="<%=request.getContextPath()%>/adminDashboard.jsp";
}
</script>

</body>
</html>

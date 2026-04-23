<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
}
%>

<%@ page import="java.util.*" %>
<%@ page import="com.sms.dao.CourseDAO" %>
<%@ page import="com.sms.model.Course" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Manage Courses</title>

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
.form-control{
    border-radius:10px;
}
textarea.form-control{
    resize:none;
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
        <h3><i class="fa fa-book"></i> Manage Courses</h3>
        <button class="btn btn-light" onclick="goBack()">
            <i class="fa fa-arrow-left"></i> Dashboard
        </button>
    </div>

    <!-- Add Course Card -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <i class="fa fa-plus-circle"></i> Add New Course
        </div>
        <div class="card-body">
            <form method="post" action="<%=request.getContextPath()%>/CourseServlet">
                <input type="hidden" name="action" value="add">

                <div class="row g-3">
                    <div class="col-md-4">
                        <input type="text" name="name" class="form-control"
                               placeholder="Course Name" required>
                    </div>
                    <div class="col-md-3">
                        <input type="text" name="duration" class="form-control"
                               placeholder="Duration (e.g. 3 Years)" required>
                    </div>
                    <div class="col-md-5">
                        <textarea name="desc" class="form-control"
                                  placeholder="Course Description" rows="1" required></textarea>
                    </div>
                </div>

                <div class="text-end mt-3">
                    <button class="btn btn-success">
                        <i class="fa fa-plus"></i> Add Course
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Course Table -->
    <div class="card">
        <div class="card-header bg-dark text-white">
            <i class="fa fa-table"></i> Course List
        </div>
        <div class="card-body table-responsive">
            <table class="table table-bordered align-middle text-center">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Course Name</th>
                        <th>Duration</th>
                        <th>Description</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                CourseDAO dao = new CourseDAO();
                List<Course> list = dao.getAllCourses();

                if(list.isEmpty()){
                %>
                    <tr>
                        <td colspan="5">No courses available</td>
                    </tr>
                <%
                } else {
                    for(Course c : list){
                %>
                    <tr>
                        <td><%= c.getCourseId() %></td>
                        <td><%= c.getCourseName() %></td>
                        <td><%= c.getCourseDuration() %></td>
                        <td><%= c.getCourseDesc() %></td>
                        <td>
                            <form method="post" action="<%=request.getContextPath()%>/CourseServlet">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="<%= c.getCourseId() %>">
                                <button class="btn btn-danger btn-sm">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                <%
                    }
                }
                %>
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

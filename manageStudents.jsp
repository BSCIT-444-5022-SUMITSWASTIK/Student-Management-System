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
<title>Manage Students</title>

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
.error{
    border:2px solid red;
}
</style>

<script>
function validateForm(){
    let roll = document.getElementsByName("roll")[0];
    let name = document.getElementsByName("name")[0];
    let email = document.getElementsByName("email")[0];
    let contact = document.getElementsByName("contact")[0];
    let course = document.getElementsByName("course")[0];

    let valid = true;
    [roll,name,email,contact,course].forEach(f=>f.classList.remove("error"));

    if(roll.value <= 0){
        roll.classList.add("error");
        alert("Roll number must be positive");
        valid = false;
    }
    if(name.value.trim().length < 3){
        name.classList.add("error");
        alert("Student name must be at least 3 characters");
        valid = false;
    }
    if(!email.value.match(/^[^ ]+@[^ ]+\.[a-z]{2,}$/)){
        email.classList.add("error");
        alert("Invalid email format");
        valid = false;
    }
    if(!contact.value.match(/^[6-9]\d{9}$/)){
        contact.classList.add("error");
        alert("Enter valid 10-digit mobile number");
        valid = false;
    }
    if(course.value.trim() === ""){
        course.classList.add("error");
        alert("Course is required");
        valid = false;
    }
    return valid;
}

function confirmDelete(){
    return confirm("Are you sure you want to delete this student?");
}
</script>
</head>

<body>

<div class="container py-4">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4 text-white">
        <h3><i class="fa fa-user-graduate"></i> Manage Students</h3>
        <button class="btn btn-light" onclick="goBack()">
            <i class="fa fa-arrow-left"></i> Dashboard
        </button>
    </div>

    <!-- Add Student Card -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <i class="fa fa-user-plus"></i> Add New Student
        </div>
        <div class="card-body">
            <form method="post" action="StudentServlet" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="add">

                <div class="row g-3">
                    <div class="col-md-2">
                        <input type="number" name="roll" class="form-control" placeholder="Roll No" required>
                    </div>
                    <div class="col-md-3">
                        <input type="text" name="name" class="form-control" placeholder="Student Name" required>
                    </div>
                    <div class="col-md-3">
                        <input type="email" name="email" class="form-control" placeholder="Email" required>
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="contact" class="form-control" placeholder="Contact" required>
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="course" class="form-control" placeholder="Course" required>
                    </div>
                </div>

                <div class="text-end mt-3">
                    <button class="btn btn-success">
                        <i class="fa fa-plus"></i> Add Student
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Student Table -->
    <div class="card">
        <div class="card-header bg-dark text-white">
            <i class="fa fa-table"></i> Student List
        </div>
        <div class="card-body table-responsive">
            <table class="table table-bordered align-middle text-center">
                <thead>
                    <tr>
                        <th>Roll</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Course</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                if(students.isEmpty()){
                %>
                    <tr>
                        <td colspan="6">No students found</td>
                    </tr>
                <%
                } else {
                    for(Student s : students){
                %>
                    <tr>
                        <td><%=s.getRollNo()%></td>
                        <td><%=s.getStudentName()%></td>
                        <td><%=s.getEmail()%></td>
                        <td><%=s.getContact()%></td>
                        <td><%=s.getCourse()%></td>
                        <td>
                            <form method="post" action="StudentServlet" onsubmit="return confirmDelete()">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="roll" value="<%=s.getRollNo()%>">
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
    window.location.href="adminDashboard.jsp";
}
</script>

</body>
</html>

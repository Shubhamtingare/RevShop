<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.revature.service.dao.*, com.revature.service.*,com.revature.data.*,java.util.*,jakarta.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Profile Details</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="cssFiles/userProfile.css">
</head>
<body class="background">

	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {
		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}

	UserService dao = new UserServiceImpl();
	UserData user = dao.getUserDetails(userName, password);
	if (user == null)
		user = new UserData("Test User", 98765498765L, "test@gmail.com", "ABC colony, Patna, bihar", 87659, "lksdjf");
	%>

	<jsp:include page="header.jsp" />

	<div class="container">
		<nav class="breadcrumb">
			<a href="index.jsp">Home</a> &gt;
			<a href="profile.jsp">User Profile</a>
		</nav>

		<div class="profile-container">
			<div class="profile-card">
				<img src="images/profile.png" class="profile-image" alt="Profile">
				<h5 class="profile-name">
					Hello <%=user.getName()%> here!!
				</h5>
			</div>

			<div class="profile-details">
				<h1>My Profile</h1>
				<div class="profile-info">
					<p><strong>Full Name:</strong> <%=user.getName()%></p>
					<p><strong>Email:</strong> <%=user.getEmail()%></p>
					<p><strong>Phone:</strong> <%=user.getMobile()%></p>
					<p><strong>Address:</strong> <%=user.getAddress()%></p>
					<p><strong>PinCode:</strong> <%=user.getPinCode()%></p>
				</div>
			</div>
		</div>

	</div>

	<%@ include file="footer.html"%>

</body>
</html>

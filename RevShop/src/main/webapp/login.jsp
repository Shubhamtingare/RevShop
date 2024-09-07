<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="cssFiles/login.css">

</head>
<body>

   <%
	// Set the request attribute to hide specific header content
	request.setAttribute("headerContent", "hideHeaderContent");
	%>
	<%@ include file="header.jsp"%>
	
    <%
    String message = request.getParameter("message");
    %>
    <div class="login-container">
            <!-- Login Form on the left side -->
            <div class="box box-left">
                <div class="panel">
                    <div class="panel-heading">
                        <h2>Login Here</h2>
                    </div>
                    <div class="panel-body">
                        <%
                        if (message != null) {
                        %>
                        <p style="color: black;">
                            <%=message%>
                        </p>
                        <%
                        }
                        %>
                        <form action="./LoginServlet" method="post">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" placeholder="Enter Email" name="username"
                                    id="email" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" placeholder="Enter Password" name="password"
                                    id="password" required>
                            </div>
                            <div class="form-group">
                                <label for="userrole">Login As</label>
                                <select name="usertype" id="userrole" required>
                                    <option value="customer" selected>CUSTOMER</option>
                                    <option value="admin">ADMIN</option>
                                </select>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn">Login</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Content on the right side -->
            <div class="box box-right">
                <div class="panel">
                    <div class="panel-heading">
                        <h2>Welcome Back!</h2>
                    </div>
                    <div class="panel-body">
                        <p>
                            We're glad to see you again! Logging in allows you to access your personalized dashboard, manage your account, and enjoy a seamless shopping experience.
                        </p>
                        <p>
                            By logging in, you can:
                            <ul style="list-style-type: disc; padding-left: 20px;">
                                <li>View and track your orders</li>
                                <li>Save your favorite products</li>
                                <li>Receive personalized recommendations</li>
                                <li>Access exclusive deals and discounts</li>
                            </ul>
                        </p>
                        <p>
                            Don't have an account yet? <a href="register.jsp" style="color: green;">Sign up now</a> and join our community!
                        </p>
                    </div>
                </div>
            </div>

        </div>
  

    <%@ include file="footer.html"%>

</body>
</html>

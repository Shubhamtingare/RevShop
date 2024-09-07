<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link rel="stylesheet" href="cssFiles/register.css">
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
    <div class="container">

        <form action="./RegisterServlet" method="post" class="box box-left">
            <div class="form-header">
                <h2>Registration Form</h2>
                <%
                if (message != null) {
                %>
                <p class="message">
                    <%=message%>
                </p>
                <%
                }
                %>
            </div>
            <div class="form-group">
                <label for="first_name">Name</label> 
                <input type="text" name="username" id="first_name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label> 
                <input type="email" name="email" id="email" required>
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <textarea name="address" id="address" required></textarea>
            </div>
            <div class="form-group">
                <label for="mobile">Mobile</label> 
                <input type="number" name="mobile" id="mobile" required>
            </div>
            <div class="form-group">
                <label for="pincode">Pin Code</label> 
                <input type="number" name="pincode" id="pincode" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label> 
                <input type="password" name="password" id="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label> 
                <input type="password" name="confirmPassword" id="confirmPassword" required>
            </div>
            <div class="row text-center">
                <div>
                    <button type="Reset" class="btn btn-danger">Reset</button>
                </div>
                <div>
                    <button type="submit" class="btn btn-success">Register</button>
                </div>
            </div>
        </form>

        <!-- Content on the right side -->
        <div class="box box-right">
            <h2>Join Our Community!</h2>
            <p>By registering, you gain access to a personalized shopping experience, exclusive discounts, and a variety of features designed to make your shopping journey seamless and enjoyable.</p>
            <p>As a registered user, you can:
            <ul style="list-style-type: disc; padding-left: 20px;">
                <li>Manage your account and orders</li>
                <li>Save your favorite products</li>
                <li>Receive personalized recommendations</li>
                <li>Be the first to know about new arrivals and special offers</li>
            </ul>
            </p>
            <p>Don't miss out on the benefits of being a registered user. Join us today!</p>
        </div>

    </div>

    <%@ include file="footer.html"%>
</body>
</html>

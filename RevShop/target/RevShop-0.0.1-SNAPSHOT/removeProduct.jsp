<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Remove Product</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="cssFiles/removeProduct.css">
</head>
<body class="background">

    <%
    /* Checking the user credentials */
    String userType = (String) session.getAttribute("usertype");
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
    } else if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }
    %>

    <jsp:include page="header.jsp" />

    <%
    String message = request.getParameter("message");
    %>
    <div class="container">
        <div class="form-container">
            <form action="./RemoveProductServlet" method="post" class="form-style">
                <div class="text-center">
                    <h3 class="heading">Product Deletion Form</h3>
                    <%
                    if (message != null) {
                    %>
                    <p class="message"><%=message%></p>
                    <%
                    }
                    %>
                </div>
                <div class="form-group">
                    <label for="prodid">Product Id</label>
                    <input type="text" placeholder="Enter Product Id" name="prodid" class="form-control" id="prodid" required>
                </div>
                <div class="button-group">
                    <a href="adminViewProduct.jsp" class="btn btn-cancel">Cancel</a>
                    <button type="submit" class="btn btn-remove">Remove Product</button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="footer.html" />
</body>
</html>

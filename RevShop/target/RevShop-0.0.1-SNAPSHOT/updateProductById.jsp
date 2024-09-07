<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Product</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="cssFiles/updateProductById.css">
</head>
<body class="background">
    <%
    /* Checking the user credentials */
    String userType = (String) session.getAttribute("usertype");
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login As Admin!!");
        return;

    } else if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        return;
    }
    %>

    <jsp:include page="header.jsp" />

    <%
    String message = request.getParameter("message");
    %>
    <div class="container">
        <div class="form-container">
            <form action="updateProduct.jsp" method="post">
                <div class="form-header">
                    <h3>Product Update Form</h3>
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
                    <input type="text" id="prodid" name="prodid" placeholder="Enter Product Id" required>
                </div>
                <div class="form-buttons">
                    <a href="adminViewProduct.jsp" class="btn btn-cancel">Cancel</a>
                    <button type="submit" class="btn btn-submit">Update Product</button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.html"%>
</body>
</html>

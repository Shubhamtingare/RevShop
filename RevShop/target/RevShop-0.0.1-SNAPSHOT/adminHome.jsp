<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Home</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="cssFiles/adminHome.css">
</head>
<body>
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

    <div class="admin-container">
        <div class="tab">
            <form>
                <button type="submit" formaction="adminViewProduct.jsp"
                    class="custom-button view-products">View Products</button>
                <button type="submit" formaction="addProduct.jsp"
                    class="custom-button add-products">Add Products</button>
                <button type="submit" formaction="removeProduct.jsp"
                    class="custom-button remove-products">Remove Products</button>
                <button type="submit" formaction="updateProductById.jsp"
                    class="custom-button update-products">Update Products</button>
            </form>
        </div>
    </div>

    <jsp:include page="footer.html" />
</body>
</html>

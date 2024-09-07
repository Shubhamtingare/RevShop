<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="cssFiles/addProduct.css">
</head>
<body style="background-color: #E6F9E6;">
    <%
    // Session validation
    String userType = (String) session.getAttribute("usertype");
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
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
        <form action="./AddProductservlet" method="post" enctype="multipart/form-data" class="form">
            <div class="text-center">
                <h2>Product Addition Form</h2>
                <%
                if (message != null) {
                %>
                <p><%=message%></p>
                <%
                }
                %>
            </div>
            <div class="form-group">
                <label for="product_name">Product Name</label>
                <input type="text" placeholder="Enter Product Name" name="name" id="product_name" required>
            </div>
            <div class="form-group">
                <label for="product_type">Product Type</label>
                <select name="type" id="product_type" required>
                    <option value="cricket">Cricket</option>
                    <option value="football">Football</option>
                    <option value="volleyball">Volleyball</option>
                    <option value="badminton">Badminton</option>
                    <option value="basketball">Basketball</option>
                    <option value="tabletennis">Table Tennis</option>
                    <option value="other">Some Other Items</option>
                </select>
            </div>
            <div class="form-group">
                <label for="product_description">Product Description</label>
                <textarea name="info" id="product_description" required></textarea>
            </div>
            <div class="form-group">
                <label for="product_price">Unit Price</label>
                <input type="number" placeholder="Enter Unit Price" name="price" id="product_price" required>
            </div>
            <div class="form-group">
                <label for="product_quantity">Stock Quantity</label>
                <input type="number" placeholder="Enter Stock Quantity" name="quantity" id="product_quantity" required>
            </div>
            <div class="form-group">
                <label for="product_image">Product Image</label>
                <input type="file" placeholder="Select Image" name="image" id="product_image" required>
            </div>
            <div class="row">
                <div class="col-md-6 text-center" style="margin-bottom: 10px;">
                    <button type="reset" class="btn resetbtn">Reset</button>
                </div>
                <div class="col-md-6 text-center">
                    <button type="submit" class="btn addproduct">Add Product</button>
                </div>
            </div>
        </form>
    </div>

    <jsp:include page="footer.html" />
</body>
</html>

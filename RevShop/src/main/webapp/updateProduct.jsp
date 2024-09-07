<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.revature.service.dao.*, com.revature.service.*, com.revature.data.*, java.util.*, jakarta.servlet.ServletOutputStream, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Update Product</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="cssFiles/updateProduct.css">
</head>
<body class="background">
    <%
    /* Checking the user credentials */
    String utype = (String) session.getAttribute("usertype");
    String uname = (String) session.getAttribute("username");
    String pwd = (String) session.getAttribute("password");
    String prodid = request.getParameter("prodid");
    ProductData product = new ProductServiceImpl().getProductDetails(prodid);
    if (prodid == null || product == null) {
        response.sendRedirect("updateProductById.jsp?message=Please Enter a valid product Id");
        return;
    } else if (utype == null || !utype.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
        return;
    } else if (uname == null || pwd == null) {
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
            <form action="./UpdateProductServlet" method="post">
                <div class="form-header">
                    <img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product Image" height="100px" />
                    <h2>Product Update Form</h2>
                    <%
                    if (message != null) {
                    %>
                    <p class="message"><%=message%></p>
                    <%
                    }
                    %>
                </div>
                <input type="hidden" name="pid" value="<%=product.getProdId()%>" required>
                <div class="form-group">
                    <label for="product-name">Product Name</label>
                    <input type="text" id="product-name" name="name" value="<%=product.getProdName()%>" placeholder="Enter Product Name" required>
                </div>
                <div class="form-group">
                    <label for="product-type">Product Type</label>
                    <select id="product-type" name="type" required>
                        <option value="mobile" <%= "mobile".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>MOBILE</option>
                        <option value="tv" <%= "tv".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>TV</option>
                        <option value="camera" <%= "camera".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>CAMERA</option>
                        <option value="laptop" <%= "laptop".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>LAPTOP</option>
                        <option value="tablet" <%= "tablet".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>TABLET</option>
                        <option value="speaker" <%= "speaker".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>SPEAKER</option>
                        <option value="other" <%= "other".equalsIgnoreCase(product.getProdType()) ? "selected" : "" %>>Some Other Appliances</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="product-description">Product Description</label>
                    <textarea id="product-description" name="info" required><%=product.getProdInfo()%></textarea>
                </div>
                <div class="form-group">
                    <label for="unit-price">Unit Price</label>
                    <input type="number" id="unit-price" name="price" value="<%=product.getProdPrice()%>" placeholder="Enter Unit Price" required>
                </div>
                <div class="form-group">
                    <label for="stock-quantity">Stock Quantity</label>
                    <input type="number" id="stock-quantity" name="quantity" value="<%=product.getProdQuantity()%>" placeholder="Enter Stock Quantity" required>
                </div>
                <div class="form-buttons">
                    <button formaction="adminViewProduct.jsp" class="btn btn-cancel">Cancel</button>
                    <button type="submit" class="btn btn-submit">Update Product</button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.html"%>
</body>
</html>

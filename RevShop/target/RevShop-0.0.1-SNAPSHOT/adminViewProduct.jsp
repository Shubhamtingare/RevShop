<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.revature.service.dao.*, com.revature.service.*,com.revature.data.*,java.util.*,jakarta.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Products</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="cssFiles/adminViewProduct.css">
</head>
<body>

    <%
    /* Checking the user credentials */
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");
    String userType = (String) session.getAttribute("usertype");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
    } else if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }

    ProductServiceImpl prodDao = new ProductServiceImpl();
    List<ProductData> products = new ArrayList<ProductData>();

    String search = request.getParameter("search");
    String type = request.getParameter("type");
    String message = "All Products";
    if (search != null) {
        products = prodDao.searchAllProducts(search);
        message = "Showing Results for '" + search + "'";
    } else if (type != null) {
        products = prodDao.getAllProductsByType(type);
        message = "Showing Results for '" + type + "'";
    } else {
        products = prodDao.getAllProducts();
    }
    if (products.isEmpty()) {
        message = "No items found for the search '" + (search != null ? search : type) + "'";
        products = prodDao.getAllProducts();
    }
    %>

    <jsp:include page="header.jsp" />

    <div class="text-center custom-message"><%=message%></div>

    <!-- Start of Product Items List -->
    <div class="container">
        <div class="row text-center">

            <%
            for (ProductData product : products) {
            %>
            <div class="col-4 product-card">
                <div class="thumbnail">
                    <div class="imgbox"><img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product"></div>
                </div>
                <p class="productname"><%=product.getProdName()%> (<%=product.getProdId()%>)</p>
                <p class="productinfo"><%=product.getProdInfo()%></p>
                <p class="price">Rs <%=product.getProdPrice()%></p>
                <form method="post">
                    <button type="submit" formaction="./RemoveProductServlet?prodid=<%=product.getProdId()%>" class="btn removeproduct">Remove Product</button>
                    <button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>" class="btn updateproduct">Update Product</button>
                </form>
            </div>
            <%
            }
            %>

        </div>
    </div>
    <!-- End of Product Items List -->

    <jsp:include page="footer.html" />

</body>
</html>



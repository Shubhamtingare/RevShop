<%@ page import="com.revature.service.dao.*, com.revature.service.*,com.revature.data.*,java.util.*,jakarta.servlet.ServletOutputStream,java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Product Stocks</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="cssFiles/adminStock.css">
</head>
<body style="background-color: #E6F9E6;">
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

    <div class="text-center custom-heading">
        Stock Products
    </div>
    <div class="container">
        <div class="table-responsive">
            <table class="custom-table">
                <thead class="custom-table-head">
                    <tr>
                        <th>Image</th>
                        <th>ProductId</th>
                        <th>Name</th>
                        <th>Type</th>
                        <th>Price</th>
                        <th>Sold Qty</th>
                        <th>Stock Qty</th>
                        <th colspan="2" style="text-align: center">Actions</th>
                    </tr>
                </thead>
                <tbody class="custom-table-body">
                    <%
                    ProductServiceImpl productDao = new ProductServiceImpl();
                    List<ProductData> products = new ArrayList<ProductData>();
                    products = productDao.getAllProducts();
                    for (ProductData product : products) {
                    %>
                    <tr>
                        <td><img src="./ShowImage?pid=<%=product.getProdId()%>" class="product-image"></td>
                        <td><a href="./updateProduct.jsp?prodid=<%=product.getProdId()%>" class="product-link"><%=product.getProdId()%></a></td>
                        <%
                        String name = product.getProdName();
                        name = name.substring(0, Math.min(name.length(), 25)) + "..";
                        %>
                        <td><%=name%></td>
                        <td><%=product.getProdType().toUpperCase()%></td>
                        <td><%=product.getProdPrice()%></td>
                        <td><%=new OrderServiceImpl().countSoldItem(product.getProdId())%></td>
                        <td><%=product.getProdQuantity()%></td>
                        <td>
                            <form method="post">
                                <button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>" class="custom-button">Update</button>
                            </form>
                        </td>
                        <td>
                            <form method="post">
                                <button type="submit" formaction="./RemoveProductServlet?prodid=<%=product.getProdId()%>" class="custom-button danger">Remove</button>
                            </form>
                        </td>
                    </tr>
                    <%
                    }
                    if (products.size() == 0) {
                    %>
                    <tr class="no-items">
                        <td colspan="7" style="text-align: center;">No Items Available</td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <jsp:include page="footer.html" />
</body>
</html>

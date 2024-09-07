<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
	import="com.revature.service.dao.*, com.revature.service.*,com.revature.data.*,java.util.*,jakarta.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>RevShop</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="cssFiles/index.css">
</head>
<body>

	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {
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

	<div class="text-center" id="message" style="font-size: 14px; font-weight: bold;"><%=message%></div>

<!-- Start of Product Items List -->
<div class="container">
    <div class="row text-center">

        <%
        for (ProductData product : products) {
            int cartQty = new CartServiceImpl().getCartItemCount(userName, product.getProdId());
        %>
        <div class="col-4 product-card">
            <div class="thumbnail">
                <div class="imgbox"><img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product"></div>
                <p class="productname"><%=product.getProdName()%></p>
                <%
                String description = product.getProdInfo();
                description = description.substring(0, Math.min(description.length(), 100));
                %>
                <p class="productinfo"><%=description%>...</p>
                <p class="price">Rs <%=product.getProdPrice()%></p>
                <form method="post">
                    <%
                    if (cartQty == 0) {
                    %>
                    <button type="submit" formaction="./AddToCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1" class="btn addcart">Add to Cart</button>
                    &nbsp;&nbsp;&nbsp;
                    <button type="submit" formaction="./AddToCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1" class="btn buynow">Buy Now</button>
                    <%
                    } else {
                    %>
                    <button type="submit" formaction="./AddToCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=0" class="btn btn-danger">Remove From Cart</button>
                    &nbsp;&nbsp;&nbsp;
                    <button type="submit" formaction="cartDetails.jsp" class="btn btn-success">Checkout</button>
                    <%
                    }
                    %>
                </form>
                <br />
            </div>
        </div>

        <%
        }
        %>

    </div>
</div>

	<%@ include file="footer.html"%>

</body>
</html>

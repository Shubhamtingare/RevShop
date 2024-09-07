<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.revature.service.dao.*, com.revature.service.*,com.revature.data.*,java.util.*,jakarta.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cart Details</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="cssFiles/cartDetails.css">
</head>
<body>

    <%
    /* Checking the user credentials */
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }

    String addS = request.getParameter("add");
    if (addS != null) {

        int add = Integer.parseInt(addS);
        String uid = request.getParameter("uid");
        String pid = request.getParameter("pid");
        int avail = Integer.parseInt(request.getParameter("avail"));
        int cartQty = Integer.parseInt(request.getParameter("qty"));
        CartServiceImpl cart = new CartServiceImpl();

        if (add == 1) {
            // Add Product into the cart
            cartQty += 1;
            if (cartQty <= avail) {
                cart.addProductToCart(uid, pid, 1);
            } else {
                response.sendRedirect("./AddToCart?pid=" + pid + "&pqty=" + cartQty);
            }
        } else if (add == 0) {
            // Remove Product from the cart
            cart.removeProductFromCart(uid, pid);
        }
    }
    %>

    <jsp:include page="header.jsp" />

    <div class="text-center custom-title">Cart Items</div>

    <!-- Start of Product Items List -->
    <div class="container">
        <table class="custom-table">
            <thead>
                <tr>
                    <th>Picture</th>
                    <th>Products</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Add</th>
                    <th>Remove</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <%
                CartServiceImpl cart = new CartServiceImpl();
                List<CartData> cartItems = new ArrayList<CartData>();
                cartItems = cart.getAllCartItems(userName);
                double totAmount = 0;
                for (CartData item : cartItems) {

                    String prodId = item.getProdId();
                    int prodQuantity = item.getQuantity();
                    ProductData product = new ProductServiceImpl().getProductDetails(prodId);
                    double currAmount = product.getProdPrice() * prodQuantity;
                    totAmount += currAmount;

                    if (prodQuantity > 0) {
                %>
                <tr>
                    <td><img src="./ShowImage?pid=<%=product.getProdId()%>" class="product-image"></td>
                    <td><%=product.getProdName()%></td>
                    <td><%=product.getProdPrice()%></td>
                    <td>
                        <form method="post" action="./UpdateToCart">
                            <input type="number" name="pqty" value="<%=prodQuantity%>" class="quantity-input" min="0"> 
                            <input type="hidden" name="pid" value="<%=product.getProdId()%>"> 
                            <input type="submit" name="Update" value="Update" class="custom-button update-button">
                        </form>
                    </td>
                    <td>
                        <a href="cartDetails.jsp?add=1&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>" class="custom-icon">+</a>
                    </td>
                    <td>
                        <a href="cartDetails.jsp?add=0&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>" class="custom-icon">-</a>
                    </td>
                    <td><%=currAmount%></td>
                </tr>
                <%
                    }
                }
                %>

                <tr class="total-row">
                    <td colspan="6" class="text-center">Total Amount to Pay (in Rupees)</td>
                    <td><%=totAmount%></td>
                </tr>
                <%
                if (totAmount != 0) {
                %>
                <tr class="action-row">
                    <td colspan="4" class="text-center">
                    <td>
                        <form method="post">
                            <button formaction="userHome.jsp" class="custom-button cancel-button">Cancel</button>
                        </form>
                    </td>
                    <td colspan="2" align="center">
                        <form method="post">
                            <button formaction="payment.jsp?amount=<%=totAmount%>" class="custom-button pay-button">Pay Now</button>
                        </form>
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
    <!-- End of Product Items List -->

    <jsp:include page="footer.html" />

</body>
</html>

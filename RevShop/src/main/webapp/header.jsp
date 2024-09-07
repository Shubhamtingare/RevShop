<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.revature.service.dao.*, com.revature.service.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Logout Header</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="cssFiles/header.css">
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    const dropdowns = document.querySelectorAll('.dropdown-toggle');

    dropdowns.forEach(function(dropdown) {
        dropdown.addEventListener('click', function(event) {
            event.preventDefault();

            const menu = this.nextElementSibling;
            if (menu.style.display === 'block') {
                menu.style.display = 'none';
            } else {
                document.querySelectorAll('.dropdown-menu').forEach(function(menu) {
                    menu.style.display = 'none';
                });
                menu.style.display = 'block';
            }
        });
    });

    document.addEventListener('click', function(event) {
        const isClickInside = event.target.closest('.dropdown');
        if (!isClickInside) {
            document.querySelectorAll('.dropdown-menu').forEach(function(menu) {
                menu.style.display = 'none';
            });
        }
    });
});
</script>
</head>
<body>
    <!-- Company Header Starting -->
    <div class="header" <% if ("hideHeaderContent".equals(request.getAttribute("headerContent"))){ %> style="display:none;" <% } %>>
        <div class="row">
            <div>
                <h2>Sports Club</h2>
                <h6>Sports is an emotion!</h6>
            </div>
            <div>
                <form class="search-box" action="index.jsp" method="get">
                    <input type="text" name="search" placeholder="Search Items" required>
                    <input type="submit" value="Search">
                </form>
            </div>
        </div>
        <p align="center" style="color: orange; font-weight: bold; margin-top: 5px; margin-bottom: 5px;" id="message"></p>
    </div>
    <!-- Company Header Ending -->

    <%
    String userType = (String) session.getAttribute("usertype");
    if (userType == null) { // LOGGED OUT
    %>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="navbar-header">
            <a href="index.jsp"><img src="images/nav-logo.png" alt="RevShop Logo" class="nav-logo"></a>
        </div>
        <div class="navbar-collapse">
            <ul>
                <li><a href="register.jsp">Register</a></li>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="index.jsp">Products</a></li>
                <li class="dropdown"><a href="#" class="dropdown-toggle">Category</a>
                    <ul class="dropdown-menu">
                        <li><a href="index.jsp?type=cricket">Cricket</a></li>
                        <li><a href="index.jsp?type=football">Football</a></li>
                        <li><a href="index.jsp?type=volleyball">Volleyball</a></li>
                        <li><a href="index.jsp?type=badminton">Badminton</a></li>
                        <li><a href="index.jsp?type=basketball">Basketball</a></li>
                        <li><a href="index.jsp?type=tabletennis">Table Tennis</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    <%
    } else if ("customer".equalsIgnoreCase(userType)) { 
    int notf = new CartServiceImpl().getCartCount((String) session.getAttribute("username"));
    %>
    <nav class="navbar">
        <div class="navbar-header">
            <a href="userHome.jsp"><img src="images/nav-logo.png" alt="RevShop Logo" class="nav-logo"></a>
        </div>
        <div class="navbar-collapse">
            <ul>
                <li><a href="userHome.jsp">Products</a></li>
                <li class="dropdown"><a href="#" class="dropdown-toggle">Category</a>
                    <ul class="dropdown-menu">
                        <li><a href="userHome.jsp?type=cricket">Cricket</a></li>
                        <li><a href="userHome.jsp?type=football">Football</a></li>
                        <li><a href="userHome.jsp?type=volleyball">Volleyball</a></li>
                        <li><a href="userHome.jsp?type=badminton">Badminton</a></li>
                        <li><a href="userHome.jsp?type=basketball">Basketball</a></li>
                        <li><a href="userHome.jsp?type=tabletennis">Table Tennis</a></li>
                    </ul>
                </li>
                <%
                if (notf == 0) {
                %>
                <li><a href="cartDetails.jsp">Cart</a></li>
                <%
                } else {
                %>
                <li class="shopping-cart-icon" data-count="<%=notf%>">
                    <a href="cartDetails.jsp"><i class="fa fa-shopping-cart"></i>Cart</a>
                </li>
                <%
                }
                %>
                <li><a href="orderDetails.jsp">Orders</a></li>
                <li><a href="userProfile.jsp">Profile</a></li>
                <li><a href="./LogoutServlet">Logout</a></li>
            </ul>
        </div>
    </nav>
    <%
    } else {
    %>
    <nav class="navbar">
        <div class="navbar-header">
            <a href="adminHome.jsp"><img src="images/nav-logo.png" alt="RevShop Logo" class="nav-logo"></a>
        </div>
        <div class="navbar-collapse">
            <ul>
                <li><a href="adminHome.jsp">Products</a></li>
                <li class="dropdown"><a href="#" class="dropdown-toggle">Category</a>
                    <ul class="dropdown-menu">
                        <li><a href="adminViewProduct.jsp?type=cricket">Cricket</a></li>
                        <li><a href="adminViewProduct.jsp?type=football">Football</a></li>
                        <li><a href="adminViewProduct.jsp?type=volleyball">Volleyball</a></li>
                        <li><a href="adminViewProduct.jsp?type=badminton">Badminton</a></li>
                        <li><a href="adminViewProduct.jsp?type=basketball">Basketball</a></li>
                        <li><a href="adminViewProduct.jsp?type=tabletennis">Table Tennis</a></li>
                    </ul>
                </li>
                <li><a href="unshippedItems.jsp">Orders</a></li>
                <li><a href="addProduct.jsp">Add Product</a></li>
                <li><a href="shippedItems.jsp">Customers</a></li>
                <li><a href="./LogoutServlet">Logout</a></li>
            </ul>
        </div>
    </nav>
    <%
    }
    %>
</body>
</html>

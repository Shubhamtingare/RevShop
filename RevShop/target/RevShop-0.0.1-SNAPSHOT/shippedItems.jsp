<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.revature.service.dao.*, com.revature.data.*, com.revature.service.*, java.util.*"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<title>Admin Home</title>
<link rel="stylesheet" href="cssFiles/shippedItems.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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

    <div class="heading">Shipped Orders</div>
    <div class="container">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>TransactionId</th>
                        <th>ProductId</th>
                        <th>Username</th>
                        <th>Address</th>
                        <th>Quantity</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    OrderServiceImpl orderdao = new OrderServiceImpl();
                    List<OrderData> orders = orderdao.getAllOrders();
                    int count = 0;
                    for (OrderData order : orders) {
                        String transId = order.getTransactionId();
                        String prodId = order.getProductId();
                        int quantity = order.getQuantity();
                        int shipped = order.getShipped();
                        String userId = new TransServiceImpl().getUserId(transId);
                        String userAddr = new UserServiceImpl().getUserAddr(userId);
                        if (shipped != 0) {
                            count++;
                    %>

                    <tr>
                        <td><%=transId%></td>
                        <td><a href="./updateProduct.jsp?prodid=<%=prodId%>"><%=prodId%></a></td>
                        <td><%=userId%></td>
                        <td><%=userAddr%></td>
                        <td><%=quantity%></td>
                        <td>Rs. <%=order.getAmount()%></td>
                        <td class="shipped">SHIPPED</td>
                    </tr>

                    <%
                        }
                    }
                    %>
                    <%
                    if (count == 0) {
                    %>
                    <tr class="no-items">
                        <td colspan="7">No Items Available</td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <%@ include file="footer.html"%>
</body>
</html>

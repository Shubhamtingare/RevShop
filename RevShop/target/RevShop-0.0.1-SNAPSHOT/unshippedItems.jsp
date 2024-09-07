<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.revature.service.dao.*, com.revature.data.*, com.revature.service.*, java.util.*"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Home</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="cssFiles/unshippedItems.css">
</head>
<body class="background">
    <%
    /* Checking the user credentials */
    String userType = (String) session.getAttribute("usertype");
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("loginFirst.jsp");
    }

    if (userName == null || password == null) {
        response.sendRedirect("loginFirst.jsp");
    }
    %>

    <jsp:include page="header.jsp" />

    <div class="heading">UnShipped Orders</div>
    <div class="container">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>TransactionId</th>
                        <th>ProductId</th>
                        <th>User Email Id</th>
                        <th>Address</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Action</th>
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
                        if (shipped == 0) {
                            count++;
                    %>

                    <tr>
                        <td><%=transId%></td>
                        <td><a href="./updateProduct.jsp?prodid=<%=prodId%>"><%=prodId%></a></td>
                        <td><%=userId%></td>
                        <td><%=userAddr%></td>
                        <td><%=quantity%></td>
                        <td class="status">READY_TO_SHIP</td>
                        <td><a href="ShipmentServlet?orderid=<%=order.getTransactionId()%>&amount=<%=order.getAmount()%>&userid=<%=userId%>&prodid=<%=order.getProductId()%>" class="btn btn-success">SHIP NOW</a></td>
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

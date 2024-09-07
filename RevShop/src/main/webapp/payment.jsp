<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payments</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="cssFiles/payment.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body class="background">

    <%
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
    }

    String sAmount = request.getParameter("amount");
    double amount = 0;

    if (sAmount != null) {
        amount = Double.parseDouble(sAmount);
    }
    %>

    <jsp:include page="header.jsp" />

    <div class="container">
        <div class="row form-container">
            <form action="./OrderServlet" method="post" class="form-style">
                <div class="text-center">
                    <div class="form-group">
                        <img src="images/profile.png" alt="Payment Proceed" class="payment-img" />
                        <h2 class="heading">Credit Card Payment</h2>
                    </div>
                </div>
                <div class="form-group">
                    <label for="cardholder">Name of Card Holder</label>
                    <input type="text" placeholder="Enter Card Holder Name" name="cardholder" class="form-control" id="cardholder" required>
                </div>
                <div class="form-group">
                    <label for="cardnumber">Enter Credit Card Number</label>
                    <input type="number" placeholder="1234-5678-1234-5678" name="cardnumber" class="form-control" id="cardnumber" required>
                </div>
                <div class="row">
                    <div class="col-md-6 form-group">
                        <label for="expmonth">Expiry Month</label>
                        <input type="number" placeholder="MM" name="expmonth" class="form-control" id="expmonth" max="12" min="01" required>
                    </div>
                    <div class="col-md-6 form-group">
                        <label for="expyear">Expiry Year</label>
                        <input type="number" placeholder="YYYY" name="expyear" class="form-control" id="expyear" required>
                    </div>
                </div>
                <div class="row text-center">
                    <div class="col-md-6 form-group">
                        <label for="cvv">Enter CVV</label>
                        <input type="number" placeholder="123" name="cvv" class="form-control" id="cvv" required>
                        <input type="hidden" name="amount" value="<%=amount%>">
                    </div>
                    <div class="col-md-6 form-group">
                        <label>&nbsp;</label>
                        <button type="submit" class="btn-submit">
                            Pay : Rs <%=amount%>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.html"%>

</body>
</html>

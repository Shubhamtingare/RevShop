package com.revature.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.revature.service.OrderService;
import com.revature.service.dao.OrderServiceImpl;
import com.revature.data.OrderDetails;

public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public OrderServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");

        if (userName == null || password == null) {
            response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
            return; // Ensure the response is terminated after redirection
        }
        
        double paidAmount = Double.parseDouble(request.getParameter("amount"));
		String status = new OrderServiceImpl().paymentSuccess(userName, paidAmount);

		PrintWriter pw = response.getWriter();
		response.setContentType("text/html");

        OrderService dao = new OrderServiceImpl();
        List<OrderDetails> orders = dao.getAllOrderDetails(userName);
        
        System.out.println(orders);
        

        request.setAttribute("orders", orders);
        
        pw.println("<script>document.getElementById('message').innerHTML='" + status + "'</script>");
        
        RequestDispatcher rd = request.getRequestDispatcher("orderDetails.jsp");
        rd.forward(request, response);
        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

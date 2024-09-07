package com.revature.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;

import com.revature.service.dao.ProductServiceImpl;

@MultipartConfig(maxFileSize = 16177215)
public class AddProductservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddProductservlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("usertype");
        String userName = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");

        if (userType == null || !userType.equals("admin")) {
            response.sendRedirect("login.jsp?message=Access Denied!");
            return;
        } else if (userName == null || password == null) {
            response.sendRedirect("login.jsp?message=Session Expired, Login Again to Continue!");
            return;
        }

        String prodName = request.getParameter("name");
        String prodType = request.getParameter("type");
        String prodInfo = request.getParameter("info");
        String prodPriceStr = request.getParameter("price");
        String prodQuantityStr = request.getParameter("quantity");

        if (prodName == null || prodType == null || prodInfo == null || prodPriceStr == null || prodQuantityStr == null) {
            response.sendRedirect("addProduct.jsp?message=All fields are required!");
            return;
        }

        double prodPrice;
        int prodQuantity;
        try {
            prodPrice = Double.parseDouble(prodPriceStr.trim());
            prodQuantity = Integer.parseInt(prodQuantityStr.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect("addProduct.jsp?message=Invalid price or quantity!");
            return;
        }

        Part part = request.getPart("image");
        InputStream inputStream = part.getInputStream();

        ProductServiceImpl product = new ProductServiceImpl();
        String status = product.addProduct(prodName, prodType, prodInfo, prodPrice, prodQuantity, inputStream);

        RequestDispatcher rd = request.getRequestDispatcher("addProduct.jsp?message=" + status);
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

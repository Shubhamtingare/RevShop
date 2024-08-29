package com.revature.service;

import java.util.List;

import com.revature.data.OrderData;
import com.revature.data.OrderDetails;
import com.revature.data.TransactionData;

public interface OrderService {
	public String paymentSuccess(String userName, double paidAmount);

	public boolean addOrder(OrderData order);

	public boolean addTransaction(TransactionData transaction);

	public int countSoldItem(String prodId);

	public List<OrderData> getAllOrders();

	public List<OrderData> getOrdersByUserId(String emailId);

	public List<OrderDetails> getAllOrderDetails(String userEmailId);

	public String shipNow(String orderId, String prodId);
}

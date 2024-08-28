package com.revature.data;

import java.io.Serializable;

public class CartData implements Serializable {
	public String userId;
	public String prodId;
	public int quantity;
	
	public CartData() {
		super();
	}

	public CartData(String userId, String prodId, int quantity) {
		super();
		this.userId = userId;
		this.prodId = prodId;
		this.quantity = quantity;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "CartData [userId=" + userId + ", prodId=" + prodId + ", quantity=" + quantity + "]";
	}
	
	
}

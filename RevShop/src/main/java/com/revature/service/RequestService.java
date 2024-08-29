package com.revature.service;

import java.util.List;

import com.revature.data.RequestData;

public interface RequestService {
	public boolean addProduct(String userId, String prodId, int demandQty);

	public boolean addProduct(RequestData userDemandBean);

	public boolean removeProduct(String userId, String prodId);

	public List<RequestData> haveDemanded(String prodId);
}

package com.revature.service;

import com.revature.data.UserData;

public interface UserService {
	public String registerUser(String userName, Long mobileNo, String emailId, String address, int pinCode,
			String password);

	public String registerUser(UserData user);

	public boolean isRegistered(String emailId);

	public String isValidCredential(String emailId, String password);

	public UserData getUserDetails(String emailId, String password);

	public String getFName(String emailId);

	public String getUserAddr(String userId);
}

package com.sist.study.dao;

import org.springframework.stereotype.Repository;

import com.sist.study.model.User;

@Repository("UserDao")
public interface UserDao {
	public User userSelect(String userId);
	
	public int findId (String userInfo);
	
	public int userInsert (User user);
	
	public int userUpdate (User user);
	
	public int pointUpdate (User user);
}
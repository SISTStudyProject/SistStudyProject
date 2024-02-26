package com.sist.study.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.study.dao.UserDao;
import com.sist.study.model.User;

@Service("UserService")
public class UserService 
{
	
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDao userDao;
	
	public User userSelect(String userId)
	{
		User user = null;
		
		try 
		{
			user = userDao.userSelect(userId);
		} 
		catch (Exception e) 
		{
			logger.error("[UserService] userSelect Exception Error" + e);
		}
		
		return user;
	}
}
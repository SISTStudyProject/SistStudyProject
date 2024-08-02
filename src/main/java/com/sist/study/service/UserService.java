package com.sist.study.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.study.dao.ShopDao;
import com.sist.study.dao.UserDao;
import com.sist.study.model.User;

@Service("UserService")
public class UserService 
{
	
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ShopDao shopDao;
	
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

	public int userInsert(User user) {
		int cnt =0;
		try {
			cnt = userDao.userInsert(user);
		}
		catch(Exception e) {
			
		}
		
		return cnt;
	}

	public int checkId(String userId) {
		int cnt =0;
		try {
			User user = userDao.userSelect(userId);
			if(user!= null) {
				cnt = 1;
			}
		}
		catch(Exception e) {
			
		}	
		return cnt;
	}
	
	public int pointUpdate (User user) {
		int cnt=0;
		try {
			cnt = userDao.pointUpdate(user);
		}
		catch(Exception e) {
			logger.debug("[UserService] pointUpdate Exception", e);
		}
		return cnt;
	}
	
	public int myItemAllDelete (String userId) {
		int cnt=0;
		try {
			cnt = shopDao.myItemAllDelete(userId);
		}
		catch(Exception e) {
			logger.debug("[UserService] myItemAllDelete Exception", e);
		}
		return cnt;
	}
}
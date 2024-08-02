package com.sist.study.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.JsonUtil;
import com.sist.common.util.StringUtil;
import com.sist.study.model.Response;
import com.sist.study.model.StPaymentApprove;
import com.sist.study.model.StPaymentCancel;
import com.sist.study.model.StUser;
import com.sist.study.model.User;
import com.sist.study.service.StUserService;
import com.sist.study.service.UserService;

import com.sist.study.model.KakaoPayCancel;
import com.sist.study.model.Paging;
import com.sist.study.model.QnaBoard;
import com.sist.study.model.ReBoard;
import com.sist.study.model.ReBoardReply;

@Controller("UserController")
public class UserController 
{
	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;
	
	@Value("#{env['auth.cookie.manager']}")
	private String AUTH_COOKIE_MANAGER;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private StUserService stUserService;

	private static final int LIST_COUNT = 5;
	private static final int PAGE_COUNT = 5;
	
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping(value="/userLogin")
	public String index(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		return "/userLogin";
	}
	
	
	@RequestMapping(value="/userLoginProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> userLoginProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> resUser = new Response<Object>();
		
		String userId = HttpUtil.get(httpServletRequest, "userId");
		String userPwd = HttpUtil.get(httpServletRequest, "userPwd");

		User user = userService.userSelect(userId);
		
		if(user != null){
			if(user.getStatus().equals("Y")) {
				if(userPwd.equals(user.getUserPwd())) {
					CookieUtil.addCookie(httpServletResponse, "/", -1, AUTH_COOKIE_USER, CookieUtil.stringToHex(userId));
					resUser.setResponse(0, "success");
				}
				else {
					resUser.setResponse(405, "pwd not match");
				}
				
			}
			else {
				resUser.setResponse(403, "state prob");
			}
		}
		else{
			resUser.setResponse(404, "fail");
		}
		
		if(logger.isDebugEnabled()){
			logger.debug("\n" + JsonUtil.toJsonPretty(resUser));
		}
		return resUser;
	}
	
	//회원가입
	@RequestMapping (value="regProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> regProc (HttpServletRequest request, HttpServletResponse response){
		Response<Object> ajaxRes = new Response<Object>();
		String userId = HttpUtil.get(request, "userId","");
		String userPwd = HttpUtil.get(request, "userPwd","");
		String userName = HttpUtil.get(request, "userName","");
		String userEmail = HttpUtil.get(request, "userEmail","");
		
		if(!userId.isEmpty() && !userPwd.isEmpty()
				&& !userName.isEmpty() && !userEmail.isEmpty()) {
			User tmpUser = new User();
			tmpUser.setUserId(userId);
			
			if(userService.userSelect(userId)==null) {
				
				User user = new User();
				user.setUserId(userId);
				user.setUserPwd(userPwd);
				user.setUserName(userName);
				user.setUserEmail(userEmail);
				user.setStatus("Y");
				
				if(userService.userInsert(user)>0) {
					ajaxRes.setResponse(0, "success");
				}
				else {
					ajaxRes.setResponse(100, "there is error");
				}
				
			}
			else {
				//중복된 아이디
				ajaxRes.setResponse(300, "already used id");
			}
		}
		else {
			ajaxRes.setResponse(400, "bad Request");
		}
		logger.debug("++++++++++ajaxRes.getCode():"+ajaxRes.getCode());
		return ajaxRes;
	}
	@RequestMapping(value="/idcheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> idcheck (HttpServletRequest request, HttpServletResponse response){
		Response<Object> res = new Response<Object>();
		String userId = HttpUtil.get(request, "userId","");
		if(!userId.isEmpty()) {
			int cnt = userService.checkId(userId);
			if(cnt>0) {
				res.setResponse(-1, "already exist");
			}
			else {
				res.setResponse(0, "success");
			}
		}
		else {
			res.setResponse(500, "error");
		}
		logger.debug("res.getResponse : "+res.getCode());
		return res;
	}
	
	@RequestMapping (value="/logOut", method=RequestMethod.GET)
	public String loginOut2 (HttpServletRequest request, HttpServletResponse response) {
		if(CookieUtil.getCookie(request, AUTH_COOKIE_USER)!= null) {
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_USER);
		}
		return "redirect:/";
	}
}

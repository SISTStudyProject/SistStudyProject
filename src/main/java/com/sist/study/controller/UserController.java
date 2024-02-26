package com.sist.study.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("UserController")
public class UserController 
{
	@RequestMapping(value="/index")
	public String index(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		return "/index";
	}
}

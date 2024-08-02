package com.sist.study.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.study.model.ItemData;
import com.sist.study.model.Paging;
import com.sist.study.service.ShopService;

@Controller("IndexController")
public class IndexController 
{
	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;

	@Autowired
	private ShopService shopService;

	private static final long LIST_CNT = 12;
	private static final long PAGE_CNT = 5;

	private static Logger logger = LoggerFactory.getLogger(IndexController.class);
	
	@RequestMapping(value="/main")
	public String mainIndex(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
	      
		return "/main";
	}
	
	@RequestMapping(value="/index")
	public String index(HttpServletRequest request, HttpServletResponse httpServletResponse,Model model){
		String userCookie = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		logger.info("userCookie : "+userCookie);
		request.setAttribute(AUTH_COOKIE_USER, userCookie);
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		model.addAttribute("userCookie", cookieUserId);

		String userId = HttpUtil.get(request, "userId", "");
		int itemSeq = HttpUtil.get(request, "itemSeq", 0);
		int curPage = HttpUtil.get(request, "curpage", 1);
		String sortBy = HttpUtil.get(request, "sortBy", "");
		String itemCate = HttpUtil.get(request, "itemCate", "");

		ItemData itemRequest = new ItemData();
		List<ItemData> itemList = null;
		Paging paging = null;
		long totalCnt = 0;

//		if(!StringUtil.isEmpty(cookieUserId)) {
//			if(StringUtil.equals(cookieUserId, userId)) {
//				
//			}
//		}
		
		itemRequest.setItemCate(itemCate);
		totalCnt = shopService.itemListCnt(itemRequest);
		
		logger.debug("카테고리 ------ " + itemCate);
//		totalCnt = 65;	// 페이징 처리 확인용

		if (totalCnt > 0) {
			paging = new Paging("/shop/shop", totalCnt, LIST_CNT, PAGE_CNT, curPage, "curpage");

			logger.debug("paging.getStartRow ------ " + paging.getStartRow());
			logger.debug("paging.getEndRow ------ " + paging.getEndRow());

			itemRequest.setStartRow(paging.getStartRow());
			itemRequest.setEndRow(paging.getEndRow());
			itemRequest.setSortBy(sortBy);

			itemList = shopService.itemDataList(itemRequest);
		}

		model.addAttribute("itemList", itemList);
		model.addAttribute("paging", paging);
		model.addAttribute("curPage", curPage);
		model.addAttribute("sortBy", sortBy);
		model.addAttribute("itemCate", itemCate);
		return "/index";
	}
}

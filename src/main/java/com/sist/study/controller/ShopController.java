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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.StringUtil;
import com.sist.study.model.ItemData;
import com.sist.study.model.Paging;
import com.sist.study.model.User;
import com.sist.study.service.ReBoardService;
import com.sist.study.service.ShopService;
import com.sist.study.service.UserService;

@Controller("shopController")
public class ShopController {

	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;

	@Value("#{env['auth.cookie.manager']}")
	private String AUTH_COOKIE_MANAGER;

	@Autowired
	private ShopService shopService;

	@Autowired
	private UserService userService;

	@Autowired
	private ReBoardService reboardService;

	private static final long LIST_CNT = 12;
	private static final long PAGE_CNT = 5;

	private static Logger logger = LoggerFactory.getLogger(UserController.class);

	// 상품 리스트 화면
	@RequestMapping(value = "/shop/shop")
	public String shop(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

		String stUserCookie = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		String stManagerCookie = CookieUtil.getHexValue(request, AUTH_COOKIE_MANAGER);

		String userId = HttpUtil.get(request, "userId", "");
		int itemSeq = HttpUtil.get(request, "itemSeq", 0);
		int curPage = HttpUtil.get(request, "curpage", 1);
		String sortBy = HttpUtil.get(request, "sortBy", "newness");
		String itemCate = HttpUtil.get(request, "itemCate", "");

		ItemData itemRequest = new ItemData();
		List<ItemData> itemList = null;
		Paging paging = null;
		long totalCnt = 0;
		User user = null;
		int cartTotalCnt = 0;

		if (!StringUtil.isEmpty(stUserCookie)) {
			user = userService.userSelect(stUserCookie);
			if (user != null) {
				cartTotalCnt = shopService.myCartTotalCnt(stUserCookie);
			}
		}

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

		model.addAttribute("stUserCookie", stUserCookie);
		model.addAttribute("stManagerCookie", stManagerCookie);
		model.addAttribute("itemList", itemList);
		model.addAttribute("paging", paging);
		model.addAttribute("curPage", curPage);
		model.addAttribute("sortBy", sortBy);
		model.addAttribute("itemCate", itemCate);
		model.addAttribute("user", user);
		model.addAttribute("cartTotalCnt", cartTotalCnt);
		return "/shop/shop";
	}

	// 상품상세 화면
	@RequestMapping(value = "/shop/single")
	public String single(@RequestParam(value = "itemSeq", required = false, defaultValue = "0") long itemSeq,
						 ModelMap model, HttpServletRequest request, HttpServletResponse response) {

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		int curPage = HttpUtil.get(request, "curpage", 1);
		String sortBy = HttpUtil.get(request, "sortBy", "");
		String itemCate = HttpUtil.get(request, "itemCate", "");
		long reboardTotal = 0;

		ItemData itemData = null;
		List<ItemData> itemRecList = null;
		User user = null;
		int cartTotalCnt = 0;

		if (!StringUtil.isEmpty(cookieUserId)) {
			user = userService.userSelect(cookieUserId);
			if (user != null) {
				cartTotalCnt = shopService.myCartTotalCnt(cookieUserId);
			}
		}

		 if (itemSeq > 0) {
	         itemData = shopService.itemDetailSelect(itemSeq);
	         itemRecList = shopService.itemRecItem();
	         reboardTotal = reboardService.reBoardTotal(itemSeq);
	      }

	      model.addAttribute("itemSeq", itemSeq);
	      model.addAttribute("itemData", itemData);
	      model.addAttribute("itemRecList", itemRecList);
	      model.addAttribute("user", user);
	      model.addAttribute("cartTotalCnt", cartTotalCnt);
	      model.addAttribute("reboardTotal", reboardTotal);
	      
	      logger.debug("[shop/single] itemSeq -- " + itemSeq );

		return "/shop/single";
	}
	
	// 장바구니 화면
	@RequestMapping(value = "/shop/myCart")
	public String myCart(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		User user = userService.userSelect(cookieUserId);
		List<ItemData> list = null;
		int cartTotalCnt = 0;
		
		if (!StringUtil.isEmpty(cookieUserId) && user != null) {
			list = shopService.myCartList(cookieUserId);
			cartTotalCnt = shopService.myCartTotalCnt(cookieUserId);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("user", user);
		model.addAttribute("cartTotalCnt", cartTotalCnt);

		return "/shop/myCart";
	}

	// 상품 장바구니 담기 Proc
	@RequestMapping(value = "/addToCartProc")
	@ResponseBody
	public int addToCartProc(@RequestParam(value = "itemSeq", required = false, defaultValue = "0") long itemSeq,
			@RequestParam(value = "itemNum", required = false, defaultValue = "1") int itemNum, ModelMap model,
			HttpServletRequest request, HttpServletResponse response) {

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);

		int resCode = 0;
		User user = null;
		ItemData itemData = null;
		int chkNum = 0;

		if (!StringUtil.isEmpty(cookieUserId)) {
			user = userService.userSelect(cookieUserId);
			if (user != null) {
				if (itemSeq > 0) {
					itemData = shopService.itemDetailSelect(itemSeq);
					if (itemData != null) {
						itemData.setUserId(cookieUserId);
						itemData.setItemSeq(itemSeq);
						itemData.setItemNum(itemNum);

						chkNum = shopService.chkCartCnt(itemData);
						if (chkNum > 0) {
							resCode = 111;
						} else {
							if (shopService.itemAddCart(itemData) > 0) {
								resCode = 200;
							} else {
								resCode = 500;
							}
						}
					} else {
						resCode = 401;
					}
				} else {
					resCode = 400;
				}
			} else {
				resCode = 301;
			}
		} else {
			resCode = 300;
		}

		logger.debug("addToCartProc 도착");
		logger.debug("cookieUserId -- " + cookieUserId);
		logger.debug("itemSeq -- " + itemSeq);
		logger.debug("오류 코드 resCode -- " + resCode);

		model.addAttribute("itemSeq", itemSeq);

		return resCode;
	}

	// 상품 장바구니 갯수 변경
	@RequestMapping(value = "/itemNumUpdateProc")
	@ResponseBody
	public int itemNumUpdateProc(@RequestParam(value = "itemSeq", required = false, defaultValue = "0") long itemSeq,
			@RequestParam(value = "itemNum", required = false, defaultValue = "0") int itemNum,
			@RequestParam(value = "itemAddNum", required = false, defaultValue = "1") int itemAddNum, ModelMap model,
			HttpServletRequest request, HttpServletResponse response) {

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);

		int resCode = 0;
		User user = null;
		ItemData itemData = null;
		int curItemNum = 0;

		if (!StringUtil.isEmpty(cookieUserId)) {
			user = userService.userSelect(cookieUserId);
			if (user != null) {
				if (itemSeq > 0) {
					itemData = new ItemData();
					itemData.setUserId(cookieUserId);
					itemData.setItemSeq(itemSeq);

					if (itemNum > 0) {
						itemData.setItemNum(itemNum);
						if (shopService.itemNumUpdate(itemData) > 0) {
							resCode = 200;
						} else {
							resCode = 500;
						}
					} else {
						curItemNum = shopService.myCartItemNum(itemData);
						itemData.setItemNum(curItemNum + itemAddNum);
						if (shopService.itemNumUpdate(itemData) > 0) {
							resCode = 201;
						} else {
							resCode = 501;
						}
					}

				} else {
					resCode = 400;
				}
			} else {
				resCode = 301;
			}
		} else {
			resCode = 300;
		}

		logger.debug("[itemNumUpdateProc] cookieUserId -- " + cookieUserId);
		logger.debug("[itemNumUpdateProc] itemSeq -- " + itemSeq);
		logger.debug("[itemNumUpdateProc] itemNum -- " + itemNum);
		logger.debug("[itemNumUpdateProc] 오류 코드 resCode -- " + resCode);

		model.addAttribute("itemSeq", itemSeq);

		return resCode;
	}

	// 상품 장바구니 상품 삭제
	@RequestMapping(value = "/itemDeleteProc")
	@ResponseBody
	public int itemDeleteProc(@RequestParam(value = "itemSeq", defaultValue = "0") long itemSeq,
							  @RequestParam(value = "itemSeqList", required = false) List<Long> itemSeqList,
							  ModelMap model, HttpServletRequest request, HttpServletResponse response) {

		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);

		int resCode = 0;
		User user = null;
		ItemData itemData = null;

		if (!StringUtil.isEmpty(cookieUserId)) {
			user = userService.userSelect(cookieUserId);
			if (user != null) {
				if (itemSeq > 0) {
					itemData = new ItemData();
					itemData.setUserId(cookieUserId);
					itemData.setItemSeq(itemSeq);
					if (shopService.myItemDelete(itemData) > 0) {
						resCode = 200;
					} else {
						resCode = 500;
					}
				} else {
					resCode = 400;
				}
			} else {
				resCode = 301;
			}
		} else {
			resCode = 300;
		}
		
		//logger.info("[itemDeleteProc] itemSeqList -- " + itemSeqList.size());
		logger.debug("[itemDeleteProc] cookieUserId -- " + cookieUserId);
		logger.debug("[itemDeleteProc] itemSeq -- " + itemSeq);
		logger.debug("오류 코드 resCode -- " + resCode);

		return resCode;
	}

}

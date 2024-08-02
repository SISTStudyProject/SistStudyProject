package com.sist.study.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.sist.common.util.StringUtil;
import com.sist.study.model.ItemData;
import com.sist.study.model.KakaoPayApprove;
import com.sist.study.model.KakaoPayOrder;
import com.sist.study.model.KakaoPayReady;
import com.sist.study.model.PaymentApprove;
import com.sist.study.model.Response;
import com.sist.study.model.User;
import com.sist.study.service.KakaoPayService;
import com.sist.study.service.ShopService;
import com.sist.study.service.UserService;
import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;

@Controller("kakaoPayController")
public class KakaoPayController {

	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;

	private static Logger logger = LoggerFactory.getLogger(KakaoPayController.class);

	@Autowired
	private KakaoPayService KakaoPayService;
	@Autowired
	private UserService userService;
	@Autowired
	private ShopService shopService;

	@RequestMapping(value = "/shop/payment")
	public String pay(Model model, HttpServletRequest request, HttpServletResponse response) {
		String cookieId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		long totalPrice = 0;

		// logger.debug("cookieId : "+cookieId);

		if (cookieId != null) {
			User user = userService.userSelect(cookieId);
			if (user != null) {
				model.addAttribute("user", user);
			} else {
				logger.debug("user 는 null 입니다~");
			}
		}

		// int itemSeq = HttpUtil.get(request, "itemSeq", 0);
//		수정완
		List<ItemData> itemSeqList = null;

		if(cookieId != null) {
			itemSeqList = shopService.myCartList(cookieId);	
		}

		if (itemSeqList != null) {
			model.addAttribute("itemList",itemSeqList);
			for(int i=0;i<itemSeqList.size();i++) {
				totalPrice += ((itemSeqList.get(i).getItemPrice())*(itemSeqList.get(i).getItemNum()));
				logger.debug("totalPrice : "+ totalPrice);
			}
			
			if (totalPrice > 0) {
				logger.debug("totalPrice : "+ totalPrice);
				model.addAttribute("totalPrice", totalPrice);
			}
		}
		else {
			logger.debug("itemSeqList is null");
		}

		// seq로 item data 뽑아오기

		return "/shop/payment";
	}

	@RequestMapping(value = "/kakao/payReady", method = RequestMethod.POST)
	@ResponseBody
	public Response<Object> payReady(HttpServletRequest request, HttpServletResponse response,
			@RequestBody  Map<String, Object> jsonData) {
		Response<Object> ajaxRes = new Response<Object>();

		String orderId = StringUtil.uniqueValue(); // 자체 주문번호
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount", 0);
		int vatAmount = HttpUtil.get(request, "vatAmount", 0);

		List<KakaoPayOrder> kakaoList = new ArrayList<KakaoPayOrder>();
		
		List<Map<String, String>> orderList = (List<Map<String, String>>) jsonData.get("orderList");
		String totalAmountStr = (String) jsonData.get("totalAmount");
        int totalAmount = Integer.parseInt(totalAmountStr);
        
        
        
        
        for (Map<String, String> itemMap : orderList) {
            String itemName = itemMap.get("itemName");
            String itemPriceStr = itemMap.get("itemPrice");
            int itemPrice = Integer.parseInt(itemPriceStr); // itemPrice는 문자열로 전달되므로 숫자로 변환 필요

            logger.debug("주문 항목: " + itemName + ", " + itemPrice);
        }

		int quantity = orderList.size();


		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.setItemCode(orderList.get(0).get("itemCode"));
		kakaoPayOrder.setItemName(orderList.get(0).get("itemName")+" 외 "+(orderList.size()-1)+"건");
		kakaoPayOrder.setQuantity(orderList.size());
		kakaoPayOrder.setTotalAmount(totalAmount);
		kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
		kakaoPayOrder.setVatAmount(vatAmount);

		KakaoPayReady ready = KakaoPayService.kakaoPayReady(kakaoPayOrder);

		if (ready != null) {
			logger.debug("[KakaoPayController] payReady:" + ready);

			kakaoPayOrder.settId(ready.getTid());

			JsonObject json = new JsonObject();
			json.addProperty("orderId", orderId);
			json.addProperty("tId", ready.getTid());
			json.addProperty("appUrl", ready.getNext_redirect_app_url());
			json.addProperty("mobileUrl", ready.getNext_redirect_mobile_url());
			json.addProperty("pcUrl", ready.getNext_redirect_pc_url());
			json.addProperty("itemName",kakaoPayOrder.getItemName());
			json.addProperty("itemCode",kakaoPayOrder.getItemCode());
			json.addProperty("totalAmaount",kakaoPayOrder.getTotalAmount());

			ajaxRes.setResponse(0, "success", json);

		} else {
			ajaxRes.setResponse(-1, "fail", null);
		}

		return ajaxRes;
	}

	@RequestMapping(value = "/kakao/payPopUp", method = RequestMethod.POST)
	public String payPopUp(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String pcUrl = HttpUtil.get(request, "pcUrl", "");
		String orderId = HttpUtil.get(request, "orderId", "");
		String tId = HttpUtil.get(request, "tId", "");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		String totalAmaount = HttpUtil.get(request, "totalAmaount", "");
		
		long point = HttpUtil.get(request, "point", 0);
		
		model.addAttribute("pcUrl", pcUrl);
		model.addAttribute("orderId", orderId);
		model.addAttribute("tId", tId);
		model.addAttribute("userId", userId);
		model.addAttribute("totalAmaount",totalAmaount);
		
		model.addAttribute("point",point);

		return "/kakao/payPopUp";
	}

	@RequestMapping(value = "/kakao/paySuccess")
	public String paySuccess(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String pgToken = HttpUtil.get(request, "pg_token", ""); // kakao에서 보내주는 것.
		model.addAttribute("pgToken", pgToken);

		logger.debug("++++++++++++++++++++++++++++++++++++++++++");
		logger.debug("pgToken:" + pgToken);
		return "/kakao/paySuccess";
	}

	@RequestMapping(value = "/kakao/payResult")
	public String payResult(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
	{
		KakaoPayApprove kakaoPayApprove = null;
		String tId = HttpUtil.get(request, "tId", "");
		String orderId = HttpUtil.get(request, "orderId", "");
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		String pgToken = HttpUtil.get(request, "pgToken", "");
		String itemCode = HttpUtil.get(request, "itemCode", "");
		String ItemName = HttpUtil.get(request, "ItemName", "");
		String total = HttpUtil.get(request, "totalAmaount", "");
		
		long point = HttpUtil.get(request, "point", 0);
		
		int totalAmount=0;
		
		if(total != null && !StringUtil.isEmpty(total)) 
		{
			logger.debug("=====================================total : "+total);
			totalAmount = Integer.parseInt(total);
		}

		KakaoPayOrder order = new KakaoPayOrder();

		order.setPartnerOrderId(orderId);
		order.setPartnerUserId(userId);
		order.settId(tId);
		order.setPgToken(pgToken);

		kakaoPayApprove = KakaoPayService.kakaoPayApprove(order);
		model.addAttribute("approve", kakaoPayApprove);
		
		//상품구매 인서트
		List<ItemData> itemList = null;
		itemList = shopService.myCartList(userId);
		if(itemList != null) 
		{
			int cnt = 0;
			
			int totalAmountValue = kakaoPayApprove.getAmount().getTotal();
			
			for(int i = 0; i < itemList.size(); i++) 
			{
				PaymentApprove pa = new PaymentApprove();				
				if(itemList.size() > 1)
				{
					if(i+1 == itemList.size())
					{
						pa.setCid(kakaoPayApprove.getCid());
						pa.setTid(tId);
						pa.setOrderId(StringUtil.uniqueValue());
						pa.setUserId(userId);
						pa.setItemCode(Long.toString(itemList.get(i).getItemSeq()));
						pa.setItemName(itemList.get(i).getItemName());
						pa.setTotalAmaount(totalAmountValue);
						pa.setTaxFreeAmount(0);
						pa.setPoint(point);
						pa.setStatus("N");	
					}
					else
					{
						pa.setCid(kakaoPayApprove.getCid());
						pa.setTid(tId);
						pa.setOrderId(StringUtil.uniqueValue());
						pa.setUserId(userId);
						pa.setItemCode(Long.toString(itemList.get(i).getItemSeq()));
						pa.setItemName(itemList.get(i).getItemName());
						totalAmountValue = totalAmountValue - (int) itemList.get(i).getItemPrice();
						pa.setTotalAmaount((int) itemList.get(i).getItemPrice());
						pa.setTaxFreeAmount(0);
						pa.setStatus("N");
					}
				}
				else
				{
					pa.setCid(kakaoPayApprove.getCid());
					pa.setTid(tId);
					pa.setOrderId(orderId);
					pa.setUserId(userId);
					pa.setItemCode(Long.toString(itemList.get(i).getItemSeq()));
					pa.setItemName(itemList.get(i).getItemName());
					pa.setTotalAmaount(totalAmountValue);
					pa.setTaxFreeAmount(0);
					pa.setPoint(point);
					pa.setStatus("N");

				}
				
				cnt = KakaoPayService.paymentInsert(pa);
				logger.debug("====================cnt :"+cnt+" =======================");
			}
			
			if(cnt > 0) {
				//장바구니 삭제
				int dCnt = userService.myItemAllDelete(userId);
				if(dCnt >0) {
					logger.debug("dCnt : "+dCnt);
				}
			}
		}
		//인서트 끝
		
		
		
		
		if(totalAmount != 0) 
		{
			int plusPoint = (int)(totalAmount*0.1);
			
			User user = new User();
			user = userService.userSelect(userId);
			user.setUserPoint((user.getUserPoint() - (int) point) + plusPoint);
			
			int cnt = userService.pointUpdate(user);
			logger.debug("====================point cnt :"+cnt+" =======================");
		}

		return "/kakao/payResult";
	}
	
	@RequestMapping(value = "/kakao/payClear")
	public String payClear(HttpServletRequest request, HttpServletResponse response) {

		return "/kakao/payClear";
	}
 

	// 결제 취소시
	@RequestMapping(value = "/kakao/payCancel")
	public String payCancel(HttpServletRequest request, HttpServletResponse response) {

		return "/kakao/payCancel";
	}

	// 결제 실패시
	@RequestMapping(value = "/kakao/payFail")
	public String payFail(HttpServletRequest request, HttpServletResponse response) {
		return "/kakao/payFail";
	}
}
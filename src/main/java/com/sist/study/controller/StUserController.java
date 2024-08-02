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

@Controller("StUserController")
public class StUserController 
{
	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;
	
	@Value("#{env['auth.cookie.manager']}")
	private String AUTH_COOKIE_MANAGER;
	
	@Autowired
	private StUserService stUserService;

	private static final int LIST_COUNT = 5;
	private static final int PAGE_COUNT = 5;
	
	private static Logger logger = LoggerFactory.getLogger(UserController.class);

	@RequestMapping(value="/user/mypage")
	public String userMypage(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stUserCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		StUser stUser = null;
		
		if(!StringUtil.isEmpty(stUserCookie))
		{
			stUser = stUserService.stUserSelect(stUserCookie);
			
			if(stUser != null)
			{
				modelMap.addAttribute("stUser", stUser);
			}
			else
			{
				modelMap.addAttribute("stUser", null);
			}
		}
		else
		{
			modelMap.addAttribute("stUser", null);
		}
		
		modelMap.addAttribute("stUserCookie", stUserCookie);
		return "/user/userInformation";
	}
	
	@RequestMapping(value="/user/mypage/informationchange")
	public String userMypageUserInformationChange(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stUserCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		StUser stUser = null;
		
		if(!StringUtil.isEmpty(stUserCookie))
		{
			stUser = stUserService.stUserSelect(stUserCookie);
			
			if(stUser != null)
			{
				modelMap.addAttribute("stUser", stUser);
			}
			else
			{
				modelMap.addAttribute("stUser", null);
			}
		}
		else
		{
			modelMap.addAttribute("stUser", null);
		}
		
		modelMap.addAttribute("stUserCookie", stUserCookie);
		return "/user/userInformationchange";
	}
	
	@ResponseBody
	@PostMapping(value = "/user/userInformationChangeProc")
	public Response<Object> userInformationChangeProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		
		String userId = HttpUtil.get(httpServletRequest, "userId", "");
		String userPwd = HttpUtil.get(httpServletRequest, "userPwd", "");
		String userName = HttpUtil.get(httpServletRequest, "userName", "");
		String userEmail = HttpUtil.get(httpServletRequest, "userEmail", "");
		String userTel = HttpUtil.get(httpServletRequest, "userTel", "");
		String userBirth = HttpUtil.get(httpServletRequest, "userBirth", "");
		String userAddress = HttpUtil.get(httpServletRequest, "userAddress", "");
		
		StUser stUser = null;
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userTel) && !StringUtil.isEmpty(userBirth) && !StringUtil.isEmpty(userAddress))
		{
			stUser = stUserService.stUserSelect(userId);
			
			if(stUser != null)
			{
				stUser.setUserPwd(userPwd);
				stUser.setUserName(userName);
				stUser.setUserEmail(userEmail);
				stUser.setUserTel(userTel);
				stUser.setUserBirth(userBirth);
				stUser.setUserAddress(userAddress);
				
				if(stUserService.stUserUpdate(stUser) > 0)
				{
					ajaxObject.setResponse(200, "Ok");
				}
				else
				{
					ajaxObject.setResponse(500, "Internal Server Error");	
				}
			}
			else
			{
				ajaxObject.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
		}
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] userInformationChangeProc response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}
		
		return ajaxObject;
	}
	
	@ResponseBody
	@PostMapping(value = "/user/userResign")
	public Response<Object> userResignProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		
		String userId = HttpUtil.get(httpServletRequest, "userId", "");
		StUser stUser = null;
		
		if(!StringUtil.isEmpty(userId))
		{
			stUser = stUserService.stUserSelect(userId);
			
			if(stUser != null)
			{
				stUser.setStatus("Q");
				
				if(stUserService.stUserResign(stUser) > 0)
				{
					CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_USER);
					ajaxObject.setResponse(200, "Ok");
				}
				else
				{
					ajaxObject.setResponse(500, "Internal Server Error");	
				}
			}
			else
			{
				ajaxObject.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
		}
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] userResignProc response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}
		
		return ajaxObject;
	}
	
	@RequestMapping(value="/user/mypage/paymentlist")
	public String userMypageUserPaymentList(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stUserCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		long curPage1 = HttpUtil.get(httpServletRequest, "curPage1", 1);
		long curPage2 = HttpUtil.get(httpServletRequest, "curPage2", 1);
		
		List<StPaymentApprove> stPaymentApproveList = null;
		StPaymentApprove stPaymentApprove = null;
		Paging stPaymentApprovePaging = null;
		
		List<StPaymentCancel> stPaymentCancelList = null;
		StPaymentCancel stPaymentCancel = null;
		Paging stPaymentCancelPaging = null;
		
		StUser stUser = stUserService.stUserSelect(stUserCookie);
		
		if(stUser != null)
		{
			long stPaymentApproveCount = stUserService.stPaymentApproveListCount(stUserCookie);
			long stPaymentCancelCount = stUserService.stPaymentCancelListCount(stUserCookie);
			
			if(stPaymentApproveCount > 0)
			{
				stPaymentApprovePaging = new Paging("/user/mypage/paymentlist", stPaymentApproveCount, LIST_COUNT, PAGE_COUNT, curPage1, "curPage1");
				
				stPaymentApprove = new StPaymentApprove();
				stPaymentApprove.setPartnerUserId(stUser.getUserId());
				stPaymentApprove.setStartRow(stPaymentApprovePaging.getStartRow());
				stPaymentApprove.setEndRow(stPaymentApprovePaging.getEndRow());
				
				stPaymentApproveList = stUserService.stPaymentApproveList(stPaymentApprove);
			}
			
			if(stPaymentCancelCount > 0)
			{
				stPaymentCancelPaging = new Paging("/user/mypage/paymentlist", stPaymentCancelCount, LIST_COUNT, PAGE_COUNT, curPage2, "curPage2");
				
				stPaymentCancel = new StPaymentCancel();
				stPaymentCancel.setPartnerUserId(stUser.getUserId());
				stPaymentCancel.setStartRow(stPaymentCancelPaging.getStartRow());
				stPaymentCancel.setEndRow(stPaymentCancelPaging.getEndRow());
				
				stPaymentCancelList = stUserService.stPaymentCancelList(stPaymentCancel);
			}
			
			modelMap.addAttribute("stPaymentApproveList", stPaymentApproveList);
			modelMap.addAttribute("stPaymentCancelList", stPaymentCancelList);
			modelMap.addAttribute("stPaymentApprovePaging", stPaymentApprovePaging);
			modelMap.addAttribute("stPaymentCancelPaging", stPaymentCancelPaging);
			
		}
		else
		{
			modelMap.addAttribute("stUser", null);
		}
		
		modelMap.addAttribute("stUserCookie", stUserCookie);
		return "/user/userPaymentlist";
	}
	
	
	//결제취소
	@ResponseBody
	@PostMapping(value="/user/mypage/paymentCancelProc")
	public Response<Object> userPaymentCancelProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		
		String partnerOrderId = HttpUtil.get(httpServletRequest, "partnerOrderId", "");
		StPaymentApprove stPaymentApprove = null;
		
		if(!StringUtil.isEmpty(partnerOrderId))
		{
			stPaymentApprove = stUserService.stPaymentApproveSelect(partnerOrderId);
			
			if(stPaymentApprove != null)
			{
				KakaoPayCancel kakaoPayCancel = stUserService.kakaoPayCancel(stPaymentApprove);
				
				if(kakaoPayCancel != null)
				{
					StPaymentCancel stPaymentCancel = new StPaymentCancel();
					
					stPaymentCancel.setCid(kakaoPayCancel.getCid());
					stPaymentCancel.setTid(kakaoPayCancel.getTid());
					stPaymentCancel.setPartnerOrderId(stPaymentApprove.getPartnerOrderId());
					stPaymentCancel.setPartnerUserId(stPaymentApprove.getPartnerUserId());
					stPaymentCancel.setItemCode(stPaymentApprove.getItemCode());
					stPaymentCancel.setItemName(stPaymentApprove.getItemName());
					stPaymentCancel.setCancelTotalAmount(stPaymentApprove.getTotalAmount());
					stPaymentCancel.setCancelTaxFreeAmount(kakaoPayCancel.getAmount().getTax_free());
					
					stPaymentApprove.setStatus('C');
					
					if(stUserService.stPaymentApproveUpdate(stPaymentApprove) > 0 && stUserService.stPaymentCancelInsert(stPaymentCancel) > 0)
					{
						StUser stUser = stUserService.stUserSelect(kakaoPayCancel.getPartner_user_id());
						stUser.setUserPoint((stUser.getUserPoint() - (long) (stPaymentApprove.getTotalAmount() * 0.1)) + stPaymentApprove.getPoint());
						
						if(stUserService.stUserPointUpdate(stUser) > 0)
						{
							ajaxObject.setResponse(200, "Ok");
						}
						else
						{
							ajaxObject.setResponse(500, "Internal Server Error");
						}
					}
					else
					{
						ajaxObject.setResponse(500, "Internal Server Error");
					}
				}
				else
				{
					ajaxObject.setResponse(500, "Internal Server Error");
				}
				
			}
			else
			{
				ajaxObject.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] userPaymentCancelProc response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}
		
		return ajaxObject;
	}
	
	@RequestMapping(value="/user/mypage/reviewlist")
	public String userMypageUserReviewList(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stUserCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		long curPage1 = HttpUtil.get(httpServletRequest, "curPage1", 1);
		long curPage2 = HttpUtil.get(httpServletRequest, "curPage2", 1);
		
		List<ReBoard> reBoardList = null;
		ReBoard reBoard = null;
		Paging reBoardPaging = null;
		
		List<ReBoardReply> reBoardReplyList = null;
		ReBoardReply reBoardReply = null;
		Paging reBoardReplyPaging = null;
		
		StUser stUser = stUserService.stUserSelect(stUserCookie);
		
		if(stUser != null)
		{
			reBoard = new ReBoard();
			reBoard.setUserId(stUser.getUserId());
			
			reBoardReply = new ReBoardReply();
			reBoardReply.setUserId(stUser.getUserId());
			
			long reBoardCount = stUserService.stUserReviewListCount(reBoard);
			long reBoardReplyCount = stUserService.stUserReplyListCount(reBoardReply);
			
			if(reBoardCount > 0)
			{
				reBoardPaging = new Paging("/user/mypage/reviewlist", reBoardCount, LIST_COUNT, PAGE_COUNT, curPage1, "curPage1");
				
				reBoard.setStartRow(reBoardPaging.getStartRow());
				reBoard.setEndRow(reBoardPaging.getEndRow());
				
				reBoardList = stUserService.stUserReviewList(reBoard);
			}
			
			if(reBoardReplyCount > 0)
			{
				reBoardReplyPaging = new Paging("/user/mypage/reviewlist", reBoardReplyCount, LIST_COUNT, PAGE_COUNT, curPage2, "curPage2");
				reBoardReply.setStartRow(reBoardReplyPaging.getStartRow());
				reBoardReply.setEndRow(reBoardReplyPaging.getEndRow());
				
				reBoardReplyList = stUserService.stUserReplyList(reBoardReply);
			}

			modelMap.addAttribute("reBoardList", reBoardList);
			modelMap.addAttribute("reBoardReplyList", reBoardReplyList);
			modelMap.addAttribute("reBoardPaging", reBoardPaging);
			modelMap.addAttribute("reBoardReplyPaging", reBoardReplyPaging);
			
		}
		else
		{
			modelMap.addAttribute("stUser", null);
		}
		
		modelMap.addAttribute("stUserCookie", stUserCookie);
		return "/user/userReviewList";
	}
	
	@RequestMapping(value="/user/mypage/qnalist")
	public String userMypageUserQnaList(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stUserCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_USER);
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		
		List<QnaBoard> qnaBoardList = null;
		QnaBoard qnaBoard = null;
		Paging paging = null;
		
		StUser stUser = stUserService.stUserSelect(stUserCookie);

		if(stUser != null)
		{
			qnaBoard = new QnaBoard();
			qnaBoard.setUserId(stUser.getUserId());
			
			long qnaBoardCount = stUserService.stUserQnaBoardListCount(qnaBoard);
			
			if(qnaBoardCount > 0)
			{
				paging = new Paging("/user/mypage/qnalist", qnaBoardCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
				
				qnaBoard.setStartRow(paging.getStartRow());
				qnaBoard.setEndRow(paging.getEndRow());
				
				qnaBoardList = stUserService.stUserQnaBoardList(qnaBoard);
			}
			
			modelMap.addAttribute("qnaBoardList", qnaBoardList);
			modelMap.addAttribute("paging", paging);			
		}
		else
		{
			modelMap.addAttribute("stUser", null);
		}
		
		modelMap.addAttribute("stUserCookie", stUserCookie);
		
		return "/user/userQnaList";
	}
	

}

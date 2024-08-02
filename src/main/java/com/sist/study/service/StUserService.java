package com.sist.study.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.sist.study.dao.StUserDao;
import com.sist.study.model.KakaoPayCancel;
import com.sist.study.model.QnaBoard;
import com.sist.study.model.ReBoard;
import com.sist.study.model.ReBoardReply;
import com.sist.study.model.StPaymentApprove;
import com.sist.study.model.StPaymentCancel;
import com.sist.study.model.StUser;

@Service("StUserService")
public class StUserService 
{
	private static Logger logger = LoggerFactory.getLogger(StUserService.class);
	
	
	//kakaoPay host
	@Value("#{env['kakao.pay.host']}")
	private String KAKAO_PAY_HOST;
	
	//kakaoPay adminKey
	@Value("#{env['kakao.pay.admin.key']}")
	private String KAKAO_PAY_ADMIN_KEY;
	
	//kakaoPay 가맹점 code
	@Value("#{env['kakao.pay.cid']}")
	private String KAKAO_PAY_CID;
	
	//결제 취소 url
	@Value("#{env['kakao.pay.cancel.request.url']}")
	private String KAKAO_PAY_REQUEST_CANCEL_URL;

	@Value("#{env['kakao.pay.cancel.url']}")
	private String KAKAO_PAY_CANCEL_URL;
	
	@Autowired
	private StUserDao stUserDao;
	
	public StUser stUserSelect(String userId)
	{
		StUser stUser = null;
		
		try 
		{
			stUser = stUserDao.stUserSelect(userId);
		} 
		catch (Exception e) 
		{
			logger.error("[StUserService] stUserSelect Exception Error" + e);
		}
		
		return stUser;
	}
	
	public int stUserUpdate(StUser stUser)
	{
		int count = 0;
		
		try 
		{
			count = stUserDao.stUserUpdate(stUser);
		} 
		catch (Exception e) 
		{
			logger.error("[StUserService] stUserUpdate Exception Error" + e);
		}
		
		return count;
	}
	
	public int stUserPointUpdate(StUser stUser)
	{
		int count = 0;
		
		try 
		{
			count = stUserDao.stUserPointUpdate(stUser);
		}
		catch (Exception e)
		{
			logger.error("[StUserService] stUserPointUpdate Exception Error" + e);
		}
		
		return count;
	}
	
	public int stUserResign(StUser stUser)
	{
		int count = 0;
		
		try 
		{
			count = stUserDao.stUserResign(stUser);
		} 
		catch (Exception e) 
		{
			logger.error("[StUserService] stUserResign Exception Error" + e);
		}
		
		return count;
	}
	
	public long stPaymentApproveListCount(String userId)
	{
		long count = 0;
		
		try 
		{
			count = stUserDao.stPaymentApproveListCount(userId);
		} 
		catch (Exception e) 
		{
			logger.error("[StUserService] stPaymentApproveListCount Exception Error" + e);
		}
		
		return count;
	}
	
	public List<StPaymentApprove> stPaymentApproveList(StPaymentApprove stPaymentApprove)
	{
		List<StPaymentApprove> stPaymentApproveList = null;
		
		try 
		{
			stPaymentApproveList = stUserDao.stPaymentApproveList(stPaymentApprove);
		}
		catch (Exception e) 
		{
			logger.error("[StUserService] stPaymentApproveList Exception Error" + e);
		}

		return stPaymentApproveList;
	}
	
	public StPaymentApprove stPaymentApproveSelect(String partnerOrderId)
	{
		StPaymentApprove stPaymentApprove = null;
		
		try
		{
			stPaymentApprove = stUserDao.stPaymentApproveSelect(partnerOrderId);
		}
		catch (Exception e) 
		{
			logger.error("[StUserService] stPaymentApproveSelect Exception Error" + e);
		}
		
		return stPaymentApprove;
	}
	

	
	public int stPaymentApproveUpdate(StPaymentApprove stPaymentApprove)
	{
		int count = 0;
		
		try 
		{
			count = stUserDao.stPaymentApproveUpdate(stPaymentApprove);
		} 
		catch (Exception e) 
		{
			logger.error("[StUserService] stPaymentApproveUpdate Exception Error" + e);
		}
		
		return count;
	}
	
	
	
	public long stPaymentCancelListCount(String userId)
	{
		long count = 0;
		
		try 
		{
			count = stUserDao.stPaymentCancelListCount(userId);
		} 
		catch (Exception e) 
		{
			logger.error("[StUserService] stPaymentCancelListCount Exception Error" + e);
		}
		
		
		return count;
	}
	
	public List<StPaymentCancel> stPaymentCancelList(StPaymentCancel stPaymentCancel)
	{
		List<StPaymentCancel> stPaymentCancelList = null;
		
		try
		{
			stPaymentCancelList = stUserDao.stPaymentCancelList(stPaymentCancel);
		}
		catch (Exception e) 
		{
			logger.error("[StUserService] stPaymentCancelList Exception Error" + e);
		}

		return stPaymentCancelList;
	}
	
	public int stPaymentCancelInsert(StPaymentCancel stPaymentCancel)
	{
		int count = 0;
		
		try 
		{
			count = stUserDao.stPaymentCancelInsert(stPaymentCancel);
		} 
		catch (Exception e) 
		{
			logger.error("[StUserService] stPaymentCancelInsert Exception Error" + e);
		}
		
		return count;
	}
	
	public long stUserReviewListCount(ReBoard reBoard)
	{
		long count = 0;
		
		try 
		{
			count = stUserDao.stUserReviewListCount(reBoard);
		}
		catch (Exception e)
		{
			logger.error("[StUserService] stUserReviewListCount Exception Error" + e);
		}
		
		return count;
	}
	
	public List<ReBoard> stUserReviewList(ReBoard reBoard)
	{
		List<ReBoard> reBoardList = null;
		
		try 
		{
			reBoardList = stUserDao.stUserReviewList(reBoard);
		}
		catch (Exception e)
		{
			logger.error("[StUserService] stUserReviewList Exception Error" + e);
		}
		
		return reBoardList;
	}
	
	public long stUserReplyListCount(ReBoardReply reBoardReply)
	{
		long count = 0;
		
		try 
		{
			count = stUserDao.stUserReplyListCount(reBoardReply);
		}
		catch (Exception e) 
		{
			logger.error("[StUserService] stUserReplyListCount Exception Error" + e);
		
		}
		
		return count;
	}
	
	public List<ReBoardReply> stUserReplyList(ReBoardReply ReBoardReply)
	{
		List<ReBoardReply> reBoardReplyList = null;
		
		try 
		{
			reBoardReplyList = stUserDao.stUserReplyList(ReBoardReply);
		}
		catch (Exception e) 
		{
			logger.error("[StUserService] stUserReplyList Exception Error" + e);
		}
		
		return reBoardReplyList;
	}
	
	public long stUserQnaBoardListCount(QnaBoard qnaBoard)
	{
		long count = 0;
		
		try 
		{
			count = stUserDao.stUserQnaBoardListCount(qnaBoard);
		} 
		catch (Exception e) 
		{
			logger.error("[StUserService] stPaymentCancelInsert Exception Error" + e);
		}
		
		return count;
	}
	
	public List<QnaBoard> stUserQnaBoardList(QnaBoard qnaBoard)
	{
		List<QnaBoard> qnaBoardList = null;
		
		try 
		{
			qnaBoardList = stUserDao.stUserQnaBoardList(qnaBoard);
		}
		catch (Exception e) 
		{
			logger.error("[StUserService] stPaymentCancelInsert Exception Error" + e);
		}
		
		return qnaBoardList;
	}

	public KakaoPayCancel kakaoPayCancel(StPaymentApprove stPaymentApprove)
	{
		KakaoPayCancel kakaoPayCancel = null;
		
		if(stPaymentApprove != null)
		{
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders httpHeaders = new HttpHeaders();
			
			httpHeaders.add("Authorization", "KakaoAK " + KAKAO_PAY_ADMIN_KEY);
			httpHeaders.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
			
			MultiValueMap<String, Object> params = new LinkedMultiValueMap<String, Object>();
			
			params.add("cid", KAKAO_PAY_CID);
			params.add("tid", stPaymentApprove.getTid());
			params.add("cancel_amount", stPaymentApprove.getTotalAmount());
			params.add("cancel_tax_free_amount", stPaymentApprove.getTaxFreeAmount());
			
			HttpEntity<MultiValueMap<String, Object>> body = new HttpEntity<MultiValueMap<String, Object>>(params, httpHeaders);
			
			try
			{
				kakaoPayCancel = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_REQUEST_CANCEL_URL), body, KakaoPayCancel.class);
			} 
			catch (URISyntaxException e) 
			{
				logger.error("[StUserService] kakaoPayCancel URISyntaxException" + e);
			}
		}
		else
		{
			logger.error("[StUserService] kakaoPayCancel stPaymentApprove is null");
		}
		
		return kakaoPayCancel;
	}
}
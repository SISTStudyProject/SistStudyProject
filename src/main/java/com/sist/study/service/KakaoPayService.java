package com.sist.study.service;

import java.net.URI;
import java.net.URISyntaxException;

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

import com.sist.study.dao.PaymentDao;
import com.sist.study.dao.QnaBoardDao;
import com.sist.study.model.KakaoPayApprove;
import com.sist.study.model.KakaoPayOrder;
import com.sist.study.model.KakaoPayReady;
import com.sist.study.model.PaymentApprove;

@Service("KakaoPayService")
public class KakaoPayService {
	
	private static Logger logger = LoggerFactory.getLogger(KakaoPayService.class);
	
	//카카오페이 호스트
		@Value("#{env['kakao.pay.host']}")
		private String KAKAO_PAY_HOST;
		//관리자 키
		@Value("#{env['kakao.pay.admin.key']}")
		private String KAKAO_PAY_ADMIN_KEY;
		//가맹점 코드
		@Value("#{env['kakao.pay.cid']}")
		private String KAKAO_PAY_CID;
		//결제 url
		@Value("#{env['kakao.pay.ready.url']}")
		private String KAKAO_PAY_READY_URL;
		//카카오페이 결제 요청 url
		@Value("#{env['kakao.pay.approve.url']}")
		private String KAKAO_PAY_APPROVE_URL;
		//카카오페이 결제 성공 url
		@Value("#{env['kakao.pay.success.url']}")
		private String KAKAO_PAY_SUCCESS_URL;
		//카카오페이 결제 취소 url
		@Value("#{env['kakao.pay.cancel.url']}")
		private String KAKAO_PAY_CANCEL_URL;
		//카카오페이 결제 실패 url
		@Value("#{env['kakao.pay.fail.url']}")
		private String KAKAO_PAY_FAIL_URL;
		
		@Autowired
		private PaymentDao paymentDao;
		
		
		public KakaoPayReady kakaoPayReady(KakaoPayOrder order) {
			
			
			KakaoPayReady ready = new KakaoPayReady();
			
			if(order!=null) {
				//RestTemplate = 스프링에서 지원하는 내장 클래스 객체로, 간편하게 rest 방식 API 호출 가능
				RestTemplate restTemplet = new RestTemplate();
				
				//서버로 요청할 헤더 (스프링에서 지원해 줌)
				HttpHeaders headers = new HttpHeaders();
				headers.add("Authorization","KakaoAK "+KAKAO_PAY_ADMIN_KEY);
				headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
				
				logger.debug("headers:"+headers);

		 
				//서버로 요청할 바디(다형성)
				MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
				
				params.add("cid",KAKAO_PAY_CID);
				params.add("partner_order_id", order.getPartnerOrderId());
				params.add("partner_user_id", order.getPartnerUserId());
				params.add("item_name", order.getItemName());
				params.add("item_code", order.getItemCode());
				params.add("quantity", String.valueOf(order.getQuantity()));
				params.add("total_amount", String.valueOf(order.getTotalAmount()));
				params.add("tax_free_amount",String.valueOf(order.getTaxFreeAmount()));
				params.add("approval_url", KAKAO_PAY_SUCCESS_URL);
				params.add("cancel_url", KAKAO_PAY_CANCEL_URL);
				params.add("fail_url", KAKAO_PAY_FAIL_URL);
				
				
				//요청하기 위해서 header와 body 합치기
				//Spring fraimwork에서 제공하는 HttpEntity class에 header와 body 합치기
				HttpEntity<MultiValueMap<String, String>> body =
						new HttpEntity<MultiValueMap<String,String>>(params,headers);
				
				//logger.debug("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%body:"+body);
				
				
				try {
					//postForObject 메서드는 POST 요청을 보내고 객체로 결과를 반환받음.
					ready = restTemplet.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_READY_URL), body, KakaoPayReady.class);
					if(ready!=null) {
						order.settId(ready.getTid());
						logger.debug("!!!!!!!!!!!ready.getTid:"+ready.getTid());
						logger.debug("!!!!!!!!!!![kakaoPayService] ready:"+ready);
						
					}

		            
				} 
				catch (URISyntaxException e) {
					logger.error("[kakaoService]kakaoPayReady URISyntaxException",e);
				} 
		
			}
			else {
				logger.error("[kakaoPayService] kakaoPayOrder is null");
			}
			return ready;
		}
		
		
		//승인요청
		public KakaoPayApprove kakaoPayApprove (KakaoPayOrder order) {

			KakaoPayApprove approve = null;
			if(order!=null) {
				RestTemplate restTemplate = new RestTemplate();
				
				//서버로 요청할 헤더
				HttpHeaders headers = new HttpHeaders();
				headers.add("Authorization","KakaoAK "+KAKAO_PAY_ADMIN_KEY);
				headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
				logger.debug("headers:"+headers);
				
				//서버로 요청할 바디
				MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
				
				params.add("cid", KAKAO_PAY_CID);	//가맹점 코드, 10자
				params.add("tid", order.gettId());	//String	O	결제 고유번호, 결제 준비 API 응답에 포함
				params.add("partner_order_id", order.getPartnerOrderId());	//String	O	가맹점 주문번호, 결제 준비 API 요청과 일치해야 함
				params.add("partner_user_id", order.getPartnerUserId());	//String	/O	가맹점 회원 id, 결제 준비 API 요청과 일치해야 함
				params.add("pg_token", order.getPgToken());	//String	O	결제승인 요청을 인증하는 토큰 사용자 결제 수단 선택 완료 시, approval_url로 redirection해줄 때 pg_token을 query string으로 전달
				
				HttpEntity<MultiValueMap<String, String>> body =
						new HttpEntity<MultiValueMap<String, String>>(params, headers);
				try {
					approve = restTemplate.postForObject(new URI(KAKAO_PAY_HOST + KAKAO_PAY_APPROVE_URL), body, KakaoPayApprove.class);
				
					if(approve !=null) {
						logger.debug("====================================");
						logger.debug("[서비스] approve: "+approve);
						logger.debug("====================================");
					}
				}
				catch(URISyntaxException e) {
					logger.error("[KakaoService] kakaoPayApprove URI SyntaxException");
				}
			}
			else {
				logger.error("[KakaoService] kakaoPayApprove KakaopayOrder is null");
			}
			
			return approve;
		}
		
		//인서트
		public int paymentInsert (PaymentApprove order) {
			int cnt = 0;
			try {
				cnt = paymentDao.paymentInsert(order);
			}
			catch(Exception e) {
				logger.error("[KakaoService] paymentInsert error",e);
			}
			return cnt;
		}
		
		//업데이트
		public int updatePayment (String tid) {
			int cnt=0;
			try {
				cnt = paymentDao.updatePayment(tid);
			}
			catch(Exception e) {
				logger.error("[KakaoService] updatePayment error",e);
			}
			return cnt;
		}
}

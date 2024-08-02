package com.sist.study.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.study.model.QnaBoard;
import com.sist.study.model.ReBoard;
import com.sist.study.model.ReBoardReply;
import com.sist.study.model.StPaymentApprove;
import com.sist.study.model.StPaymentCancel;
import com.sist.study.model.StUser;

@Repository("StUserDao")
public interface StUserDao 
{
	public StUser stUserSelect(String userId);
	
	public int stUserUpdate(StUser stUser);
	
	public int stUserPointUpdate(StUser stUser);
	
	public int stUserResign(StUser stUser);
	
	public long stPaymentApproveListCount(String userId);
	
	public List<StPaymentApprove> stPaymentApproveList(StPaymentApprove stPaymentApprove);
	
	public long stPaymentCancelListCount(String userId);
	
	public List<StPaymentCancel> stPaymentCancelList(StPaymentCancel stPaymentCancel);

	public StPaymentApprove stPaymentApproveSelect(String partnerOrderId);
	
	public int stPaymentApproveUpdate(StPaymentApprove stPaymentApprove);
	
	public int stPaymentCancelInsert(StPaymentCancel stPaymentCancel);
	
	public long stUserReviewListCount(ReBoard reBoard);
	
	public List<ReBoard> stUserReviewList(ReBoard reBoard);
	
	public long stUserReplyListCount(ReBoardReply reBoardReply);
	
	public List<ReBoardReply> stUserReplyList(ReBoardReply reBoardReply);
	
	public ReBoard stUserReviewSelect(long reBoardSeq);
	
	public long stUserQnaBoardListCount(QnaBoard qnaBoard);
	
	public List<QnaBoard> stUserQnaBoardList(QnaBoard qnaBoard);
}
package com.sist.study.dao;

import org.springframework.stereotype.Repository;

import com.sist.study.model.PaymentApprove;

@Repository("PaymentDao")
public interface PaymentDao {
	
	public int paymentInsert (PaymentApprove payment);
	
	public int updatePayment (String tid);

}

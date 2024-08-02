package com.sist.study.model;

import java.io.Serializable;
import java.util.Date;

public class StPaymentApprove implements Serializable
{
	private static final long serialVersionUID = 1L;

	private String cid;
	private String tid;
	
	private String partnerOrderId;
	private String partnerUserId;
	
	private String itemCode;
	private String itemName;
	
	private int totalAmount;
	private int taxFreeAmount;
	
	private char status;
	private Date approvedAt;
	
	private long point;
	
	private long startRow;
	private long endRow;
	
	public StPaymentApprove()
	{
		cid = "";
		tid = ""; 
		
		partnerOrderId = "";
		partnerUserId = "";
		
		itemCode = "";
		itemName = "";
		
		totalAmount = 0;
		taxFreeAmount = 0;
		
		status = 'N';
		approvedAt = null;
		
		point = 0;
		
		startRow = 0;
		endRow = 0;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getPartnerOrderId() {
		return partnerOrderId;
	}

	public void setPartnerOrderId(String partnerOrderId) {
		this.partnerOrderId = partnerOrderId;
	}

	public String getPartnerUserId() {
		return partnerUserId;
	}

	public void setPartnerUserId(String partnerUserId) {
		this.partnerUserId = partnerUserId;
	}

	public String getItemCode() {
		return itemCode;
	}

	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public int getTaxFreeAmount() {
		return taxFreeAmount;
	}

	public void setTaxFreeAmount(int taxFreeAmount) {
		this.taxFreeAmount = taxFreeAmount;
	}

	public Date getApprovedAt() {
		return approvedAt;
	}

	public char getStatus() {
		return status;
	}

	public void setStatus(char status) {
		this.status = status;
	}
	
	public void setApprovedAt(Date approvedAt) {
		this.approvedAt = approvedAt;
	}
	
	public long getPoint() {
		return point;
	}

	public void setPoint(long point) {
		this.point = point;
	}

	public long getStartRow() {
		return startRow;
	}

	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}

	public long getEndRow() {
		return endRow;
	}

	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}


	
	
}

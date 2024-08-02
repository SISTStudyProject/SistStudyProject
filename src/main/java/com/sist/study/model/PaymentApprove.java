package com.sist.study.model;


public class PaymentApprove {
	
	private String cid;
	private String tid;
	private String partnerOrderId;
	private String partnerUserId;
	private String itemCode;
	private String itemName;
	private int totalAmount;
	private int taxFreeAmount;
	private String status;
	private String approvedAt;
	private long point;
	
	public PaymentApprove(){
		cid="";
		tid="";
		partnerOrderId="";
		partnerUserId="";
		itemCode="";
		itemName="";
		totalAmount=0;
		taxFreeAmount=0;
		status="A";
		approvedAt="";
		
		point = 0;
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

	public String getOrderId() {
		return partnerOrderId;
	}

	public void setOrderId(String partnerOrderId) {
		this.partnerOrderId = partnerOrderId;
	}

	public String getUserId() {
		return partnerUserId;
	}

	public void setUserId(String partnerUserId) {
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

	public int getTotalAmaount() {
		return totalAmount;
	}

	public void setTotalAmaount(int totalAmaount) {
		this.totalAmount = totalAmaount;
	}

	public int getTaxFreeAmount() {
		return taxFreeAmount;
	}

	public void setTaxFreeAmount(int taxFreeAmount) {
		this.taxFreeAmount = taxFreeAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getApprovedAt() {
		return approvedAt;
	}

	public void setApprovedAt(String approvedAt) {
		this.approvedAt = approvedAt;
	}

	public long getPoint() {
		return point;
	}

	public void setPoint(long point) {
		this.point = point;
	}

}

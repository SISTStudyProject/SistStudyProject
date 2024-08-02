package com.sist.study.model;

import java.io.Serializable;

public class ReBoardReply implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long reBoardSeq;	
	private long replySeq;
	
	private String reBoardTitle;
	
	private String userId;
	private long replyGroup;
	private long replyOrder;
	private String replyContent;
	private String regDate;
	private char status;
	
	private long startRow;
	private long endRow;
	
	public ReBoardReply()
	{
		reBoardSeq = 0;
		replySeq = 0;
		
		reBoardTitle = "";
		
		userId = "";
		replyGroup = 0;
		replyOrder = 0;
		replyContent = "";
		regDate = "";
		status = 'N';
		
		startRow = 0;
		endRow = 0;
	}

	public long getReBoardSeq() {
		return reBoardSeq;
	}

	public void setReBoardSeq(long reBoardSeq) {
		this.reBoardSeq = reBoardSeq;
	}

	public long getReplySeq() {
		return replySeq;
	}

	public void setReplySeq(long replySeq) {
		this.replySeq = replySeq;
	}

	public String getReBoardTitle() {
		return reBoardTitle;
	}

	public void setReBoardTitle(String reBoardTitle) {
		this.reBoardTitle = reBoardTitle;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public long getReplyGroup() {
		return replyGroup;
	}

	public void setReplyGroup(long replyGroup) {
		this.replyGroup = replyGroup;
	}

	public long getReplyOrder() {
		return replyOrder;
	}

	public void setReplyOrder(long replyOrder) {
		this.replyOrder = replyOrder;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public char getStatus() {
		return status;
	}

	public void setStatus(char status) {
		this.status = status;
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

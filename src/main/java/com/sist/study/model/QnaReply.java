package com.sist.study.model;
import java.io.Serializable;

public class QnaReply implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String managerId;
	private long qnareplySeq;
	private long qnaboardSeq;
	private String replyContent;
	private String regDate;
	
	public QnaReply()
	{
		managerId = "";
		qnareplySeq = 0;
		qnaboardSeq = 0;
		replyContent = "";
		regDate = "";
	}

	public String getManagerId() {
		return managerId;
	}

	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public long getQnareplySeq() {
		return qnareplySeq;
	}

	public void setQnareplySeq(long qnareplySeq) {
		this.qnareplySeq = qnareplySeq;
	}

	public long getQnaboardSeq() {
		return qnaboardSeq;
	}

	public void setQnaboardSeq(long qnaboardSeq) {
		this.qnaboardSeq = qnaboardSeq;
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
	
	
	
}

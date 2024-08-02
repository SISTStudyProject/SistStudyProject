package com.sist.study.model;
import java.io.Serializable;
import java.util.List;

public class QnaBoard implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long qnaBoardSeq;
	private String userId;
	private String qnaBoardTitle;
	private String qnaBoardContent;
	private String status;
	private String regDate;
	private String secretFlag; // 비밀글 여부
	private String replyFlag;

	private String searchType;
	private String searchValue;
	
	private QnaFile qnaFile;
	private QnaReply qnaReply;
	private List<QnaReply> qnaReplyList;
	
	private long startRow;
	private long endRow;
	
		
	public QnaBoard()
	{
		qnaBoardSeq = 0;
		userId = "";
		qnaBoardTitle = "";
		qnaBoardContent = "";
		status = "";
		regDate = "";
		secretFlag = "";
		replyFlag = "N";
		
		searchType = "";
		searchValue = "";
		qnaReplyList = null;
		
		qnaFile = null;
		qnaReply = null;
		
		startRow = 0;
		endRow = 0;
		
	}

	public QnaReply getQnaReply() {
		return qnaReply;
	}

	public void setQnaReply(QnaReply qnaReply) {
		this.qnaReply = qnaReply;
	}

	public String getReplyFlag() {
		return replyFlag;
	}

	public void setReplyFlag(String replyFlag) {
		this.replyFlag = replyFlag;
	}

	public long getQnaBoardSeq() {
		return qnaBoardSeq;
	}

	public void setQnaBoardSeq(long qnaBoardSeq) {
		this.qnaBoardSeq = qnaBoardSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getQnaBoardTitle() {
		return qnaBoardTitle;
	}

	public void setQnaBoardTitle(String qnaBoardTitle) {
		this.qnaBoardTitle = qnaBoardTitle;
	}

	public String getQnaBoardContent() {
		return qnaBoardContent;
	}

	public void setQnaBoardContent(String qnaBoardContent) {
		this.qnaBoardContent = qnaBoardContent;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getSecretFlag() {
		return secretFlag;
	}

	public void setSecretFlag(String secretFlag) {
		this.secretFlag = secretFlag;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public QnaFile getQnaFile() {
		return qnaFile;
	}

	public void setQnaFile(QnaFile qnaFile) {
		this.qnaFile = qnaFile;
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

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public List<QnaReply> getQnaReplyList() {
		return qnaReplyList;
	}

	public void setQnaReplyList(List<QnaReply> qnaReplyList) {
		this.qnaReplyList = qnaReplyList;
	}
}

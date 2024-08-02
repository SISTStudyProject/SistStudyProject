package com.sist.study.model;

import java.io.Serializable;
import java.util.List;

public class ReBoard implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long reBoardSeq;
	private long itemSeq;
	private String itemName;
	
	private String userId;
	private String reBoardTitle;
	private String reBoardContent;
	private long reBoardReadCnt;
	private String regDate;
	private char reBoardDelFlag;
	
	private String searchType;
	private String searchValue;
	
	private long startRow;
	private long endRow;
	
	private ReBoardFile reBoardFile;

	private List<ReBoardFile> reBoardFileList;
		
	private List<ReBoardReply> reBoardReplyList;
	
	public ReBoard()
	{
		reBoardSeq = 0;
		itemSeq = 0;
		itemName = "";
		userId = "";
		reBoardTitle = "";
		reBoardContent = "";
		reBoardReadCnt = 0;
		regDate = "";
		reBoardDelFlag = ' ';
		
		searchType = "";
		searchValue = "";
		
		startRow = 0;
		endRow = 0;
		
		reBoardFile = null;
		reBoardFileList = null;
		reBoardReplyList = null;
	}

	public long getReBoardSeq() {
		return reBoardSeq;
	}

	public void setReBoardSeq(long reBoardSeq) {
		this.reBoardSeq = reBoardSeq;
	}
	
	public long getItemSeq() {
		return itemSeq;
	}

	public void setItemSeq(long itemSeq) {
		this.itemSeq = itemSeq;
	}
	

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getReBoardTitle() {
		return reBoardTitle;
	}

	public void setReBoardTitle(String reBoardTitle) {
		this.reBoardTitle = reBoardTitle;
	}

	public String getReBoardContent() {
		return reBoardContent;
	}

	public void setReBoardContent(String reBoardContent) {
		this.reBoardContent = reBoardContent;
	}

	public long getReBoardReadCnt() {
		return reBoardReadCnt;
	}

	public void setReBoardReadCnt(long reBoardReadCnt) {
		this.reBoardReadCnt = reBoardReadCnt;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public char getReBoardDelFlag() {
		return reBoardDelFlag;
	}

	public void setReBoardDelFlag(char reBoardDelFlag) {
		this.reBoardDelFlag = reBoardDelFlag;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
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


	public ReBoardFile getReBoardFile() {
		return reBoardFile;
	}

	public void setReBoardFile(ReBoardFile reBoardFile) {
		this.reBoardFile = reBoardFile;
	}

	public List<ReBoardFile> getReBoardFileList() {
		return reBoardFileList;
	}

	public void setReBoardFileList(List<ReBoardFile> reBoardFileList) {
		this.reBoardFileList = reBoardFileList;
	}

	public List<ReBoardReply> getReBoardReplyList() 
	{
		return reBoardReplyList;
	}

	public void setReBoardReplyList(List<ReBoardReply> reBoardReplyList) 
	{
		this.reBoardReplyList = reBoardReplyList;
	}
}

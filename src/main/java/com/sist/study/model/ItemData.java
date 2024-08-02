package com.sist.study.model;

import java.io.Serializable;

public class ItemData implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long itemSeq;
	private String itemCode; 
	private String itemName;
	private String itemCate;
	private long itemPrice;
	private String itemIntro;
	private long readCnt;
	private long stock;
	private String regDate;
	
	private String searchType;
	private String searchValue;
	
	private long startRow;
	private long endRow;
	
	private ItemFile itemFile;
	private String fileName;
	private String sortBy;
	
	private String userId;
	
	private String addDate;	//장바구니 추가일
	private int itemNum;	//상품 갯수
	
	private int quantity;
	
	public ItemData()
	{
		itemSeq = 0;
		itemCode = "";
		itemName = "";
		itemCate = "";
		itemPrice = 0;
		readCnt = 0;
		stock = 0;
		regDate = "";
		itemIntro="";
		
		searchType = "";
		searchValue = "";
		
		startRow = 0;
		endRow = 0;
		
		itemFile = null;
		fileName ="";
		sortBy="";
		quantity = 1;
	}

	public long getItemSeq() {
		return itemSeq;
	}

	public void setItemSeq(long itemSeq) {
		this.itemSeq = itemSeq;
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

	public String getItemCate() {
		return itemCate;
	}

	public void setItemCate(String itemCate) {
		this.itemCate = itemCate;
	}

	public long getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(long itemPrice) {
		this.itemPrice = itemPrice;
	}

	public long getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(long readCnt) {
		this.readCnt = readCnt;
	}

	public long getStock() {
		return stock;
	}

	public void setStock(long stock) {
		this.stock = stock;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
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

	public ItemFile getItemFile() {
		return itemFile;
	}

	public void setItemFile(ItemFile itemFile) {
		this.itemFile = itemFile;
	}

	public String getSortBy() {
		return sortBy;
	}

	public void setSortBy(String sortBy) {
		this.sortBy = sortBy;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getItemIntro() {
		return itemIntro;
	}

	public void setItemIntro(String itemIntro) {
		this.itemIntro = itemIntro;
	}
	
	public String getAddDate() {
		return addDate;
	}

	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}

	public int getItemNum() {
		return itemNum;
	}

	public void setItemNum(int itemNum) {
		this.itemNum = itemNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}

package com.sist.study.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.study.model.ItemData;

@Repository("shopDao")
public interface ShopDao {
	
	//상풍 리스트 조회
	public List<ItemData> itemDataList(ItemData itemData);
	
	//상품 리스트 총 갯수 조회
	public int itemListCnt(ItemData itemData);
	
	//상품 단건 조회
	public ItemData itemDetailSelect(int itemSeq);
	
	//상품 조회수 증가
	public int itemReadCntPlus(int itemSeq);
	
	//추천 상품 리스트
	public List<ItemData> itemRecItem();
	
	//상품 여러 건 조회
	public List<ItemData> itemMultiSelect(List<Integer> itemSeq);
	
	// 상품 단건 조회
	public ItemData itemDetailSelect(long itemSeq);

	// 상품 조회수 증가
	public int itemReadCntPlus(long itemSeq);

	// 장바구니 - 상품 추가
	public int itemAddCart(ItemData itemData);

	// 장바구니 목록
	public List<ItemData> myCartList(String userId);

	// 장바구니 갯수 변경
	public int itemNumUpdate(ItemData itemData);

	// 장바구니 항목 삭제
	public int myItemDelete(ItemData itemData);

	// 장바구니 상품 갯수
	public int myCartTotalCnt(String userId);

	// 장바구니 상품 존재 여부 확인
	public int chkCartCnt(ItemData itemData);

	// 장바구니 단건 담은 갯수
	public int myCartItemNum(ItemData itemData);
	
	//장바구니 전체 삭제
	public int myItemAllDelete (String userId);
}

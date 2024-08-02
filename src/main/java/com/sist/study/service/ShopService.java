package com.sist.study.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.study.dao.ShopDao;
import com.sist.study.model.ItemData;

@Service("ShopService")
public class ShopService {

	private static Logger logger = LoggerFactory.getLogger(ShopService.class);

	@Autowired
	private ShopDao shopDao;

	// 상품 리스트 조회
	public List<ItemData> itemDataList(ItemData itemData) {
		List<ItemData> list = null;

		try {
			list = shopDao.itemDataList(itemData);
		} catch (Exception e) {
			logger.error("[ShopService] itemDataList Exception Error -- " + e);
		}

		return list;
	}

	// 상품 리스트 총 갯수 조회
	public int itemListCnt(ItemData itemData) {
		int listCnt = 0;

		try {
			listCnt = shopDao.itemListCnt(itemData);
		} catch (Exception e) {
			logger.error("[ShopService] itemListCnt Exception Error -- " + e);
		}

		return listCnt;
	}

	// 상품 단건 조회
	public ItemData itemDetailSelect(long itemSeq) {
		ItemData item = null;

		try {
			item = shopDao.itemDetailSelect(itemSeq);

			if (item != null) {
				shopDao.itemReadCntPlus(itemSeq);

				// 상품 사진 -> 추후 다중 파일 업로드시

			}
		} catch (Exception e) {
			logger.error("[ShopService] itemDetailSelect Exception Error -- " + e);
		}

		return item;
	}

	// 추천 상품 리스트
	public List<ItemData> itemRecItem() {
		List<ItemData> list = null;

		try {
			list = shopDao.itemRecItem();
		} catch (Exception e) {
			logger.error("[ShopService] itemRecItem Exception Error -- " + e);
		}

		return list;
	}

	// 장바구니 - 상품 추가
	public int itemAddCart(ItemData itemData) {
		int result = 0;

		try {
			result = shopDao.itemAddCart(itemData);
		} catch (Exception e) {
			logger.error("[ShopService] itemAddCart Exception Error -- " + e);
		}

		return result;
	}

	// 장바구니 목록
	public List<ItemData> myCartList(String userId) {
		List<ItemData> list = null;

		try {
			list = shopDao.myCartList(userId);
		} catch (Exception e) {
			logger.error("[ShopService] myCartList Exception Error -- " + e);
		}

		return list;
	}

	// 장바구니 갯수 변경
	public int itemNumUpdate(ItemData itemData) {
		int result = 0;

		try {
			result = shopDao.itemNumUpdate(itemData);
		} catch (Exception e) {
			logger.error("[ShopService] itemNumUpdate Exception Error -- " + e);
		}

		return result;
	}

	// 장바구니 항목 삭제
	public int myItemDelete(ItemData itemData) {
		int result = 0;

		try {
			result = shopDao.myItemDelete(itemData);
		} catch (Exception e) {
			logger.error("[ShopService] myItemDelete Exception Error -- " + e);
		}

		return result;
	}

	// 장바구니 상품 갯수
	public int myCartTotalCnt(String userId) {
		int cnt = 0;

		try {
			cnt = shopDao.myCartTotalCnt(userId);
		} catch (Exception e) {
			logger.error("[ShopService] myCartNum Exception Error -- " + e);
		}

		return cnt;
	}

	// 장바구니 상품 존재 여부 확인
	public int chkCartCnt(ItemData itemData) {
		int cnt = 0;

		try {
			cnt = shopDao.chkCartCnt(itemData);
		} catch (Exception e) {
			logger.error("[ShopService] chkCartCnt Exception Error -- " + e);
		}

		return cnt;
	}

	// 장바구니 단건 담은 갯수
	public int myCartItemNum(ItemData itemData) {
		int cnt = 0;

		try {
			cnt = shopDao.myCartItemNum(itemData);
		} catch (Exception e) {
			logger.error("[ShopService] myCartItemNum Exception Error -- " + e);
		}

		return cnt;
	}

	// 다건 조회 (추가**)
	public List<ItemData> itemMultiSelect(List<Integer> itemSeq) {
		List<ItemData> item = null;

		try {
			item = shopDao.itemMultiSelect(itemSeq);

		} catch (Exception e) {
			logger.error("[ShopService] itemMultiSelect Exception Error -- " + e);
		}

		return item;
	}
}

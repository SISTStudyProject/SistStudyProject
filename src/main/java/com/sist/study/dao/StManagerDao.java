package com.sist.study.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.study.model.ItemData;
import com.sist.study.model.ItemFile;
import com.sist.study.model.QnaBoard;
import com.sist.study.model.QnaFile;
import com.sist.study.model.QnaReply;
import com.sist.study.model.ReBoard;
import com.sist.study.model.ReBoardFile;
import com.sist.study.model.ReBoardReply;
import com.sist.study.model.StManager;
import com.sist.study.model.StUser;

@Repository("StManagerDao")
public interface StManagerDao
{
	public StManager stManagerSelect(String managerId);
	
	//-----------------------------------------------------------------
	
	public long stUserListCount(StUser stUser);
	
	public List<StUser> stUserList(StUser stUser);
	
	public int stUserListUpdate(StUser stUser);
	
	//-----------------------------------------------------------------
	
	public long itemDataListCount(ItemData itemData);
	
	public List<ItemData> itemDataList(ItemData itemData);
	
	public ItemData itemDataSelect(long itemSeq);
	
	public int itemDataInsert(ItemData itemData);
	
	public int itemDataUpdate(ItemData itemData);
	
	//-----------------------------------------------------------------
	
	public long reBoardListCount(ReBoard reBoard);
	
	public List<ReBoard> reBoardList(ReBoard reBoard);
	
	public ReBoard reBoardSelect(long reBoardSeq);
	
	public int reBoardDelete(long reBoardSeq);
	
	public List<ReBoardReply> reBoardReplyListSelect(long reBoardSeq);
	
	public ReBoardReply reBoardReplySelect(long replySeq);
	
	public int reBoardReplyUpdate(long reBoardSeq);
	
	public int reBoardReplyDelete(long reBoardSeq);
	
	//-----------------------------------------------------------------
	
	public long qnaBoardListCount(QnaBoard qnaBoard);
	
	public List<QnaBoard> qnaBoardList(QnaBoard qnaBoard);
	
	public QnaBoard qnaBoardSelect(long qnaboardSeq);
	
	public int qnaBoardFlagUpdate(long qnaboardSeq);
	
	public int qnaBoardDelete(long qnaboardSeq);
	
	public List<QnaReply> qnaReplySelectList(long qnaboardSeq);
	
	public int qnaReplyInsert(QnaReply qnaReply);
	
	public int qnaReplyDelete(long qnaboardSeq);
	
	//-----------------------------------------------------------------
	
	public ItemFile itemDataFileSelect(long itemSeq);
	
	public int itemDataFileInsert(ItemFile itemFile);
	
	public int itemDataFileDelete(long itemSeq);
	
	public ReBoardFile reBoardFileSelect(long reBoardSeq);
	
	public int reBoardFileDelete(long reBoardSeq);
	
	public QnaFile qnaFileSelect(long qnaboardSeq);
	
	public int qnaFileDelete(long qnaboardSeq);
}

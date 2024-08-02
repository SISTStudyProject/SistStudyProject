package com.sist.study.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.study.model.ItemData;
import com.sist.study.model.ReBoard;
import com.sist.study.model.ReBoardFile;
import com.sist.study.model.ReBoardReply;

@Repository
public interface ReBoardDao 
{
	// 글 갯수
	public long reboardTotal(long itemSeq);
	
	// 리스트
	public List<ReBoard> reboardList(ReBoard reboard);
	
	// 글 상세
	public ReBoard reboardSelect(long reboardSeq);
	
	// 첨부파일 상세
	public List<ReBoardFile> reboardFileSelect(long reboardSeq);
	
	// 조회수 증가
	public int readCntUpdate(long reboardSeq);
	
	// 등록
	public int reboardInsert(ReBoard reboard);
	
	// 첨부파일 등록
	public int reboardFileInsert(ReBoardFile reboardFile);
	
	// 글 삭제
	public int reboardStatusUpdate(long reboardSeq);
	public int reboardFileDelete(long reboardSeq);
	public int replyDelete(long reboardSeq);
	
	// 댓글 등록
	public int replyInsert(ReBoardReply reboardReply);
	
	// 대댓글 등록
	public int replyReInsert(ReBoardReply reboardReply);
	
	// 댓글 상세
	public List<ReBoardReply> replySelect(long boardSeq);
	
	// 댓글 삭제
	public int replyStatusUpdate(long replySeq);
	
	// 후기 수정
	public int reboardUpdate(ReBoard reboard);

	// 상품 코드로 상품 조회
	public ItemData itemCodeSelect(String itemCode);
}

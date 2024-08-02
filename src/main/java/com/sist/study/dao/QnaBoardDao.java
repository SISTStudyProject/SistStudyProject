package com.sist.study.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.study.model.QnaBoard;
import com.sist.study.model.QnaFile;
import com.sist.study.model.QnaReply;

@Repository
public interface QnaBoardDao 
{
	// 보드 조회
	public QnaBoard boardSelect(long qnaBoardSeq);
	
	// 첨부파일 조회
	public QnaFile boardFileSelect(long qnaBoardSeq);
	
	// 보드 리스트
	public List<QnaBoard> boardList(QnaBoard qnaBoard);
	
	// 총 글 갯수
	public long totalQna(QnaBoard qnaBoard);
	
	// 글 작성
	public int boardInsert(QnaBoard qnaBoard);
	
	// 첨부파일 작성
	public int boardFileInsert(QnaFile qnaFile);
	
	// 글 삭제
	public int boardDelete(long qnaBoardSeq);
	
	// 첨부파일 삭제
	public int boardFileDelete(long qnaBoardSeq);
	
	// 문의 글 답변 조회
	public QnaReply replySelect(long qnaBoardSeq);
	
	// 문의 답변 작성
	public int replyInsert(QnaReply qnaReply);
	
	// 문의 답변 수정
	public int replyUpdate(QnaReply qnaReply);
	
	// 문의 답변 삭제
	public int replyDelete(long qnaBoardSeq);
	
	// 답변 여부 업데이트
	public int flagUpdate(long qnaBoardSeq);
	
	public int flagUpdateX(long qnaBoardSeq);
}

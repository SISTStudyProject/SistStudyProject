package com.sist.study.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.common.util.FileUtil;
import com.sist.study.dao.QnaBoardDao;
import com.sist.study.model.QnaBoard;
import com.sist.study.model.QnaFile;
import com.sist.study.model.QnaReply;

@Service("qnaService")
public class QnaService 
{
	private static Logger logger = LoggerFactory.getLogger(QnaService.class);
	
	@Autowired
	private QnaBoardDao qnaBoardDao;
	
	@Value("#{env['qna.upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	// 보드 조회
	public QnaBoard boardSelect(long qnaBoardSeq)
	{
		QnaBoard qnaBoard = null;
		
		try
		{
			qnaBoard = qnaBoardDao.boardSelect(qnaBoardSeq);
			
			if(qnaBoard != null)
			{
				QnaFile qnaFile = qnaBoardDao.boardFileSelect(qnaBoard.getQnaBoardSeq());
				QnaReply qnaReply = qnaBoardDao.replySelect(qnaBoardSeq);
				
				if(qnaFile != null) qnaBoard.setQnaFile(qnaFile);
				if(qnaReply != null) qnaBoard.setQnaReply(qnaReply);
			}
		}
		catch(Exception e)
		{
			logger.error("QnaService boardSelect Exception", e);
		}
		
		return qnaBoard;
	}
	
	// 보드 리스트
	public List<QnaBoard> boardList(QnaBoard qnaBoard)
	{
		List<QnaBoard> list = null;
		
		try
		{
			list = qnaBoardDao.boardList(qnaBoard);
		}
		catch(Exception e)
		{
			logger.error("QnaService boardList Exception", e);
		}
		
		return list;
	}
	
	// 총 글 갯수
	public long totalQna(QnaBoard qnaBoard)
	{
		long totalQna = 0;
		
		try
		{
			totalQna = qnaBoardDao.totalQna(qnaBoard);
		}
		catch(Exception e)
		{
			logger.error("QnaService totalQna Exception", e);
		}
		
		return totalQna;
	}
	
	// 글 작성 + 첨부파일
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardInsert(QnaBoard qnaBoard) throws Exception
	{
		int count = 0;
		
		count = qnaBoardDao.boardInsert(qnaBoard);
		
		if(count > 0 && qnaBoard.getQnaFile() != null)
		{
			QnaFile qnaFile = qnaBoard.getQnaFile();
			
			qnaFile.setqnaBoardSeq(qnaBoard.getQnaBoardSeq());
			qnaFile.setQnaBoardFileSeq(qnaBoard.getQnaFile().getQnaBoardFileSeq());
			
			qnaBoardDao.boardFileInsert(qnaFile);
		}
		
		return count;
	}
	
	// 글, 첨부파일 삭제
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardDelete(long qnaBoardSeq) throws Exception
	{
		int count = 0;
		
		// 위위 에 첨부파일을 포함한 게시글을 조회하는 메소드를 이용한다
		QnaBoard qnaBoard = boardSelect(qnaBoardSeq);
		
		if(qnaBoard != null)
		{
			count = qnaBoardDao.boardDelete(qnaBoardSeq);
			
			if(count > 0)
			{
				QnaFile qnaFile = qnaBoard.getQnaFile();
				
				if(qnaFile != null)
				{
					if(qnaBoardDao.boardFileDelete(qnaBoardSeq) > 0)
					{
						FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + qnaFile.getFileName());
					}
				}
			}
		}
		
		return count;
	}
	
	// 문의 글 삭제 + 답변 여부 변경
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int replyDelete(long qnaBoardSeq) throws Exception
	{
		int count = 0;
		
		count = qnaBoardDao.replyDelete(qnaBoardSeq);
		
		if(count > 0) qnaBoardDao.flagUpdateX(qnaBoardSeq);
		
		return count;
	}
	
	// 문의 답변 작성 + 답변 여부 업데이트
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int replyInsert(QnaReply qnaReply) throws Exception
	{
		int count = 0 ;
		
		count = qnaBoardDao.replyInsert(qnaReply);
		
		if(count > 0) qnaBoardDao.flagUpdate(qnaReply.getQnaboardSeq());
		
		return count;
	}
	
	// 답변 조회
	public QnaReply replySelect(long qnaBoardSeq)
	{
		QnaReply qnaReply = null;
		
		try
		{
			qnaReply = qnaBoardDao.replySelect(qnaBoardSeq);
		}
		catch(Exception e)
		{
			logger.error("QnaService replySelect Exception", e);
		}
		
		return qnaReply;
	}
	
	// 답변 수정
	public int replyUpdate(QnaReply qnaReply)
	{
		int count = 0;
		
		try
		{
			count = qnaBoardDao.replyUpdate(qnaReply);
		}
		catch(Exception e)
		{
			logger.error("QnaService replyUpdate Exception", e);
		}
		
		return count;
	}
}

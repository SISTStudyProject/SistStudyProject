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
import com.sist.study.dao.ReBoardDao;
import com.sist.study.model.ItemData;
import com.sist.study.model.ReBoard;
import com.sist.study.model.ReBoardFile;
import com.sist.study.model.ReBoardReply;

@Service("reboardService")
public class ReBoardService 
{
	private static Logger logger = LoggerFactory.getLogger(ReBoardService.class);
	
	@Autowired
	private ReBoardDao reboardDao;
	
	@Value("#{env['reboard.upload.save.dir']}")
	private String UPLOAD_REBOARD_DIR;
	
	// 글 갯수
	public long reBoardTotal(long itemSeq)
	{
		long totalCount = 0;
		
		try
		{
			totalCount = reboardDao.reboardTotal(itemSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] reboardTotal Exception", e);
		}
		
		return totalCount;
	}
	
	// 리스트
	public List<ReBoard> reBoardList(ReBoard reboard)
	{
		List<ReBoard> reboardList = null;
		
		try
		{
			reboardList = reboardDao.reboardList(reboard);
			
			if(reboardList != null)
			{
					for(int i=0 ; i<reboardList.size(); i++)
					{
						reboardList.get(i).setReBoardFileList(reboardDao.reboardFileSelect(reboardList.get(i).getReBoardSeq()));
					}
			}
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] reboardList Exception", e);
		}
		
		return reboardList;
	}
	
	// 글 조회
	public ReBoard reBoardSelect(long reboardSeq)
	{
		ReBoard reboard = null;
		
		try
		{
			reboard = reboardDao.reboardSelect(reboardSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] reboardSelect Exception", e);
		}
		
		return reboard;
	}
	
	// 첨부파일 조회
	public List<ReBoardFile> reBoardFileSelect(long reboardSeq)
	{
		List<ReBoardFile> reboardFile = null;
		
		try
		{
			reboardFile = reboardDao.reboardFileSelect(reboardSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] reboardFileSelect Exception", e);
		}
		
		return reboardFile;
	}
	
	// 글 상세
	public ReBoard reBoardView(long reboardSeq)
	{
		ReBoard reboard = null;
		List<ReBoardFile> reboardFile = null;
		List<ReBoardReply> reboardReply = null;
		
		try
		{
			reboard = reboardDao.reboardSelect(reboardSeq);
			
			if(reboard != null)
			{
				reboardDao.readCntUpdate(reboard.getReBoardSeq());
				
				reboardFile = reboardDao.reboardFileSelect(reboard.getReBoardSeq());
				reboardReply = reboardDao.replySelect(reboard.getReBoardSeq());
				
				if(reboardFile != null)
				{
					reboard.setReBoardFileList(reboardFile);
				}
				
				if(reboardReply != null)
				{
					reboard.setReBoardReplyList(reboardReply);
				}
			}
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] reboardView Exception", e);
		}
		
		return reboard;
	}
	
	// 조회수
	public int readCntUpdate(long reboardSeq)
	{
		int count = 0;
		
		try
		{
			count = reboardDao.readCntUpdate(reboardSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] readCntUpdate Exception", e);
		}
		
		return count;
	}
	
	// 글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reBoardInsert(ReBoard reboard) throws Exception
	{
		int count = reboardDao.reboardInsert(reboard);
		
		if(count > 0 && reboard.getReBoardFile() != null)
		{
			for(int i=0 ; i<reboard.getReBoardFileList().size() ; i++)
			{
				ReBoardFile reboardFile = new ReBoardFile();
				
				reboardFile.setReBoardSeq(reboard.getReBoardSeq());
				reboardFile.setFileSeq(reboard.getReBoardFileList().get(i).getFileSeq());
				
				reboardFile.setFileName(reboard.getReBoardFileList().get(i).getFileName());
				reboardFile.setFileOrgName(reboard.getReBoardFileList().get(i).getFileOrgName());
				reboardFile.setFileExt(reboard.getReBoardFileList().get(i).getFileExt());
				reboardFile.setFileSize(reboard.getReBoardFileList().get(i).getFileSize());
				
				reboardDao.reboardFileInsert(reboardFile);
			}
		}
		
		return count;
	}
	
	// 글 삭제 
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reBoardDelete(long reboardSeq) throws Exception
	{
		int count = 0;
		
		ReBoard reboard = this.reBoardView(reboardSeq);
		
		if(reboard != null)
		{
			count = reboardDao.reboardStatusUpdate(reboardSeq);

			if(count > 0)
			{
				List<ReBoardFile> file = reboard.getReBoardFileList();
				List<ReBoardReply> reply = reboard.getReBoardReplyList();
				
				if(file != null)
				{					
					for(int i=0 ; i<file.size() ; i++)
					{
						reboardDao.reboardFileDelete(reboardSeq);
						FileUtil.deleteFile(UPLOAD_REBOARD_DIR + FileUtil.getFileSeparator()
						+ file.get(i).getFileName());
					}
					
				}

				if(reply != null)
				{
					for(int i=0 ; i<reply.size() ; i++)
					{
						reboardDao.replyDelete(reboardSeq);
					}
				}
			}
		}

		return count;
	}
	
	// 글 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reBoardUpdate(ReBoard reboard) throws Exception
	{
		int count = reboardDao.reboardUpdate(reboard);
		
		if(count > 0 && reboard.getReBoardFile() != null) // 여기있는 파일은 수정하며 추가된 파일
		{
			List<ReBoardFile> reviewFile2 = reboardDao.reboardFileSelect(reboard.getReBoardSeq());
			
				for(int i=0 ; i<reviewFile2.size() ; i++)
				{
					
					FileUtil.deleteFile(UPLOAD_REBOARD_DIR
							+ FileUtil.getFileSeparator() + reviewFile2.get(i).getFileName());
					
					reboardDao.reboardFileDelete(reboard.getReBoardSeq());
				}
			
	
			if(reboard.getReBoardFile() != null) // 파일 새로 추가
			{
				for(int i=0 ; i<reboard.getReBoardFileList().size(); i++)
				{
					ReBoardFile reviewFile3 = new ReBoardFile();
						
					reviewFile3.setReBoardSeq(reboard.getReBoardSeq());
					reviewFile3.setFileSeq(reboard.getReBoardFileList().get(i).getFileSeq());
						
					reviewFile3.setFileName(reboard.getReBoardFileList().get(i).getFileName());
					reviewFile3.setFileOrgName(reboard.getReBoardFileList().get(i).getFileOrgName());
					reviewFile3.setFileExt(reboard.getReBoardFileList().get(i).getFileExt());
					reviewFile3.setFileSize(reboard.getReBoardFileList().get(i).getFileSize());
						
					reboardDao.reboardFileInsert(reviewFile3);
				}
			}
				
			
		}
		
		return count;
	}
	
	// 댓 조
	public List<ReBoardReply> replySelect(long boardSeq)
	{
		List<ReBoardReply> list = null;
		
		try
		{
			list = reboardDao.replySelect(boardSeq);
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] replySelect Exception", e);
		}
		
		return list;
	}
	
	// 댓 삭
	public int replyStatusUpdate(long replySeq)
	{
		int count = 0;
		
		try
		{
			count = reboardDao.replyStatusUpdate(replySeq);
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] replyStatusUpdate Exception", e);
		}
		
		return count;
	}
	
	// 댓 등
	public int replyInsert(ReBoardReply reply)
	{
		int count = 0;
		
		try
		{
			count = reboardDao.replyInsert(reply);
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] replyInsert Exception", e);
		}
		
		return count;
	}
	
	// 대댓글 등록
	public int replyReInsert(ReBoardReply reboardReply)
	{
		int count = 0;
		
		try
		{
			count = reboardDao.replyReInsert(reboardReply);
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] replyReInsert Exception", e);
		}
		
		return count;
	}

	// 상품 코드로 상품 조회
	public ItemData itemCodeSelect(String itemCode)
	{
		ItemData item = null;
		
		try
		{
			item = reboardDao.itemCodeSelect(itemCode);
		}
		catch(Exception e)
		{
			logger.error("[ReboardService] itemCodeSelect Exception", e);
		}
		
		return item;
	}
}

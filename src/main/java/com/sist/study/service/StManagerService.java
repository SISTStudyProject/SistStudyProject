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
import com.sist.common.util.StringUtil;
import com.sist.study.dao.StManagerDao;
import com.sist.study.model.ItemData;
import com.sist.study.model.ItemFile;
import com.sist.study.model.QnaBoard;
import com.sist.study.model.QnaReply;
import com.sist.study.model.ReBoard;
import com.sist.study.model.ReBoardReply;
import com.sist.study.model.StManager;
import com.sist.study.model.StUser;

@Service("StManagerService")
public class StManagerService 
{
	private static Logger logger = LoggerFactory.getLogger(StManagerService.class);
	
	@Autowired
	private StManagerDao stManagerDao;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_DIR;
	
	@Value("#{env['qna.upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Value("#{env['reboard.upload.save.dir']}")
	private String REBOARD_UPLOAD_SAVE_DIR;
	
	public StManager stManagerSelect(String managerId)
	{
		StManager stManager = null;
		
		try 
		{
			stManager = stManagerDao.stManagerSelect(managerId);
		} 
		catch (Exception e) 
		{
			logger.error("[StManagerService] stManagerSelect Exception Error" + e);
		}
		
		return stManager;
	}
	
	
	//-----------------------------------------------------------------
	
	public long stUserListCount(StUser stUser)
	{
		long stUserListCount = 0;
		
		try 
		{
			stUserListCount = stManagerDao.stUserListCount(stUser);
		}
		catch (Exception e)
		{
			logger.error("[StManagerService] stUserListCount Exception Error" + e);
		}
		
		return stUserListCount;
	}
	
	public List<StUser> stUserList(StUser stUser)
	{
		List<StUser> stUserList = null;
		
		try 
		{
			stUserList = stManagerDao.stUserList(stUser);
		} 
		catch (Exception e) 
		{
			logger.error("[StManagerService] stUserList Exception Error" + e);
		}
		
		return stUserList;
	}
	
	public int stUserListUpdate(StUser stUser)
	{
		int count = 0;
		
		try 
		{
			count = stManagerDao.stUserListUpdate(stUser);
		}
		catch (Exception e)
		{
			logger.error("[StManagerService] stUserListUpdate Exception Error" + e);
		}
		
		return count;
	}
	
	//-----------------------------------------------------------------
	
	public long itemDataListCount(ItemData itemData)
	{
		long count = 0;
		
		try 
		{
			count = stManagerDao.itemDataListCount(itemData);
		}
		catch (Exception e)
		{
			logger.error("[StManagerService] itemDataListCount Exception Error" + e);
		}
		
		return count;
	}
	
	public List<ItemData> itemDataList(ItemData itemData)
	{
		List<ItemData> itemDataList = null;
		
		try 
		{
			itemDataList = stManagerDao.itemDataList(itemData);
		}
		catch (Exception e)
		{
			logger.error("[StManagerService] itemDataList Exception Error" + e);
		}
		
		return itemDataList;
	}
	
	
	public ItemData itemDataSelect(long itemSeq)
	{
		ItemData itemData = null;
		
		try 
		{
			itemData = stManagerDao.itemDataSelect(itemSeq);
			
			if(itemData != null)
			{
				itemData.setItemFile(stManagerDao.itemDataFileSelect(itemSeq));
			}
		}
		catch (Exception e) 
		{
			logger.error("[StManagerService] itemDataSelect Exception Error" + e);
		}
		
		return itemData;
	}
	
	//-----------------------------------------------------------------
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int itemDataInsert(ItemData itemData) throws Exception
	{
		int cnt = 0;

		cnt = stManagerDao.itemDataInsert(itemData);
		
		if(cnt > 0 && itemData.getItemFile() != null)
		{
			itemData.getItemFile().setItemSeq(itemData.getItemSeq());
			itemData.getItemFile().setFileNum((short)1);
			stManagerDao.itemDataFileInsert(itemData.getItemFile());
		}
		
		return cnt;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int itemDataUpdate(ItemData itemData) throws Exception
	{
		int count = 0;

		count = stManagerDao.itemDataUpdate(itemData);
		
		if(count > 0)
		{
			ItemFile itemFile = stManagerDao.itemDataFileSelect(itemData.getItemSeq());
			
			if(StringUtil.equals(itemFile.getFileName(), itemData.getItemFile().getFileName()))
			{
				return count;
			}
			else
			{
				stManagerDao.itemDataFileDelete(itemFile.getItemSeq());
				FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + itemFile.getFileName());
				
				itemData.getItemFile().setItemSeq(itemData.getItemSeq());
				itemData.getItemFile().setFileNum((short)1);
				stManagerDao.itemDataFileInsert(itemData.getItemFile());
				
			}
		}

		return count;
	}
	
	//-----------------------------------------------------------------
	
	public long reBoardListCount(ReBoard reBoard)
	{
		long count = 0;
		
		try 
		{
			count = stManagerDao.reBoardListCount(reBoard);
		}
		catch (Exception e)
		{
			logger.error("[StManagerService] reBoardListCount Exception Error" + e);
		}
		
		return count;
	}
	
	public List<ReBoard> reBoardList(ReBoard reBoard)
	{
		List<ReBoard> reBoardList = null;
		
		try 
		{
			reBoardList = stManagerDao.reBoardList(reBoard);
		}
		catch (Exception e)
		{
			logger.error("[StManagerService] reBoardList Exception Error" + e);
		}
		
		return reBoardList;
	}
	
	public ReBoard reBoardSelect(long reBoardSeq)
	{
		ReBoard reBoard = null;
		
		try 
		{
			reBoard = stManagerDao.reBoardSelect(reBoardSeq);
			
			if(reBoard != null)
			{
				reBoard.setReBoardFile(stManagerDao.reBoardFileSelect(reBoardSeq));
				
				reBoard.setReBoardReplyList(stManagerDao.reBoardReplyListSelect(reBoardSeq));
			}
		}
		catch (Exception e) 
		{
			logger.error("[StManagerService] reBoardSelect Exception Error" + e);
		}
		
		return reBoard;
	}
	
	public ReBoardReply reBoardReplySelect(long replySeq)
	{
		ReBoardReply reBoardReply = null;
		
		try 
		{
			reBoardReply = stManagerDao.reBoardReplySelect(replySeq);
		} 
		catch (Exception e) 
		{
			logger.error("[StManagerService] reBoardReplySelect Exception Error" + e);
		}
		
		return reBoardReply;
	}
	
	public int reBoardReplyUpdate(long replySeq)
	{
		int count = 0;
		
		try 
		{
			count = stManagerDao.reBoardReplyUpdate(replySeq);
		}
		catch (Exception e) 
		{
			logger.error("[StManagerService] reBoardReplyUpdate Exception Error" + e);
		}
		
		return count;
	}
	
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int reBoardDelete(ReBoard reBoard) throws Exception
	{
		int count = 0;
		
		if(!reBoard.getReBoardReplyList().isEmpty())
		{
			if(stManagerDao.reBoardReplyDelete(reBoard.getReBoardSeq()) > 0)
			{
				if(reBoard.getReBoardFile() != null)
				{
					if(stManagerDao.reBoardFileDelete(reBoard.getReBoardSeq()) > 0)
					{
						FileUtil.deleteFile(REBOARD_UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + reBoard.getReBoardFile().getFileName());
						count = stManagerDao.reBoardDelete(reBoard.getReBoardSeq());
					}
				}
				else
				{
					count = stManagerDao.reBoardDelete(reBoard.getReBoardSeq());
				}
			}
			else
			{
				
			}
		}
		else if(reBoard.getReBoardFile() != null)
		{
			if(stManagerDao.reBoardFileDelete(reBoard.getReBoardSeq()) > 0)
			{
				FileUtil.deleteFile(REBOARD_UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + reBoard.getReBoardFile().getFileName());
				count = stManagerDao.reBoardDelete(reBoard.getReBoardSeq());
			}
			else
			{
				
			}
		}
		else
		{
			count = stManagerDao.reBoardDelete(reBoard.getReBoardSeq());
		}
					
		return count;
	}
	
	
	
	//-----------------------------------------------------------------
	
	public long qnaBoardListCount(QnaBoard qnaBoard)
	{
		long count = 0;
		
		try 
		{
			count = stManagerDao.qnaBoardListCount(qnaBoard);
		}
		catch (Exception e)
		{
			logger.error("[StManagerService] qnaBoardListCount Exception Error" + e);
		}
		
		return count;		
	}
	
	public List<QnaBoard> qnaBoardList(QnaBoard qnaBoard)
	{
		List<QnaBoard> QnABoardList = null;
		
		try 
		{
			QnABoardList = stManagerDao.qnaBoardList(qnaBoard);
		}
		catch (Exception e)
		{
			logger.error("[StManagerService] qnaBoardList Exception Error" + e);
		}
		
		return QnABoardList;
	}
	
	public QnaBoard qnaBoardSelect(long qnaboardSeq)
	{
		QnaBoard qnaBoard = null;
		
		try 
		{
			qnaBoard = stManagerDao.qnaBoardSelect(qnaboardSeq);
			
			if(qnaBoard != null)
			{
				qnaBoard.setQnaFile(stManagerDao.qnaFileSelect(qnaboardSeq));
				
				qnaBoard.setQnaReplyList(stManagerDao.qnaReplySelectList(qnaboardSeq));
			}
		}
		catch (Exception e) 
		{
			logger.error("[StManagerService] qnaBoardSelect Exception Error" + e);
		}
		
		return qnaBoard;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int qnaReplyInsert(QnaReply qnaReply, QnaBoard qnaBoard) throws Exception
	{
		int count = 0;

		count = stManagerDao.qnaReplyInsert(qnaReply);

		if(count > 0)
		{
			if(StringUtil.equals(qnaBoard.getReplyFlag(), "N"))
			{
				stManagerDao.qnaBoardFlagUpdate(qnaBoard.getQnaBoardSeq());
			}
		}
		
		return count;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int qnaBoardDelete(QnaBoard qnaBoard) throws Exception
	{
		int count = 0;
		
		if(!qnaBoard.getQnaReplyList().isEmpty())
		{
			if(stManagerDao.qnaReplyDelete(qnaBoard.getQnaBoardSeq()) > 0)
			{
				if(qnaBoard.getQnaFile() != null)
				{
					if(stManagerDao.qnaFileDelete(qnaBoard.getQnaBoardSeq()) > 0)
					{
						FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + qnaBoard.getQnaFile().getFileName());
						count = stManagerDao.qnaBoardDelete(qnaBoard.getQnaBoardSeq());
					}
				}
				else
				{
					count = stManagerDao.qnaBoardDelete(qnaBoard.getQnaBoardSeq());
				}
			}
		}
		else if(qnaBoard.getQnaFile() != null)
		{
			if(stManagerDao.qnaFileDelete(qnaBoard.getQnaBoardSeq()) > 0)
			{
				FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + qnaBoard.getQnaFile().getFileName());
				count = stManagerDao.qnaBoardDelete(qnaBoard.getQnaBoardSeq());
			}
		}
		else
		{
			count = stManagerDao.qnaBoardDelete(qnaBoard.getQnaBoardSeq());
		}
		
		return count;
	}
}
package com.sist.study.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import com.sist.common.model.FileData;
import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.StringUtil;
import com.sist.study.model.ItemData;
import com.sist.study.model.ReBoard;
import com.sist.study.model.ReBoardFile;
import com.sist.study.model.ReBoardReply;
import com.sist.study.service.ReBoardService;
import com.sist.study.service.ShopService;

@Controller("ReBoardController")
public class ReBoardController 
{
	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;

	@Value("#{env['auth.cookie.manager']}")
	private String AUTH_COOKIE_MANAGER;
	
	@Value("#{env['ReBoard.upload.save.dir']}")
	private String UPLOAD_REBOARD_DIR;
	
	@Autowired
	private ReBoardService reBoardService;
	
	@Autowired
	private ShopService shopService;
	
	private static Logger logger = LoggerFactory.getLogger(ReBoardController.class);
	
	@RequestMapping("/reboard/list")
	public String ReBoardList(HttpServletRequest request, HttpServletResponse response, Model model)
	{
	    long itemSeq = HttpUtil.get(request, "itemSeq", 0);
		ReBoard reBoard = new ReBoard();
		reBoard.setItemSeq(itemSeq);
		ItemData item = null;
		
		List<ReBoard> list = null;
		
		long totalCount = reBoardService.reBoardTotal(itemSeq);
		
		if(totalCount > 0)
		{
			list = reBoardService.reBoardList(reBoard);
			item = shopService.itemDetailSelect(Long.valueOf(itemSeq).intValue());
			
		}
		
		model.addAttribute("list", list);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("item", item);
		model.addAttribute("itemSeq", itemSeq);

		return "/reBoard/reBoardList";
	}
	
	@RequestMapping("/reboard/view")
    public String ReBoardView( Model model, HttpServletRequest request, HttpServletResponse httpServletResponse)
	{
		long reBoardSeq = HttpUtil.get(request, "reBoardSeq", 0);
		
		logger.debug("ReBoardView reBoardSeq : " + reBoardSeq);
		
        String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
        String cookieManagerId = CookieUtil.getHexValue(request, AUTH_COOKIE_MANAGER);

        ReBoard reboard = reBoardService.reBoardView(reBoardSeq);

        model.addAttribute("reboard", reboard);
        model.addAttribute("cookieUserId", cookieUserId);
        model.addAttribute("cookieManagerId", cookieManagerId);
                
        return "/reBoard/reBoardView";
    }
	
	@RequestMapping("/reboard/insert")
	public String ReBoardInsert(Model model, HttpServletRequest request, HttpServletResponse httpServletResponse)
	{
        String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
        String cookieManagerId = CookieUtil.getHexValue(request, AUTH_COOKIE_MANAGER);
        
        String itemCode = HttpUtil.get(request, "itemCode2", "");
        
        ItemData item = reBoardService.itemCodeSelect(itemCode);
        
        model.addAttribute("cookieUserId", cookieUserId);
        model.addAttribute("cookieManagerId", cookieManagerId);
       // model.addAttribute("itemSeq", item.getItemSeq());
        
		return "/reBoard/reBoardWrite";
	}
	
	@PostMapping("/reboard/reboardWriteProc")
	@ResponseBody
	public ResponseEntity<?> ReBoardWrite(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		String title = HttpUtil.get(request, "title", "");
		String content = HttpUtil.get(request, "content2", "");
		long itemSeq = HttpUtil.get(request, "itemSeq2", 0);
		List<FileData> fileData = new ArrayList<FileData>();

		ReBoard reBoard = new ReBoard();
		
		// 첨부파일을 하나도 하지 않았을 경우 null 컬럼이 들어가는걸 방지
		if(request.getFiles("boardFile").get(0).getSize() != 0)
		{
			fileData = HttpUtil.getFiles(request, "boardFile", UPLOAD_REBOARD_DIR);
		}
		
		if(!StringUtil.isEmpty(title) && !StringUtil.isEmpty(content))
		{
			reBoard.setReBoardTitle(title);
			reBoard.setReBoardContent(content);
			reBoard.setUserId(cookieUserId);
			reBoard.setItemSeq(itemSeq);
			
			if(!StringUtil.isEmpty(fileData) && fileData != null && fileData.size() > 0)
			{
				List<ReBoardFile> reviewFile = new ArrayList<ReBoardFile>();
				
				for(int i=0 ; i<fileData.size(); i++)
				{
					ReBoardFile reviewFile2 = new ReBoardFile();
					
					reviewFile2.setFileName(fileData.get(i).getFileName());
					reviewFile2.setFileOrgName(fileData.get(i).getFileOrgName());
					reviewFile2.setFileExt(fileData.get(i).getFileExt());
					reviewFile2.setFileSize(fileData.get(i).getFileSize());
					
					reviewFile.add(reviewFile2);
				}
				
				reBoard.setReBoardFileList(reviewFile);
			}
			
			try
			{
				if(reBoardService.reBoardInsert(reBoard) > 0)
				{
					return ResponseEntity.ok(0);
				}
				
			}
			catch(Exception e)
			{
				logger.error("[ReBoardController] ReBoardWrite Exception ", e);
				return ResponseEntity.ok(500);
			}
		}
		
		return ResponseEntity.ok(1);
	}
	
	@PostMapping(value="/reboard/reboardDelete")
	@ResponseBody
	public ResponseEntity<?> ReBoardDeleteProc(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		String cookieManagerId = CookieUtil.getHexValue(request, AUTH_COOKIE_MANAGER);
		
		long ReBoardSeq = HttpUtil.get(request, "reBoardSeq", 0);
		
		if(ReBoardSeq > 0)
		{
			ReBoard ReBoard = reBoardService.reBoardView(ReBoardSeq);
			
			if(ReBoard != null)
			{
				if(ReBoard.getUserId().equals(cookieUserId) || !cookieManagerId.isEmpty())
				{
					try
					{
						if(reBoardService.reBoardDelete(ReBoardSeq) > 0)
						{
							return ResponseEntity.ok(0);
						}
						else
						{
							return ResponseEntity.ok(450);
						}
					}
					catch(Exception e)
					{
						logger.error("[ReBoardController] ReBoardDeleteProc Exception ", e);
						return ResponseEntity.ok(500);
					}
				}
				else
				{
					return ResponseEntity.ok(410);
				}
			}
			else
			{
				return ResponseEntity.ok(404);
			}
		}
		else
		{
			return ResponseEntity.ok(400);
		}
	}
	
	@PostMapping("/reboard/updateView")
	public String ReBoardUpdateView(Model model, HttpServletRequest request)
	{
		long reBoardSeq = HttpUtil.get(request, "reBoardSeq", 0);
		long itemSeq = HttpUtil.get(request, "itemSeq", 0);
		
		ReBoard reBoard = reBoardService.reBoardSelect(reBoardSeq);
		
		model.addAttribute("reBoard", reBoard);
		model.addAttribute("itemSeq", itemSeq);
		
		return "/reBoard/reBoardUpdate";
	}
	
	@PostMapping("/reboard/reboardUpdate")
	@ResponseBody
	public ResponseEntity<?> ReBoardUpdate(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		long reBoardSeq = HttpUtil.get(request, "reBoardSeq", 0);
		
		String title = HttpUtil.get(request, "title");
		String content = HttpUtil.get(request, "content2");
		
		List<FileData> fileData = new ArrayList<FileData>();
		
		if(request.getFiles("boardFile").get(0).getSize() != 0)
		{
			fileData = HttpUtil.getFiles(request, "boardFile", UPLOAD_REBOARD_DIR);
		}
		
		if(reBoardSeq > 0 && !StringUtil.isEmpty(title) && !StringUtil.isEmpty(content))
		{
			ReBoard reBoard = reBoardService.reBoardSelect(reBoardSeq); // 기존에 있던 첨부파일
					
			if(reBoard != null)
			{
				if(StringUtil.equals(cookieUserId, reBoard.getUserId()))
				{
					reBoard.setReBoardTitle(title);
					reBoard.setReBoardContent(content);
										
					if(fileData != null && fileData.size() > 0)
					{
						List<ReBoardFile> reviewFile = new ArrayList<ReBoardFile>();
						
						for(int i=0 ; i<fileData.size(); i++)
						{
							ReBoardFile reviewFile2 = new ReBoardFile();
							
							reviewFile2.setFileName(fileData.get(i).getFileName());
							reviewFile2.setFileOrgName(fileData.get(i).getFileOrgName());
							reviewFile2.setFileExt(fileData.get(i).getFileExt());
							reviewFile2.setFileSize(fileData.get(i).getFileSize());
							
							reviewFile.add(reviewFile2);
						}
						
						reBoard.setReBoardFileList(reviewFile);
					}
					
					try
					{
						if(reBoardService.reBoardUpdate(reBoard) > 0)
						{
							return ResponseEntity.ok(0);
						}
						else
						{
							return ResponseEntity.ok(510);
						}
					}
					catch(Exception e)
					{
						logger.error("[ReBoardController] ReBoardUpdate Exception", e);
					}
				}
				else
				{
					return ResponseEntity.ok(410);
				}
			}
			else
			{
				return ResponseEntity.ok(404);
			}
		}
		
		return ResponseEntity.ok(400);
	}
	
	@PostMapping("/reboard/deleteReply")
	@ResponseBody
    public ResponseEntity<?> deleteReply(HttpServletRequest request)
	{
        long replySeq = HttpUtil.get(request, "replySeq", 0);
        
        reBoardService.replyStatusUpdate(replySeq);
        
        return ResponseEntity.ok(0);
    }
	
	@PostMapping("/reboard/insert2")
	@ResponseBody
	public ResponseEntity<?> insert(HttpServletRequest request)
	{
		long ReBoardSeq = HttpUtil.get(request, "reBoardSeq", 0);
		long replyGroup = HttpUtil.get(request, "replyGroup", 0);
		
		String replyContent = HttpUtil.get(request, "replyContent", "");
		
		ReBoardReply reply = new ReBoardReply();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		 
		if(cookieUserId != null && !cookieUserId.isEmpty())
		{
			if(reBoardService.reBoardSelect(ReBoardSeq) != null)
			{
				reply.setUserId(cookieUserId);
				reply.setReBoardSeq(ReBoardSeq);
				
				if(replyContent != null && !replyContent.isEmpty()) // 댓글일때
				{
					reply.setReplyContent(replyContent);
				}
				
				if(reBoardService.replyInsert(reply) > 0)
				{
					return ResponseEntity.ok(0);
				}
				
			}	
			
			return ResponseEntity.ok(404);
		}
		
	    return ResponseEntity.ok(400);
	}
	
	@PostMapping("/reboard/reInsert")
	@ResponseBody
	public ResponseEntity<?> reInsert(HttpServletRequest request)
	{
		long ReBoardSeq = HttpUtil.get(request, "reBoardSeq", 0);
		long replyGroup = HttpUtil.get(request, "replyGroup", 0);
		
		String replyContent = HttpUtil.get(request, "replyContent2", "");
		
		ReBoardReply reply = new ReBoardReply();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		
		if(cookieUserId != null && !cookieUserId.isEmpty())
		{
			if(reBoardService.reBoardSelect(ReBoardSeq) != null)
			{
				reply.setUserId(cookieUserId);
				reply.setReBoardSeq(ReBoardSeq);
				
				if(replyContent != null && !replyContent.isEmpty())
				{
					reply.setReplyContent(replyContent);
					reply.setReplyGroup(replyGroup);
				}
				
				if(reBoardService.replyReInsert(reply) > 0)
				{
					return ResponseEntity.ok(0);
				}
				
			}	
			
			return ResponseEntity.ok(404);
		}
		
		return ResponseEntity.ok(400);
	}

}

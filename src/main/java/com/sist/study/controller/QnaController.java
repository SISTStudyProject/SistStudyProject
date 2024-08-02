package com.sist.study.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.study.model.Manager;
import com.sist.study.model.Paging;
import com.sist.study.model.QnaBoard;
import com.sist.study.model.QnaFile;
import com.sist.study.model.QnaReply;
import com.sist.study.service.QnaService;
import com.sist.study.service.StManagerService;
import com.sist.common.model.FileData;
import com.sist.common.util.CookieUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.StringUtil;

@Controller("QnaController")
public class QnaController 
{
	private static Logger logger = LoggerFactory.getLogger(QnaController.class);
	
	private static final int LIST_NUM = 6;
	private static final int PAGE_NUM = 6;
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private StManagerService managerService;
	
	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;
	
	@Value("#{env['auth.cookie.manager']}")
	private String AUTH_COOKIE_MANAGER;
	
	@Value("#{env['qna.upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	// 글 리스트, 페이징
	@RequestMapping(value="/qna/qnaList")
	public String qnaList(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response)
	{
		String stUserCookie = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		String cookieManagerId = CookieUtil.getHexValue(request, AUTH_COOKIE_MANAGER);
		String searchValue = HttpUtil.get(request, "searchValue","");
		long curPage = HttpUtil.get(request, "curPage", (long)1);

		List<QnaBoard> list = null;
		
		QnaBoard qnaBoard = new QnaBoard();
		
		Paging paging = null;
		long totalBoard = 0;
		
		if(!StringUtil.isEmpty(searchValue))
		{
			qnaBoard.setSearchValue(searchValue);
		}
		
		totalBoard = qnaService.totalQna(qnaBoard);
		
		if(totalBoard > 0)
		{                     
			paging = new Paging("/qna/qnaList", totalBoard, LIST_NUM, PAGE_NUM, curPage, "curPage");
			
			qnaBoard.setStartRow(paging.getStartRow());
			qnaBoard.setEndRow(paging.getEndRow());
			
			list = qnaService.boardList(qnaBoard);
		}
				
		modelMap.addAttribute("stUserCookie", stUserCookie);
		modelMap.addAttribute("cookieManagerId", cookieManagerId);
		modelMap.addAttribute("list", list);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("curPage", curPage);
		modelMap.addAttribute("paging", paging);
		
		return "/qna/qnaList";
	}
	
	// 글 상세
	@RequestMapping("/qna/qnaView")
	public String quaDetail(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		String cookieManagerId = CookieUtil.getHexValue(request, AUTH_COOKIE_MANAGER);
		
		String searchValue = HttpUtil.get(request, "searchValue","");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		long qnaboardSeq = HttpUtil.get(request, "qnaboardSeq", (long)0);

		QnaBoard qnaBoard = null;
		
		if(qnaboardSeq > 0)
		{
			qnaBoard = qnaService.boardSelect(qnaboardSeq);
			
			if(qnaBoard != null)
			{
				model.addAttribute("cookieUserId", cookieUserId);
				model.addAttribute("cookieManagerId", cookieManagerId);
				model.addAttribute("searchValue", searchValue);
				model.addAttribute("curPage", curPage);
				model.addAttribute("qnaBoard", qnaBoard);
				
				// 첨부파일 있는지 확인
				if(qnaBoard.getQnaFile() != null)
				{
					logger.debug(qnaBoard.getQnaFile().getFileName());
					model.addAttribute("qnaFile", qnaBoard.getQnaFile());
				}
				
				// 답변 있는지 확인
				if(qnaBoard.getReplyFlag().equals("Y"))
				{
					model.addAttribute("qnaReply",qnaBoard.getQnaReply());
				}

				// 비밀글인지 확인
				if(qnaBoard.getSecretFlag().equals("Y"))
				{
					if(cookieUserId.equals(qnaBoard.getUserId()) || managerService.stManagerSelect(cookieManagerId) != null)
					{
						return "/qna/qnaView";
					}
					else
					{
						return "/qna/qnaList";
					}
				}
			}
		}
		
		return "/qna/qnaView";
	}
	
	// 글 작성 페이지로 이동
	@RequestMapping("/qna/qnaWrite")
	public String qnaWrite(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		model.addAttribute("searchValue", HttpUtil.get(request, "searchValue", ""));
		model.addAttribute("curPage", HttpUtil.get(request, "curPage", (long)1));
		
		return "/qna/qnaWrite";
	}
	
	// 글 등록
	@PostMapping("/qna/qnaWriteProc")
	@ResponseBody
	public ResponseEntity<?> qnaWriteProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);

		String title = HttpUtil.get(request, "title", "");
		String content = HttpUtil.get(request, "content2", "");
		String secretFlag = HttpUtil.get(request, "secretFlag", "N");

		FileData fileData = HttpUtil.getFile(request, "boardFile", UPLOAD_SAVE_DIR);
		
		QnaBoard qnaBoard = new QnaBoard();
		
		if(!StringUtil.isEmpty(title) && !StringUtil.isEmpty(content))
		{
			qnaBoard.setQnaBoardTitle(title);
			qnaBoard.setQnaBoardContent(content);
			qnaBoard.setUserId(cookieUserId);
			qnaBoard.setSecretFlag(secretFlag);
			
			if(fileData != null && fileData.getFileSize() > 0)
			{
				QnaFile qnaFile = new QnaFile();
				
				qnaFile.setFileExt(fileData.getFileExt());
				qnaFile.setFileName(fileData.getFileName());
				qnaFile.setFileOrgName(fileData.getFileOrgName());
				qnaFile.setFileSize(fileData.getFileSize());
				
				qnaBoard.setQnaFile(qnaFile);
			}
			
			try
			{
				if(qnaService.boardInsert(qnaBoard) > 0)
				{
					return ResponseEntity.ok(0);
				}
				
			}
			catch(Exception e)
			{
				logger.error("[QnaController] qnaWriteProc Exception ", e);
				return ResponseEntity.ok(500);
			}
		}
		
		return ResponseEntity.ok(1);
	}

	// 글 삭제
	@PostMapping("/qna/qnaDeleteProc")
	@ResponseBody
	public ResponseEntity<?> qnaDeleteProc(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_USER);
		String cookieManagerId = CookieUtil.getHexValue(request, AUTH_COOKIE_MANAGER);
		long qnaBoardSeq = HttpUtil.get(request, "qnaBoardSeq", 0L);
		
		if(qnaBoardSeq > 0)
		{
			QnaBoard qnaBoard = qnaService.boardSelect(qnaBoardSeq);

			if(qnaBoard != null)
			{
				if(cookieUserId.equals(qnaBoard.getUserId()) || managerService.stManagerSelect(cookieManagerId) != null)
				{
					try
					{
						if(qnaService.boardDelete(qnaBoardSeq) > 0)
						{
							return ResponseEntity.ok(0);
						}
						else
						{
							return ResponseEntity.ok(500);
						}
					}
					catch(Exception e)
					{
						logger.error("[QnaController] qnaDeleteProc Exception", e);
						return ResponseEntity.ok(500);
					}
				}
				
				return ResponseEntity.ok(505);
			}			
		}
		
		return ResponseEntity.ok(404);
	}
	
	// 답글 입력
	@PostMapping("/qna/qnaReplyProc")
	@ResponseBody
	public ResponseEntity<?> qnaReplyProc(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		String cookieManagerId = CookieUtil.getHexValue(request, AUTH_COOKIE_MANAGER);
		logger.debug("cookieManagerId "+cookieManagerId);
		String reply = HttpUtil.get(request, "comment");
		String searchValue = HttpUtil.get(request, "searchValue");
		long curPage = HttpUtil.get(request, "curPage", 1L);
		long qnaBoardSeq = HttpUtil.get(request, "qnaBoardSeq", (long)0);
		
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		
		if(!cookieManagerId.isEmpty() && managerService.stManagerSelect(cookieManagerId) != null)
		{
			if(!reply.isEmpty() && qnaBoardSeq > 0)
			{
				QnaReply qnaReply = new QnaReply();
				qnaReply.setManagerId(cookieManagerId);
				qnaReply.setQnaboardSeq(qnaBoardSeq);
				qnaReply.setReplyContent(reply);
				
				try
				{
					if(qnaService.replyInsert(qnaReply) > 0) return ResponseEntity.ok(0);
				}
				catch(Exception e)
				{
					logger.error("[QnaController] qnaReplyProc Exception ", e);
					return ResponseEntity.ok(500);
				}
			}
			else
			{
				return ResponseEntity.ok(404);
			}
		}
		
		return ResponseEntity.ok(400);
	}
	
	// 답글 수정
	@PostMapping("/qna/qnaReplyUpdate")
	@ResponseBody
	public ResponseEntity<?> qnaReplyUpdate(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieManagerId = CookieUtil.getHexValue(request, AUTH_COOKIE_MANAGER);
		String comment = HttpUtil.get(request, "comment");
		long qnaBoardSeq = HttpUtil.get(request, "qnaBoardSeq", (long)0);
		QnaReply qnaReply = null;
		
		if(!comment.isEmpty() && !cookieManagerId.isEmpty())
		{
			if(qnaBoardSeq > 0)
			{
				qnaReply = qnaService.replySelect(qnaBoardSeq);
				
				if(qnaReply != null)
				{
					qnaReply.setReplyContent(comment);
					if(qnaService.replyUpdate(qnaReply) > 0)
					{
						return ResponseEntity.ok(1);
					}
					
					return ResponseEntity.ok(500);
				}
				
				return ResponseEntity.ok(404);
			}
			
			return ResponseEntity.ok(404);
		}
		
		return ResponseEntity.ok(400);
	}
	
	// 답글 삭제
	@PostMapping("/qna/qnaReplyDelete")
	@ResponseBody
	public ResponseEntity<?> qnaReplyDelete(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieManagerId = CookieUtil.getHexValue(request, AUTH_COOKIE_MANAGER);
		long qnaBoardSeq = HttpUtil.get(request, "qnaBoardSeq", (long)0);
		
		if(!cookieManagerId.isEmpty() && managerService.stManagerSelect(cookieManagerId) != null)
		{
			if(qnaBoardSeq > 0)
			{
				
				try
				{
					if(qnaService.replyDelete(qnaBoardSeq) > 0) return ResponseEntity.ok(0);
				}
				catch(Exception e)
				{
					logger.error("[QnaController] qnaReplyDelete Exception ", e);
					return ResponseEntity.ok(500);
				}
			}
			else
			{
				return ResponseEntity.ok(404);
			}
		}
		
		return ResponseEntity.ok(400);
	}
}

package com.sist.study.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.common.model.FileData;
import com.sist.common.util.CookieUtil;
import com.sist.common.util.FileUtil;
import com.sist.common.util.HttpUtil;
import com.sist.common.util.JsonUtil;
import com.sist.common.util.StringUtil;
import com.sist.study.model.ItemData;
import com.sist.study.model.ItemFile;
import com.sist.study.model.Paging;
import com.sist.study.model.QnaBoard;
import com.sist.study.model.QnaReply;
import com.sist.study.model.ReBoard;
import com.sist.study.model.ReBoardReply;
import com.sist.study.model.Response;
import com.sist.study.model.StManager;
import com.sist.study.model.StUser;
import com.sist.study.service.StManagerService;
import com.sist.study.service.StUserService;

@Controller("ManagerController")
public class ManagerController 
{
	private static Logger logger = LoggerFactory.getLogger(ManagerController.class);
	
	@Value("#{env['auth.cookie.user']}")
	private String AUTH_COOKIE_USER;
	
	@Value("#{env['auth.cookie.manager']}")
	private String AUTH_COOKIE_MANAGER;
	
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_DIR;
	
	private static final int LIST_COUNT = 5;
	private static final int PAGE_COUNT = 5;
	
	@Autowired
	private StManagerService stManagerService;
	
	@Autowired
	private StUserService stUserService;
	
	@RequestMapping(value = "/manager/login", method = RequestMethod.GET)
	public String managerLogin(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{

		if(CookieUtil.getCookie(httpServletRequest, AUTH_COOKIE_MANAGER) == null)
		{
			return "/manager/login";
		}
		else
		{
			CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_MANAGER);
			return "redirect:/"; //재접속 하라는 명령
		}
	}
	
	@PostMapping(value = "/manager/loginProc")
	@ResponseBody
	public Response<Object> managerLoginProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		
		String managerId = HttpUtil.get(httpServletRequest, "managerId", "");
		String managerPwd = HttpUtil.get(httpServletRequest, "managerPwd", "");
	
		StManager stManager = null;
		
		if(!StringUtil.isEmpty(managerId) && !StringUtil.isEmpty(managerPwd))
		{
			stManager = stManagerService.stManagerSelect(managerId);
			
			if(stManager != null)
			{
				if(StringUtil.equals(stManager.getManagerPwd(), managerPwd))
				{
					if(StringUtil.equals(stManager.getStatus(), "Y"))
					{
						CookieUtil.addCookie(httpServletResponse, "/",  -1, AUTH_COOKIE_MANAGER, CookieUtil.stringToHex(managerId));
						ajaxObject.setResponse(200, "Ok");
					}
					else if(StringUtil.equals(stManager.getStatus(), "N"))
					{
						ajaxObject.setResponse(410, "Gone");	
					}
					else
					{
						ajaxObject.setResponse(403, "Forbidden");
					}
				}
				else
				{
					ajaxObject.setResponse(401, "Unauthorized");
				}
			}
			else
			{
				ajaxObject.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[ManagerController] managerLoginProc response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}
		
		return ajaxObject;
	}
	
	@RequestMapping(value = "/manager/logout")
	public String managerLogout(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		if(CookieUtil.getCookie(httpServletRequest, AUTH_COOKIE_MANAGER) != null)
		{
			CookieUtil.deleteCookie(httpServletRequest, httpServletResponse, "/", AUTH_COOKIE_MANAGER);
		}
		return "redirect:/manager/login";
	}	
	
	@RequestMapping(value = "/manager/index")
	public String managerIndex(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);
		
		List<StUser> stUserList = null;
		StUser stUser = new StUser();
		stUser.setEndRow(LIST_COUNT);
		stUserList = stManagerService.stUserList(stUser);

		
		List<ItemData> itemDataList = null;
		ItemData itemData = new ItemData();
		itemData.setEndRow(LIST_COUNT);
		itemDataList = stManagerService.itemDataList(itemData);
		
		
		List<ReBoard> reBoardList = null;
		ReBoard reBoard = new ReBoard();
		reBoard.setEndRow(LIST_COUNT);
		reBoardList = stManagerService.reBoardList(reBoard);
		
		List<QnaBoard> qnaBoardList = null;
		QnaBoard qnaBoard = new QnaBoard();
		qnaBoard.setEndRow(LIST_COUNT);
		qnaBoardList = stManagerService.qnaBoardList(qnaBoard);
		
		modelMap.addAttribute("stManagerCookie", stManagerCookie);	
		
		modelMap.addAttribute("stUserList", stUserList);
		modelMap.addAttribute("itemDataList", itemDataList);
		modelMap.addAttribute("reBoardList", reBoardList);
		modelMap.addAttribute("qnaBoardList", qnaBoardList);
		
		return "/manager/index";
	}
	
	@RequestMapping(value = "/manager/usermanagement")
	public String managerUsermanagement(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);
		
		List<StUser> stUserList = null;
		
		StUser stUser = new StUser();
		Paging paging = null;
		
		String searchValue = HttpUtil.get(httpServletRequest, "searchValue", "");
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		
		if(!StringUtil.isEmpty(searchValue))
		{
			stUser.setSearchValue(searchValue);
		}
		
		long stUserCount = stManagerService.stUserListCount(stUser);
		
		if(stUserCount > 0)
		{
			paging = new Paging("/manager/usermanagement", stUserCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			stUser.setStartRow(paging.getStartRow());
			stUser.setEndRow(paging.getEndRow());
			stUserList = stManagerService.stUserList(stUser);				
		}
				
		modelMap.addAttribute("stManagerCookie", stManagerCookie);
		modelMap.addAttribute("stUserList", stUserList);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("paging", paging);
		
		return "/manager/userManagement";
	}
	
	@RequestMapping(value="/manager/userManagementDetail")
	public String userUpdate2(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);
		String userId = HttpUtil.get(httpServletRequest, "userId", "");		
		
		if(!StringUtil.isEmpty(userId))
		{
			StUser stUser = stUserService.stUserSelect(userId);
			
			if(stUser != null)
			{
				modelMap.addAttribute("stUser", stUser);
			}
		}
		modelMap.addAttribute("stManagerCookie", stManagerCookie);
		return "/manager/userManagementDetail";
	}
	
	@PostMapping("/manager/userManagementInformationChange")
	@ResponseBody
	public Response<Object> userManagementInformationChange(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		String userId = HttpUtil.get(httpServletRequest, "userId", "");
		String userPwd = HttpUtil.get(httpServletRequest, "userPwd", "");
		String userEmail = HttpUtil.get(httpServletRequest, "userEmail", "");
		String userTel = HttpUtil.get(httpServletRequest, "userTel", "");
		long userPoint = HttpUtil.get(httpServletRequest, "userPoint", 0);
		String status = HttpUtil.get(httpServletRequest, "status", "");
		
		StUser stUser = null;
		
		if(!StringUtil.isEmpty(userId))
		{
			stUser = stUserService.stUserSelect(userId);
			
			if(stUser != null)
			{
				stUser.setUserPwd(userPwd);
				stUser.setUserEmail(userEmail);
				stUser.setUserTel(userTel);
				stUser.setUserPoint(userPoint);
				stUser.setStatus(status);
				
				if(stManagerService.stUserListUpdate(stUser) > 0)
				{
					ajaxObject.setResponse(200, "Ok");
				}
				else
				{
					ajaxObject.setResponse(500, "Internal Server Error");
				}
			}
			else
			{
				ajaxObject.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
		}
		if(logger.isDebugEnabled())
		{
			logger.debug("[ManagerController] userManagementInformationChange response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}
		
		return ajaxObject;
	}
	
	@RequestMapping(value = "/manager/productmanagement")
	public String managerProductManagement(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);
		
		List<ItemData> itemDataList = null;
		
		ItemData itemData = new ItemData();
		Paging paging = null;
		
		String searchType = HttpUtil.get(httpServletRequest, "searchType", "");
		String searchValue = HttpUtil.get(httpServletRequest, "searchValue", "");
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			itemData.setSearchType(searchType);
			itemData.setSearchValue(searchValue);
		}
		
		long stItemDataCount = stManagerService.itemDataListCount(itemData);
		
		if(stItemDataCount > 0)
		{
			paging = new Paging("/manager/productmanagement", stItemDataCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			itemData.setStartRow(paging.getStartRow());
			itemData.setEndRow(paging.getEndRow());
			itemDataList = stManagerService.itemDataList(itemData);				
		}
				
		modelMap.addAttribute("stManagerCookie", stManagerCookie);
		modelMap.addAttribute("itemDataList", itemDataList);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("paging", paging);
		
		return "/manager/productManagement";
	}
	
	@RequestMapping(value = "/manager/productmanagementwrite")
	public String managerProductManagementWrite(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);

		modelMap.addAttribute("stManagerCookie", stManagerCookie);	
		return "/manager/productWrite";
	}
	
	@ResponseBody
	@PostMapping(value = "/manager/managerProductWriteProc")
	public Response<Object> managerProductManagementWriteProc(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		
		FileData fileData = HttpUtil.getFile(multipartHttpServletRequest, "itemDataImangeFile", UPLOAD_DIR);

		String itemName = HttpUtil.get(multipartHttpServletRequest, "itemName", "");
		String itemCode = HttpUtil.get(multipartHttpServletRequest, "itemCode", "");
		String itemIntro = HttpUtil.get(multipartHttpServletRequest, "itemIntro", "");
		String itemCate = HttpUtil.get(multipartHttpServletRequest, "itemCate", "");
		long itemPrice = HttpUtil.get(multipartHttpServletRequest, "itemPrice", 0);
		long stock = HttpUtil.get(multipartHttpServletRequest, "stock", 0);
		
		if(!StringUtil.isEmpty(itemName) && !StringUtil.isEmpty(itemCate) && itemPrice > 0 && stock >= 0)
		{
			ItemData itemData = new ItemData();

			itemData.setItemName(itemName);
			itemData.setItemCode(itemCode);
			itemData.setItemIntro(itemIntro);
			itemData.setItemCate(itemCate);
			itemData.setItemPrice(itemPrice);
			itemData.setStock(stock);
				
			if(fileData != null && fileData.getFileSize() > 0)
			{
				if(!StringUtil.equals(fileData.getFileExt(), "jpg") && !StringUtil.equals(fileData.getFileExt(), "jpeg") && !StringUtil.equals(fileData.getFileExt(), "png"))
				{
					ajaxObject.setResponse(410, "Conflict");
					FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
					return ajaxObject;
				}
				else
				{
					ItemFile itemFile = new ItemFile();
					
					itemFile.setFileName(fileData.getFileName());
					itemFile.setFileOrgName(fileData.getFileOrgName());
					itemFile.setFileExt(fileData.getFileExt());
					itemFile.setFileSize(fileData.getFileSize());
					
					itemData.setItemFile(itemFile);
				}
				
				try 
				{
					if(stManagerService.itemDataInsert(itemData) > 0)
					{
						ajaxObject.setResponse(200, "Ok");
					}
					else
					{
						ajaxObject.setResponse(500, "Internal Server Error");
						FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
					}
				} 
				catch (Exception e) 
				{
					
					logger.error("[ManagerController] managerProductManagementWriteProc Exception Error" + e);
					ajaxObject.setResponse(500, "Internal Server Error");
					FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
				}
			}
			else
			{
				ajaxObject.setResponse(410, "Conflict");
				return ajaxObject;
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
			FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[ManagerController] managerProductManagementWriteProc response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}

		
		return ajaxObject;
	}
	
	@RequestMapping(value = "/manager/productmanagementmodify")
	public String managerProductManagementModify(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);
		
		ItemData itemData = null;
		long itemSeq = HttpUtil.get(httpServletRequest, "itemSeq", 0);
		
		if(itemSeq > 0)
		{
			itemData = stManagerService.itemDataSelect(itemSeq);
			if(itemData != null)
			{
				modelMap.addAttribute("itemData", itemData);	
			}
			else
			{
				modelMap.addAttribute("itemData", null);
			}
		}
		else
		{
			modelMap.addAttribute("itemData", null);
		}
		
		modelMap.addAttribute("stManagerCookie", stManagerCookie);	
		return "/manager/productModify";
	}
	
	@ResponseBody
	@PostMapping(value = "/manager/managerProductModifyProc")
	public Response<Object> managerProductManagementModifyProc(MultipartHttpServletRequest multipartHttpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		
		FileData fileData = HttpUtil.getFile(multipartHttpServletRequest, "itemDataImangeFile", UPLOAD_DIR);
		//List<FileData> fileData = HttpUtil.getFiles(multipartHttpServletRequest, "itemDataImangeFile", UPLOAD_DIR);
		
		ItemData itemData = null;
		
		long itemSeq = HttpUtil.get(multipartHttpServletRequest, "itemSeq", 0);
		String itemName = HttpUtil.get(multipartHttpServletRequest, "itemName", "");
		String itemCode = HttpUtil.get(multipartHttpServletRequest, "itemCode", "");
		String itemCate = HttpUtil.get(multipartHttpServletRequest, "itemCate", "");
		String itemIntro = HttpUtil.get(multipartHttpServletRequest, "itemIntro", "");
		long itemPrice = HttpUtil.get(multipartHttpServletRequest, "itemPrice", 0);
		long stock = HttpUtil.get(multipartHttpServletRequest, "stock", 0);
		String uploadFile = HttpUtil.get(multipartHttpServletRequest, "uploadFile", "N");
		
		if(itemSeq > 0 && !StringUtil.isEmpty(itemName) && !StringUtil.isEmpty(itemCate) && itemPrice > 0 && stock >= 0)
		{
			itemData = stManagerService.itemDataSelect(itemSeq);
			
			if(itemData != null)
			{
				itemData.setItemName(itemName);
				itemData.setItemCode(itemCode);
				itemData.setItemCate(itemCate);
				itemData.setItemIntro(itemIntro);
				itemData.setItemPrice(itemPrice);
				itemData.setStock(stock);
				
				if(fileData != null && fileData.getFileSize() > 0)
				{
					if(!StringUtil.equals(fileData.getFileExt(), "jpg") && !StringUtil.equals(fileData.getFileExt(), "jpeg") && !StringUtil.equals(fileData.getFileExt(), "png"))
					{
						ajaxObject.setResponse(410, "Conflict");
						FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
						return ajaxObject;
					}
					else
					{
						ItemFile itemFile = new ItemFile();
						
						itemFile.setFileName(fileData.getFileName());
						itemFile.setFileOrgName(fileData.getFileOrgName());
						itemFile.setFileExt(fileData.getFileExt());
						itemFile.setFileSize(fileData.getFileSize());
						itemData.setItemFile(itemFile);
					}
				}
				else
				{
					if(StringUtil.equals(uploadFile, "N"))
					{
						ajaxObject.setResponse(410, "Conflict");
						return ajaxObject;
					}
				}
				
				try 
				{
					if(stManagerService.itemDataUpdate(itemData) > 0)
					{
						ajaxObject.setResponse(200, "Ok");
					}
					else
					{
						ajaxObject.setResponse(500, "Internal Server Error");
						FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
					}
				} 
				catch (Exception e) 
				{
					
					logger.error("[ManagerController] managerProductManagementModifyProc Exception Error" + e);
					ajaxObject.setResponse(500, "Internal Server Error");
					FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
				}
			}
			else
			{
				ajaxObject.setResponse(404, "Not Found");
				FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
			FileUtil.deleteFile(UPLOAD_DIR + FileUtil.getFileSeparator() + fileData.getFileName());
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[ManagerController] managerProductManagementModifyProc response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}

		
		return ajaxObject;
	}
	
	
	@RequestMapping(value = "/manager/reviewmanagement")
	public String managerReviewManagement(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);

		List<ReBoard> reBoardList = null;
		
		ReBoard reBoard = new ReBoard();
		Paging paging = null;
		
		String searchType = HttpUtil.get(httpServletRequest, "searchType", "");
		String searchValue = HttpUtil.get(httpServletRequest, "searchValue", "");
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			reBoard.setSearchType(searchType);
			reBoard.setSearchValue(searchValue);
		}
		
		long stItemDataCount = stManagerService.reBoardListCount(reBoard);
		
		if(stItemDataCount > 0)
		{
			paging = new Paging("/manager/reviewmanagement", stItemDataCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			reBoard.setStartRow(paging.getStartRow());
			reBoard.setEndRow(paging.getEndRow());
			reBoardList = stManagerService.reBoardList(reBoard);				
		}
				
		modelMap.addAttribute("stManagerCookie", stManagerCookie);
		modelMap.addAttribute("reBoardList", reBoardList);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("paging", paging);
		
		return "/manager/reviewManagement";
	}
	
	@RequestMapping(value = "/manager/reviewContent")
	public String managerReviewContentView(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);
		long reBoardSeq = HttpUtil.get(httpServletRequest, "reBoardSeq", 0);
		ReBoard reBoard = null;
		
		if(reBoardSeq > 0)
		{
			reBoard = stManagerService.reBoardSelect(reBoardSeq);
			
			if(reBoard != null)
			{
				modelMap.addAttribute("reBoard", reBoard);
			}
			else
			{
				modelMap.addAttribute("reBoard", null);
			}
		}
		else
		{
			modelMap.addAttribute("reBoard", null);
		}
		
		modelMap.addAttribute("stManagerCookie", stManagerCookie);
		return "/manager/reviewContent";
	}
	
	@PostMapping(value="/manager/reviewDeleteProc")
	@ResponseBody
	public Response<Object> managerReviewDeleteProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		
		long reBoardSeq = HttpUtil.get(httpServletRequest, "reBoardSeq", 0);
		ReBoard reBoard = null;
		
		if(reBoardSeq > 0)
		{
			reBoard = stManagerService.reBoardSelect(reBoardSeq);
			
			if(reBoard != null)
			{
				try 
				{
					if(stManagerService.reBoardDelete(reBoard) > 0)
					{
						ajaxObject.setResponse(200, "Ok");	
					}
					else
					{
						ajaxObject.setResponse(500, "Internal Server Error");	
					}
				} 
				catch (Exception e) 
				{
					ajaxObject.setResponse(500, "Internal Server Error");	
					logger.error("[ManagerController] managerReviewDeleteProc Exception Error" + e);
					
				}
			}
			else
			{
				ajaxObject.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[ManagerController] managerReviewDeleteProc response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}
		
		return ajaxObject;
	}
	
	@PostMapping(value="/manager/replyDeleteProc")
	@ResponseBody
	public Response<Object> managerReplyDeleteProc(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		
		long replySeq = HttpUtil.get(httpServletRequest, "replySeq", 0);
		ReBoardReply reBoardReply = null;
		
		if(replySeq > 0)
		{
			reBoardReply = stManagerService.reBoardReplySelect(replySeq);
			
			if(reBoardReply != null)
			{
				if(stManagerService.reBoardReplyUpdate(replySeq) > 0)
				{
					ajaxObject.setResponse(200, "Ok");
				}
				else
				{
					ajaxObject.setResponse(500, "Internal Server Error");
				}
			}
			else
			{
				ajaxObject.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[ManagerController] managerReplyDeleteProc response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}
		
		return ajaxObject;
	}
	
	
	@RequestMapping(value = "/manager/qnamanagement")
	public String managerQnAManagement(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);
		
		List<QnaBoard> qnaBoardList = null;
		
		QnaBoard qnaBoard = new QnaBoard();
		Paging paging = null;
		
		String searchType = HttpUtil.get(httpServletRequest, "searchType", "");
		String searchValue = HttpUtil.get(httpServletRequest, "searchValue", "");
		long curPage = HttpUtil.get(httpServletRequest, "curPage", 1);
		
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue))
		{
			qnaBoard.setSearchType(searchType);
			qnaBoard.setSearchValue(searchValue);
		}
		
		long stItemDataCount = stManagerService.qnaBoardListCount(qnaBoard);
		
		if(stItemDataCount > 0)
		{
			paging = new Paging("/manager/qnamanagement", stItemDataCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			qnaBoard.setStartRow(paging.getStartRow());
			qnaBoard.setEndRow(paging.getEndRow());
			qnaBoardList = stManagerService.qnaBoardList(qnaBoard);				
		}
				
		modelMap.addAttribute("stManagerCookie", stManagerCookie);
		modelMap.addAttribute("qnaBoardList", qnaBoardList);
		modelMap.addAttribute("searchType", searchType);
		modelMap.addAttribute("searchValue", searchValue);
		modelMap.addAttribute("paging", paging);
		
		return "/manager/qnaManagement";
	}
	
	@RequestMapping(value = "/manager/qnaboardContent", method = RequestMethod.GET)
	public String managerqnaContentPopup(ModelMap modelMap, HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);
		long qnaBoardSeq = HttpUtil.get(httpServletRequest, "qnaBoardSeq", 0);
		
		QnaBoard qnaBoard  = null;
		if(qnaBoardSeq > 0)
		{
			qnaBoard = stManagerService.qnaBoardSelect(qnaBoardSeq);
			
			if(qnaBoard != null)
			{
				modelMap.addAttribute("qnaBoard", qnaBoard);
			}
			else
			{
				modelMap.addAttribute("qnaBoard", null);
			}
		}
		else
		{
			modelMap.addAttribute("qnaBoard", null);
		}

		modelMap.addAttribute("stManagerCookie", stManagerCookie);

		return "/manager/qnaboardContent";
	}
	
	@PostMapping(value = "/manager/qnaReplyProc")
	@ResponseBody
	public Response<Object> qnaReplyProc (HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		
		String stManagerCookie = CookieUtil.getHexValue(httpServletRequest, AUTH_COOKIE_MANAGER);
		long qnaBoardSeq = HttpUtil.get(httpServletRequest, "qnaBoardSeq", 0);
		String replyContent = HttpUtil.get(httpServletRequest, "replyContent", "");
		
		QnaBoard qnaBoard = null;
		
		if(qnaBoardSeq > 0 && !StringUtil.isEmpty(replyContent))
		{
			qnaBoard = stManagerService.qnaBoardSelect(qnaBoardSeq);
			
			if(qnaBoard != null)
			{
				try 
				{
					QnaReply qnaReply = new QnaReply();
					
					qnaReply.setManagerId(stManagerCookie);
					qnaReply.setQnaboardSeq(qnaBoardSeq);
					qnaReply.setReplyContent(replyContent);
					
					if(stManagerService.qnaReplyInsert(qnaReply, qnaBoard) > 0)
					{
						ajaxObject.setResponse(200, "Ok");
					}
					else
					{
						ajaxObject.setResponse(500, "Internal Server Error");
					}
				}
				catch (Exception e) 
				{
					logger.error("[StManagerService] qnaReplyInsert Exception Error" + e);
					ajaxObject.setResponse(500, "Internal Server Error");
				}
			}
			else
			{
				ajaxObject.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[ManagerController] qnaReplyProc response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}
		
		return ajaxObject;
	}
	
	
	@ResponseBody
	@PostMapping(value = "/manager/qnaBoardContentDelete")
	public Response<Object> qnaBoardContentDelete(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse)
	{
		Response<Object> ajaxObject = new Response<Object>();
		
		long qnaBoardSeq = HttpUtil.get(httpServletRequest, "qnaBoardSeq", 0);
		
		if(qnaBoardSeq > 0)
		{
			QnaBoard qnaBoard = stManagerService.qnaBoardSelect(qnaBoardSeq);
			
			if(qnaBoard != null)
			{
				try 
				{
					if(stManagerService.qnaBoardDelete(qnaBoard) > 0)
					{
						ajaxObject.setResponse(200, "Ok");
					}
					else
					{
						ajaxObject.setResponse(500, "Internal Server Error");
						throw new RuntimeException();
					}
				}
				catch (Exception e) 
				{
					ajaxObject.setResponse(500, "Internal Server Error");
					logger.error("[StManagerService] qnaBoardDelete Exception Error " + e);					
				}
			}
			else
			{
				ajaxObject.setResponse(404, "Not Found");
			}
		}
		else
		{
			ajaxObject.setResponse(400, "Bad Request");
		}
		if(logger.isDebugEnabled())
		{
			logger.debug("[ManagerController] qnaReplyProc response \n" + JsonUtil.toJsonPretty(ajaxObject));
		}
		
		return ajaxObject;
	}
}
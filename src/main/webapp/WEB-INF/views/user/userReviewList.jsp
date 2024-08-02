<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head2.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Monami | shop</title>
<link rel='stylesheet' href='/resources/css/woocommerce-layout.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
<link rel='stylesheet' href='/resources/css/woocommerce.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/font-awesome.min.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/style.css' type='text/css' media='all'/>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/easy-responsive-shortcodes.css' type='text/css' media='all'/>

<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript" src="/resources/js/icia.ajax.js"></script>

<style>
	.div1 
	{
	  width : 100px;
	  height: 100px;
	  background-color: #f5d682;
	  border: 1px solid red;
	}

	.category {
		display: flex;
		position: reletive;
		justify-content: center;
		align-items: center;
		z-index: 1;
		padding: 10px 0;
/* 		border-top: 1px solid; */
/* 		border-bottom: 1px solid; */
		margin-bottom: 50px;
	}
	
	.item-cate {
		padding: 0 20px; 
		border-right: 1px solid gray;
		line-height: 0.8;
		cursor: pointer; 
	}
	
	.item-cate:last-child {
		border-right: none;
	}
</style>

</head>
<body class="archive post-type-archive post-type-archive-product woocommerce woocommerce-page">
	<div id="page">
		<div class="container">
		<%@ include file="/WEB-INF/views/include/nav.jsp"%>

		<div id="content" class="site-content">
			<div id="primary" class="content-area column full">
				<main id="main" class="site-main" role="main">
					<h3 style="margin-left:39.5%;">MyPage Review List</h3>					
			        	<br>
			        	<br>
			        	<h4 style="margin-left:47.5%;">후기내역</h4>
			        	<br>
			        	<div class="row justify-content-center">
			            	<table class="table table-ws w-75 p-3">
			            	
			                	<thead class="mb-5">
			                    	<tr>
			                        	<th scope="col" class="text-center" style="width:7%"></th>
			                            <th scope="col" class="text-center" style="width:7%">번호</th>
			                            <th scope="col" class="text-center" style="width:10%">제목</th>
			                            <th scope="col" class="text-center" style="width:20%">작성일자</th>
			                            <th scope="col" class="text-center" style="width:10%">조회 수</th>
			                            <th scope="col" class="text-center" style="width:20%">상품명</th>
			                            <th scope="col" class="text-center" style="width:10%"></th>
			                        </tr>
			                    </thead>
								<tbody>
				        		<c:choose>
									<c:when test="${!empty reBoardList}">
										<c:forEach var="reBoardList" items="${reBoardList}" varStatus="status">	
	
				                	<tr class="justify-content-center">
				                		<td></td>
				                        <td class="text-center">${reBoardList.reBoardSeq}</td>
										<td class="text-center"><a style="cursor:pointer" onclick="fn_view('${reBoardList.reBoardSeq}')">${reBoardList.reBoardTitle}</a></td>				                        <td class="text-center">${reBoardList.regDate}</td>
				                        <td class="text-center">${reBoardList.reBoardReadCnt}</td>
				                        <td class="text-center">${reBoardList.itemName}</td>
				                        <td class="text-center">
				                        	<button id="reviewDeleteBtn" name="reviewDeleteBtn" type="button" onclick="reViewListDelete(${reBoardList.reBoardSeq})" class="btn btn-primary">삭제</button>
				                        </td>
				                	</tr>
										</c:forEach>
			                      	</c:when>
			                      	<c:otherwise>
					                	<tfoot>
					                    	<tr>
					                        	<td colspan="5">후기 내역이 없습니다.</td>
					                        </tr>
					                    </tfoot>
			                    	</c:otherwise>
			                   	</c:choose>
								</tbody>
			            	</table>
			            </div>
			       
			
			            <!-- 페이징 -->
						<div class="text-center py-4">
			                <div class="custom-pagination" style="margin-left: 450px;">
								<c:if test="${!empty reBoardPaging}">
									<c:if test="${reBoardPaging.prevBlockPage gt 0}">     
										<a class="prev" href="javascript:void(0)" onclick="reviewPaging(${reBoardPaging.prevBlockPage})">Previous</a>  
									</c:if>   
										<c:forEach var="i" begin="${reBoardPaging.startPage}" end="${reBoardPaging.endPage}">
								<c:choose>
									<c:when test="${i ne curPage1}">
										<a href="javascript:void(0)" onclick="reviewPaging(${i})">${i}</a>
						        	</c:when>
						        	<c:otherwise>
						        		<a class="active"href="javascript:void(0)">${i}</a>
						        	</c:otherwise>
						  			</c:choose>
						  		</c:forEach>
									<c:if test="${reBoardPaging.nextBlockPage gt 0}">
						                   <a class="next" href="javascript:void(0)" onclick="reviewPaging(${reBoardPaging.nextBlockPage})">Next</a>
						               </c:if>
						          </c:if>     
			                </div>
			           </div>
			           	<br>
			        	<button style="margin-left: 770px;" id="reviewWriteBtn" name="reviewWriteBtn" type="button" onclick="location.href='/reboard/insert'" class="btn btn-primary">후기 작성하기</button>
			        	<br>

			            <!-- 페이징 -->
			            
			            <br>
			        	<br>
			        	<h4 style="margin-left:47.5%;">댓글내역</h4>
			        	<br>
			        	<div class="row justify-content-center">
			            	<table class="table table-ws w-75 p-3">
			            	
			                	<thead class="mb-5">
			                    	<tr>
			                        	<th scope="col" class="text-center" style="width:7%"></th>
			                            <th scope="col" class="text-center" style="width:10%">번호</th>
			                            <th scope="col" class="text-center" style="width:15%">게시글 제목</th>
			                            <th scope="col" class="text-center" style="width:20%">작성일자</th>
			                            <th scope="col" class="text-center" style="width:10%"></th>
			                        </tr>
			                    </thead>
								<tbody>
				        		<c:choose>
									<c:when test="${!empty reBoardReplyList}">
										<c:forEach var="reBoardReplyList" items="${reBoardReplyList}" varStatus="status">	
	
				                	<tr class="justify-content-center">
				                	<c:if test="${reBoardReplyList.status eq 'N'.charAt(0)}">
				                		<td></td>
				                        <td class="text-center">${reBoardReplyList.replySeq}</td>
				                        <td class="text-center"><a style="cursor:pointer" onclick="fn_view('${reBoardReplyList.reBoardSeq}')">${reBoardReplyList.reBoardTitle}</a></td>
				                        <td class="text-center">${reBoardReplyList.regDate}</td>
				                        <td class="text-center">
				                        	<button id="replyDeleteBtn" name="replyDeleteBtn" type="button" onclick="replyDelete(${reBoardReplyList.replySeq})" class="btn btn-primary">삭제</button>
				                        </td>
				                	</c:if>
				                	
				                	</tr>
										</c:forEach>
			                      	</c:when>
			                      	<c:otherwise>
					                	<tfoot>
					                    	<tr>
					                        	<td colspan="5">댓글 작성 내역이 없습니다.</td>
					                        </tr>
					                    </tfoot>
			                    	</c:otherwise>
			                   	</c:choose>
								</tbody>
			            	</table>
			            </div>
			       
			
			            <!-- 페이징 -->
						<div class="text-center py-4">
			                <div class="custom-pagination" style="margin-left: 450px;">
								<c:if test="${!empty reBoardReplyPaging}">
									<c:if test="${reBoardReplyPaging.prevBlockPage gt 0}">     
										<a class="prev" href="javascript:void(0)" onclick="replyPaging(${reBoardReplyPaging.prevBlockPage})">Previous</a>  
									</c:if>   
										<c:forEach var="i" begin="${reBoardReplyPaging.startPage}" end="${reBoardReplyPaging.endPage}">
								<c:choose>
									<c:when test="${i ne curPage2}">
										<a href="javascript:void(0)" onclick="replyPaging(${i})">${i}</a>
						        	</c:when>
						        	<c:otherwise>
						        		<a class="active"href="javascript:void(0)">${i}</a>
						        	</c:otherwise>
						  			</c:choose>
						  		</c:forEach>
									<c:if test="${reBoardReplyPaging.nextBlockPage gt 0}">
						                   <a class="next" href="javascript:void(0)" onclick="replyPaging(${reBoardReplyPaging.nextBlockPage})">Next</a>
						               </c:if>
						          </c:if>     
			                </div>
			           </div>
			           	<br>
			        	<br>
			        	<br>
				</main>
			</div>
		</div>
	</div>
		<!-- .container -->
		<footer id="colophon" class="site-footer">
			<div class="container">
				<div class="site-info">
					<h1	style="font-family: 'Herr Von Muellerhoff'; color: #ccc; font-weight: 300; text-align: center; margin-bottom: 0; margin-top: 0; line-height: 1.4; font-size: 46px;">Monami</h1> Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a>
				</div>
			</div>
		</footer>
		<a href="#top" class="smoothup" title="Back to top"><span class="genericon genericon-collapse"></span></a>
	</div>
	
	<form id="userReviewForm" name="userReviewForm" method="POST">
	   	<input type="hidden" name="curPage1" value="${curPage}">
	   	<input type="hidden" name="curPage2" value="1">
   	</form>
   	
   	<form id="userReplyForm" name="userReplyForm" method="POST">
	   	<input type="hidden" name="curPage1" value="1">
	   	<input type="hidden" name="curPage2" value="${curPage}">
   	</form>
   	
   	<form id="reBoardForm" name="reBoardForm" method="POST">
   		<input type="hidden" name="reBoardSeq" id="reBoardSeq" value="">
   	</form>
</body>

<script type="text/javascript">
<c:if test="${empty stUserCookie}">
	location.href="/";
</c:if>

$(document).ready(function()
{

});		

function reViewListDelete(seq)
{
	var Seq = seq;
	
	if(confirm("작성한 후기를 삭제하시겠어요?") == true)
	{
		$.ajax
		({
			type : "POST",
			url : "/manager/reviewDeleteProc",
			async : "true",
			dataType : "JSON",
			//contentType : "application/json; charset-utf-8",
			data :
			{
				reBoardSeq : Seq
			},
			success : function(response)
			{
				if(!icia.common.isEmpty(response))
				{
					icia.common.log(response);
					var code = icia.common.objectValue(response, "code", -500);
					
					if(code == 200)
					{
						alert("삭제가 완료되었습니다.");
						location.href = location.href;
						return;
					}
					else
					{
						alert("오류가 발생했습니다. 다시 시도해주세요.");
						return;		
					}
				}
			},
			error : function(xhr, status, error)
			{
				alert("오류가 발생했습니다. 다시 시도해주세요.");
				return;
			}
		});	
	}
}


function replyDelete(seq)
{
	var Seq = seq;
	
	if(confirm("작성한 댓글을 삭제하시겠어요?") == true)
	{
		$.ajax
		({
			type : "POST",
			url : "/manager/replyDeleteProc",
			async : "true",
			dataType : "JSON",
			//contentType : "application/json; charset-utf-8",
			data : 
			{
				replySeq : Seq	
			},
			success : function(response)
			{
				if(!icia.common.isEmpty(response))
				{
					icia.common.log(response);
					var code = icia.common.objectValue(response, "code", -500);
					
					if(code == 200)
					{
						alert("삭제가 완료되었습니다.");
						location.href = location.href;
						return;
					}
					else
					{
						alert("오류가 발생했습니다. 다시 시도해주세요.");
						return;		
					}
				}
			},
			error : function(xhr, status, error)
			{
				alert("오류가 발생했습니다. 다시 시도해주세요.");
				return;		
			}
		});
	}
}
	



function reviewPaging(curPage)
{
	document.userReviewForm.curPage1.value = curPage;
	document.userReviewForm.curPage2.value = 1;
	document.userReviewForm.action = "/user/mypage/reviewlist";
	document.userReviewForm.submit();
}

function replyPaging(curPage)
{
	document.userReplyForm.curPage1.value = 1;
	document.userReplyForm.curPage2.value = curPage;
	document.userReplyForm.action = "/user/mypage/reviewlist";
	document.userReplyForm.submit();
}

function fn_view(reBoardSeq)
{
	document.reBoardForm.reBoardSeq.value = reBoardSeq;
	document.reBoardForm.action = "/reboard/view";
	document.reBoardForm.submit();
}
</script>
</html>
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
					<h3 style="margin-left:39.5%;">MyPage Qna List</h3>					
			        	<br>
			        	<br>
			        	<br>
			        	<div class="row justify-content-center">
			            	<table class="table table-ws w-75 p-3">
			            	
			                	<thead class="mb-5">
			                    	<tr>
			                        	<th scope="col" class="text-center" style="width:5%"></th>
			                            <th scope="col" class="text-center" style="width:15%">글 제목</th>
			                            <th scope="col" class="text-center" style="width:25%">작성일자</th>
			                            <th scope="col" class="text-center" style="width:10%">상태</th>
			                            <th scope="col" class="text-center" style="width:10%"></th>
			                        </tr>
			                    </thead>
								<tbody>
				        		<c:choose>
									<c:when test="${!empty qnaBoardList}">
										<c:forEach var="qnaBoardList" items="${qnaBoardList}" varStatus="status">	
	
				                	<tr class="justify-content-center">
				                		<td></td>
				                        <td class="text-center"><a style="cursor:pointer" onclick="location.href='/qna/qnaView?qnaboardSeq=${qnaBoardList.qnaBoardSeq}'">${qnaBoardList.qnaBoardTitle}</a></td>
				                        <td class="text-center">${qnaBoardList.regDate}</td>
				                        <td class="text-center">
				                        	<c:if test="${qnaBoardList.replyFlag eq 'Y'}">
				                        		답변완료
				                        	</c:if>
				                        	<c:if test="${qnaBoardList.replyFlag eq 'N'}">
				                        		답변대기
				                        	</c:if>
				                        </td>
				                        <td class="text-center">
				                        	<button id="qnaDeleteBtn" name="qnaDeleteBtn" type="button" onclick="qnaListDelete(${qnaBoardList.qnaBoardSeq})" class="btn btn-primary">삭제</button>
				                        </td>
				                	</tr>
										</c:forEach>
			                      	</c:when>
			                      	<c:otherwise>
					                	<tfoot>
					                    	<tr>
					                        	<td colspan="5">문의 내역이 없습니다.</td>
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
								<c:if test="${!empty paging}">
									<c:if test="${paging.prevBlockPage gt 0}">     
										<a class="prev" href="javascript:void(0)" onclick="approvePaging(${paging.prevBlockPage})">Previous</a>  
									</c:if>   
										<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
								<c:choose>
									<c:when test="${i ne curPage}">
										<a href="javascript:void(0)" onclick="approvePaging(${i})">${i}</a>
						        	</c:when>
						        	<c:otherwise>
						        		<a class="active"href="javascript:void(0)">${i}</a>
						        	</c:otherwise>
						  			</c:choose>
						  		</c:forEach>
									<c:if test="${paging.nextBlockPage gt 0}">
						                   <a class="next" href="javascript:void(0)" onclick="approvePaging(${paging.nextBlockPage})">Next</a>
						               </c:if>
						          </c:if>     
			                </div>
			           </div>
			           	<br>
			        	<br>
			        	<br>
			        	<br>
			        	<br>
			        	<br>
			        	<br>
			        	<br>
			        	<br>
			            <!-- 페이징 -->
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
	
	<form id="userQnaBoardListForm" name="userQnaBoardListForm" method="POST">
	   	<input type="hidden" name="curPage" value="${curPage}">
   	</form>
</body>

<script type="text/javascript">
<c:if test="${empty stUserCookie}">
	location.href="/";
</c:if>

function qnaListDelete(seq)
{
	if(confirm("글을 삭제 하시겠어요?") == true)
	{
		var Seq = seq;
		
		$.ajax
		({
			type:"POST",
			url:"/manager/qnaBoardContentDelete",
			data:
			{
				qnaBoardSeq:Seq
			},
			datatype:"JSON",
			beforeSend:function(xhr)
			{
				xhr.setRequestHeader("AJAX", "true");	
			},
			success:function(response)
			{
				if(!icia.common.isEmpty(response))
				{
					icia.common.log(response);
					var code = icia.common.objectValue(response, "code", -500);
					
					if(code == 200)
					{
						alert("글 삭제가 완료되었습니다.");
						location.href = "/user/mypage/qnalist";	
					}
					else
					{
						alert("에러가 발생했습니다. 다시 시도해주세요.");
						return;
					}	
				}
				else
				{
					alert("에러가 발생했습니다. 다시 시도해주세요.");
					return;
				}	
			},
			error:function(xhr, status, error)
			{
				icia.common.error(error);
			}
		});
	}
}

function approvePaging(curPage)
{
	document.userQnaBoardListForm.curPage.value = curPage;
	document.userQnaBoardListForm.action = "/user/mypage/qnalist";
	document.userQnaBoardListForm.submit();
}
</script>
</html>
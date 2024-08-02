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
					<h3 style="margin-left:39.5%;">MyPage PaymentList</h3>					
			        	
			        	<br>
			        	<br>
			        	<h4 style="margin-left:47.5%;">결제내역</h4>
			        	<br>		
			        	<div class="row justify-content-center">
			            	<table class="table table-ws w-75 p-3">
			            	
			                	<thead class="mb-5">
			                    	<tr>
			                        	<th scope="col" class="text-center" style="width:5%"></th>
			                            <th scope="col" class="text-center" style="width:15%">상품명</th>
			                            <th scope="col" class="text-center" style="width:10%">가격</th>
			                            <th scope="col" class="text-center" style="width:25%">결제일자</th>
			                            <th scope="col" class="text-center" style="width:10%">상태</th>
			                            <th scope="col" class="text-center" style="width:10%"></th>
			                        </tr>
			                    </thead>
								<tbody>
				        		<c:choose>
									<c:when test="${!empty stPaymentApproveList}">
										<c:forEach var="stPaymentApproveList" items="${stPaymentApproveList}" varStatus="status">	
	
				                	<tr class="justify-content-center">
				                		<td></td>
				                        <td class="text-center"><a style="cursor:pointer" onclick="location.href='/shop/single?itemSeq=${stPaymentApproveList.itemCode}'">${stPaymentApproveList.itemName}</a></td>
				                        <td class="text-center">${stPaymentApproveList.totalAmount}</td>
				                        <td class="text-center">${stPaymentApproveList.approvedAt}</td>
				                        <td class="text-center">
				                        	<c:if test="${stPaymentApproveList.status eq 'N'.charAt(0)}">
				                        		결제완료
				                        	</c:if>
				                        	<c:if test="${stPaymentApproveList.status eq 'C'.charAt(0)}">
												결제 취소
				                        	</c:if>
				                        </td>
				                        <td class="text-center">
				                        	<c:if test="${stPaymentApproveList.status eq 'N'.charAt(0)}">
												<button id="insert" name="insert" type="button" onclick="fn_reviewWrite('${stPaymentApproveList.itemCode}')" style="color:white; background-color:black; border:none;width:80px">후기작성</button>
				                        		<button id="PaymentCancelBtn" name="PaymentCancelBtn" type="button" onclick="PaymentCancel('${stPaymentApproveList.partnerOrderId}')" class="btn btn-primary">결제취소</button>
				                        	</c:if>
				                        	<c:if test="${stPaymentApproveList.status eq 'C'.charAt(0)}">
												
				                        	</c:if>
				                        </td>
				                	</tr>
										</c:forEach>
			                      	</c:when>
			                      	<c:otherwise>
					                	<tfoot>
					                    	<tr>
					                        	<td colspan="5">구매 내역이 없습니다.</td>
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
								<c:if test="${!empty stPaymentApprovePaging}">
									<c:if test="${stPaymentApprovePaging.prevBlockPage gt 0}">     
										<a class="prev" href="javascript:void(0)" onclick="approvePaging(${stPaymentApprovePaging.prevBlockPage})">Previous</a>  
									</c:if>   
										<c:forEach var="i" begin="${stPaymentApprovePaging.startPage}" end="${stPaymentApprovePaging.endPage}">
								<c:choose>
									<c:when test="${i ne curPage1}">
										<a href="javascript:void(0)" onclick="approvePaging(${i})">${i}</a>
						        	</c:when>
						        	<c:otherwise>
						        		<a class="active"href="javascript:void(0)">${i}</a>
						        	</c:otherwise>
						  			</c:choose>
						  		</c:forEach>
									<c:if test="${stPaymentApprovePaging.nextBlockPage gt 0}">
						                   <a class="next" href="javascript:void(0)" onclick="approvePaging(${stPaymentApprovePaging.nextBlockPage})">Next</a>
						               </c:if>
						          </c:if>     
			                </div>
			           </div>
			            <!-- 페이징 -->
			            <br>
						<br>
	                    <br>
			        	<br>
			        	<h4 style="margin-left:47.5%;">취소내역</h4>
			        	<br>
			            <div class="row justify-content-center">
			            	<table class="table table-ws w-75 p-3">
			                	<thead class="mb-5">
			                    	<tr>
			                        	<th scope="col" class="text-center" style="width:5%"></th>
			                            <th scope="col" class="text-center" style="width:15%">상품명</th>
			                            <th scope="col" class="text-center" style="width:10%">가격</th>
			                            <th scope="col" class="text-center" style="width:25%">결제일자</th>
			                            <th scope="col" class="text-center" style="width:10%"></th>
			                            <th scope="col" class="text-center" style="width:10%"></th>
			                        </tr>
			                    </thead>
								<tbody>
				        		<c:choose>
									<c:when test="${!empty stPaymentCancelList}">
										<c:forEach var="stPaymentCancelList" items="${stPaymentCancelList}" varStatus="status">	
	
				                	<tr class="justify-content-center">
				                		<td></td>
				                		<td class="text-center"><a style="cursor:pointer" onclick="location.href='/shop/single?itemSeq=${stPaymentCancelList.itemCode}'">${stPaymentCancelList.itemName}</a></td>
				                        <td class="text-center">${stPaymentCancelList.cancelTotalAmount}</td>
				                        <td class="text-center">${stPaymentCancelList.canceledAt}</td>
				                   </tr>
										</c:forEach>
			                      	</c:when>
			                      	<c:otherwise>
					                	<tfoot>
					                    	<tr>
					                        	<td colspan="5">취소 내역이 없습니다.</td>
					                        </tr>
					                    </tfoot>
			                    	</c:otherwise>
			                   	</c:choose>
								</tbody>
			            	</table>
			            </div>
			
			            <!-- 페이징 -->
						<div class="content-area column full">
			            	<div class="content-area column full" style="margin-left: 450px;">
								<c:if test="${!empty stPaymentCancelPaging}">
									<c:if test="${stPaymentCancelPaging.prevBlockPage gt 0}">     
										<a class="prev" href="javascript:void(0)" onclick="cancelPaging(${stPaymentCancelPaging.prevBlockPage})">Previous</a>  
									</c:if>   
										<c:forEach var="i" begin="${stPaymentCancelPaging.startPage}" end="${stPaymentCancelPaging.endPage}">
								<c:choose>
									<c:when test="${i ne curPage2}">
										<a href="javascript:void(0)" onclick="cancelPaging(${i})">${i}</a>
						        	</c:when>
						        	<c:otherwise>
						        		<a class="active"href="javascript:void(0)">${i}</a>
						        	</c:otherwise>
						  			</c:choose>
						  		</c:forEach>
									<c:if test="${stPaymentCancelPaging.nextBlockPage gt 0}">
						                   <a class="next" href="javascript:void(0)" onclick="cancelPaging(${stPaymentCancelPaging.nextBlockPage})">Next</a>
						        	</c:if>
						        </c:if>     
			            	</div>
			           	</div>
			           
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
	
	<form id="userPaymentApproveForm" name="userPaymentApproveForm" method="POST">
	   	<input type="hidden" name="curPage1" value="${curPage}">
	   	<input type="hidden" name="curPage2" value="1">
   	</form>
   	
	<form id="userPaymentCancelForm" name="userPaymentCancelForm" method="POST">
	   	<input type="hidden" name="curPage1" value="1">
	   	<input type="hidden" name="curPage2" value="${curPage}">
   	</form>
   	
</body>

<script type="text/javascript">
<c:if test="${empty stUserCookie}">
	location.href="/";
</c:if>

function fn_reviewWrite(itemCode)
{
	document.reForm.itemCode2.value = itemCode;
	document.reForm.action = "/reboard/insert";
	document.reForm.submit();
}

function PaymentCancel(orderId)
{
	if(confirm("결제를 취소하시겠어요?") == true)
	{
		var OrderId = orderId;
		
		$.ajax
		({
			type:"POST",
			url:"/user/mypage/paymentCancelProc",
			data:
			{
				partnerOrderId:OrderId
			},
			datatype:"JSON",
			befoerSend:function(xhr)
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
						alert("결제 취소가 완료되었습니다.");
						location.href = "/user/mypage/paymentlist";	
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
	document.userPaymentApproveForm.curPage1.value = curPage;
	document.userPaymentApproveForm.curPage2.value = 1;
	document.userPaymentApproveForm.action = "/user/mypage/paymentlist";
	document.userPaymentApproveForm.submit();
}

function cancelPaging(curPage)
{
	document.userPaymentCancelForm.curPage1.value = 1;
	document.userPaymentCancelForm.curPage2.value = curPage;
	document.userPaymentCancelForm.action = "/user/mypage/paymentlist";
	document.userPaymentCancelForm.submit();
}

</script>
</html>
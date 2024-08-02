<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/manager/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/manager/include/navigation.jsp" %>
<div id="wrapper">
	<!-- MAIN -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="container-fluid">
				<h3 class="page-title">사용자 관리</h3>
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="input-group">
							<input type="text" id="searchValue" name="searchValue" value="${searchValue}" class="form-control" placeholder="검색">
							<span class="input-group-btn"><button type="button" id="searchBtn" name="searchBtn" class="btn btn-primary">검색</button></span>
						</div>
					
						<div class="panel-heading"></div>
							<div class="panel-body">
								<table class="table table-striped">
									<c:choose>
										<c:when test="${!empty stUserList}">
									<thead>
										<tr>
											<th style="width:8%">아이디</th>
											<th style="width:15%">이메일</th>
											<th style="width:8%">전화번호</th>
											<th style="width:25%">주소</th>
											<th style="width:6%">포인트</th>
											<th style="width:10%">상태</th>
											<th style="width:15%">가입일자</th>
											<th style="width:10%"></th>
										</tr>
									</thead>
									
									<tbody>

											<c:forEach var="stUserList" items="${stUserList}" varStatus="status">
												<tr>
													<td>${stUserList.userId}</td>
													<td>${stUserList.userEmail}</td>
													<td>${stUserList.userTel}</td>
													<td>${stUserList.userAddress}</td>
													<td>${stUserList.userPoint}</td>
													<td>${stUserList.status}</td>
													<td>${stUserList.regDate}</td>
													<td>
														<button class = "btn btn-primary btn-toastr" onclick="location.href='/manager/userManagementDetail?userId=${stUserList.userId}'">수정</button>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td>리스트가 없습니다.</td>
											</tr>
										</c:otherwise>
									</c:choose>
									</tbody>
								</table>
								<!-- 페이징 -->
            					<div class="text-center py-4">
               						<div class="custom-pagination">
									<c:if test="${!empty paging}">
										<c:if test="${paging.prevBlockPage gt 0}">     
											<a class="prev" href="javascript:void(0)" onclick="stUserListPaging(${paging.prevBlockPage})">Previous</a>  
										</c:if>  
										<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
											<c:choose>
												<c:when test="${i ne curPage}">
													<a href="javascript:void(0)" onclick="stUserListPaging(${i})">${i}</a>
	        									</c:when>
	        									<c:otherwise>
									        		<a class="active"href="javascript:void(0)">${i}</a>
									        	</c:otherwise>
   											</c:choose>
   										</c:forEach>
										<c:if test="${paging.nextBlockPage gt 0}">
                    						<a class="next" href="javascript:void(0)" onclick="stUserListPaging(${paging.nextBlockPage})">Next</a>
                						</c:if>
           							</c:if>     
					                </div>
					           </div>
					           <!-- 페이징 -->
							</div>
					</div>
					<!-- END TABLE STRIPED -->
			</div>
		</div>
		<!-- END MAIN CONTENT -->
	</div>
<!-- END MAIN -->
</div>
</body>
    <form id="userManagementForm" name="userManagementForm" method="POST">
	   	<input type="hidden" name="searchValue" value="${searchValue}">
	   	<input type="hidden" name="curPage" value="${curPage}">
   	</form>

<script type="text/javascript">
<c:if test="${empty stManagerCookie}">
	location.href="/";
</c:if>

$(document).ready(function()
{
   	$("#searchBtn").on("click", function() 
   	{

   		if($.trim($("#searchValue").val()) == "")
   	    {
   	    	alert("조회 값을 입력하세요.");
   	    	$("#searchValue").val("");
   	    	$("#searchValue").focus();
   	    	return;
   	    }
		document.userManagementForm.searchValue.value = $("#searchValue").val();
		document.userManagementForm.curPage.value = "1";
		
		document.userManagementForm.action = "/manager/usermanagement";	
		document.userManagementForm.submit();
   	});
});


function stUserListPaging(curPage)
{
	document.userManagementForm.curPage.value = curPage;
	document.userManagementForm.action = "/manager/usermanagement";	
	document.userManagementForm.submit();
}
</script>

</html>
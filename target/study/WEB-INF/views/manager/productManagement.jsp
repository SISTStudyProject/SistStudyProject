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
				<h3 class="page-title">상품 관리</h3>
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="input-group">
							<div class="panel">
							<select id="searchType" name="searchType" class="form-control">
						    	<option value="">선택항목</option>
						    	<option value="1" <c:if test='${searchType eq "1"}'> selected </c:if>>상품명</option>
						        <option value="2" <c:if test='${searchType eq "2"}'> selected </c:if>>카테고리</option>
						    	<option value="3" <c:if test='${searchType eq "3"}'> selected </c:if>>상품번호</option>
						    </select>
							</div>

							<input type="text" id="searchValue" name="searchValue" value="${searchValue}" class="form-control" placeholder="검색">
							<button type="button" id="searchBtn" name="searchBtn" class="btn btn-primary">검색</button>
						</div>
					
						<div class="panel-heading"></div>
							<div class="panel-body">
								<table class="table table-striped">
									<c:choose>
										<c:when test="${!empty itemDataList}">
									<thead>
										<tr>
											<th style="width:8%">번호</th>
											<th style="width:8%">상품번호</th>
											<th style="width:15%">상품명</th>
											<th style="width:15%">카테고리</th>
											<th style="width:8%">가격</th>
											<th style="width:5%">재고</th>
											<th style="width:15%">등록일</th>
											<th style="width:10%"></th>
										</tr>
									</thead>
									
									<tbody>

											<c:forEach var="itemDataList" items="${itemDataList}" varStatus="status">
												<tr>
													<td>${itemDataList.itemSeq}</td>
													<td>${itemDataList.itemCode}</td>
													<td>${itemDataList.itemName}</td>
													<td>${itemDataList.itemCate}</td>
													<td>${itemDataList.itemPrice}</td>
													<td>${itemDataList.stock}</td>
													<td>${itemDataList.regDate}</td>
													<td>
														<button class = "btn btn-primary btn-toastr" onclick="location.href='/manager/productmanagementmodify?itemSeq=${itemDataList.itemSeq}'">수정</button>
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
											<a class="prev" href="javascript:void(0)" onclick="itemDataListPaging(${paging.prevBlockPage})">Previous</a>  
										</c:if>  
										<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
											<c:choose>
												<c:when test="${i ne curPage}">
													<a href="javascript:void(0)" onclick="itemDataListPaging(${i})">${i}</a>
	        									</c:when>
	        									<c:otherwise>
									        		<a class="active"href="javascript:void(0)">${i}</a>
									        	</c:otherwise>
   											</c:choose>
   										</c:forEach>
										<c:if test="${paging.nextBlockPage gt 0}">
                    						<a class="next" href="javascript:void(0)" onclick="itemDataListPaging(${paging.nextBlockPage})">Next</a>
                						</c:if>
           							</c:if>     
					                </div>
					           </div>
					           
					          	<div>
									<button onclick="location.href='/manager/productmanagementwrite'" class = "btn btn-primary btn-toastr">상품 등록</button>
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
    <form id="productManagementForm" name="productManagementForm" method="POST">
	   	<input type="hidden" id="itemSeq" name="itemSeq" value="">
	   	<input type="hidden" name="searchType" value="${searchType}">
	   	<input type="hidden" name="searchValue" value="${searchValue}">
	   	<input type="hidden" name="curPage" value="${curPage}">
   	</form>

<script type="text/javascript">
<c:if test="${empty stManagerCookie}">
	location.href="/";
</c:if>

$(document).ready(function()
{
	$("#searchType").change(function()
	{
		$("#searchValue").val("");
	});
	
   	$("#searchBtn").on("click", function() 
   	{
   		if($("#searchType").val() == "")
   		{
   			alert("조회 항목을 선택하세요.");
   			return;
   		}
   		
   		if($("#searchType").val() != "")
    	{
   	   		if($.trim($("#searchValue").val()) == "")
   	   	    {
   	   	    	alert("조회 값을 입력하세요.");
   	   	    	$("#searchValue").val("");
   	   	    	$("#searchValue").focus();
   	   	    	return;
   	   	    }
    	}
   		
		document.productManagementForm.itemSeq.value = "";
		document.productManagementForm.searchType.value = $("#searchType").val();
		document.productManagementForm.searchValue.value = $("#searchValue").val();
		document.productManagementForm.curPage.value = "1";
		
		document.productManagementForm.action = "/manager/productmanagement";	
		document.productManagementForm.submit();
   	});
});


function itemDataListPaging(curPage)
{
	document.productManagementForm.itemSeq.value = "";
	document.productManagementForm.curPage.value = curPage;
	document.productManagementForm.action = "/manager/productmanagement";	
	document.productManagementForm.submit();
}

</script>

</html>
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
				<h3 class="page-title">문의 관리</h3>
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="input-group">
							<div class="panel">
								<select id="searchType" name="searchType" class="form-control">
							    	<option value="">선택항목</option>
							    	<option value="1" <c:if test='${searchType eq "1"}'> selected </c:if>>작성자</option>
							        <option value="2" <c:if test='${searchType eq "2"}'> selected </c:if>>제목</option>
							    	<option value="3" <c:if test='${searchType eq "3"}'> selected </c:if>>내용</option>
							    </select>
							</div>
							<input type="text" id="searchValue" name="searchValue" value="${searchValue}" class="form-control" placeholder="검색">
							<button type="button" id="searchBtn" name="searchBtn" class="btn btn-primary">검색</button>
						</div>
					
						<div class="panel-heading"></div>
							<div class="panel-body">
								<table class="table table-striped">
									<c:choose>
										<c:when test="${!empty qnaBoardList}">
									<thead>
										<tr>
											<th style="width:8%">번호</th>
											<th style="width:15%">작성자</th>
											<th style="width:20%">제목</th>
											<th style="width:15%">내용</th>
											<th style="width:15%">작성일자</th>
											<th style="width:10%">비밀글 여부</th>
										</tr>
									</thead>
									
									<tbody>
											<c:forEach var="qnaBoardList" items="${qnaBoardList}" varStatus="status">
												<tr>
													<td>${qnaBoardList.qnaBoardSeq} </td>
													<td>${qnaBoardList.userId}</td>
													<td>${qnaBoardList.qnaBoardTitle}</td>
													<td><button type="button" onclick="location.href='/manager/qnaboardContent?qnaBoardSeq=${qnaBoardList.qnaBoardSeq}'" class="btn btn-primary">내용보기</button>
													<td>${qnaBoardList.regDate}</td>
													<td>${qnaBoardList.secretFlag}</td>	
												</tr>

											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td style="width:100%" >리스트가 없습니다.</td>
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
											<a class="prev" href="javascript:void(0)" onclick="qnaBoardListPaging(${paging.prevBlockPage})">Previous</a>  
										</c:if>  
										<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
											<c:choose>
												<c:when test="${i ne curPage}">
													<a href="javascript:void(0)" onclick="qnaBoardListPaging(${i})">${i}</a>
	        									</c:when>
	        									<c:otherwise>
									        		<a class="active"href="javascript:void(0)">${i}</a>
									        	</c:otherwise>
   											</c:choose>
   										</c:forEach>
										<c:if test="${paging.nextBlockPage gt 0}">
                    						<a class="next" href="javascript:void(0)" onclick="qnaBoardListPaging(${paging.nextBlockPage})">Next</a>
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
    <form id="qnaboardManagementForm" name="qnaboardManagementForm" method="POST">
	   	<input type="hidden" id="qnaBoardSeq" name="qnaBoardSeq" value="">
	   	<input type="hidden" name="searchType" value="${searchType}">
	   	<input type="hidden" name="searchValue" value="${searchValue}">
	   	<input type="hidden" name="curPage" value="${curPage}">
   	</form>
<script>
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
   		
   		document.qnaboardManagementForm.qnaBoardSeq.value = "";
   		document.qnaboardManagementForm.searchType.value = $("#searchType").val();
   		document.qnaboardManagementForm.searchValue.value = $("#searchValue").val();
   		document.qnaboardManagementForm.curPage.value = "1";
   		
   		document.qnaboardManagementForm.action = "/manager/qnamanagement";	
   		document.qnaboardManagementForm.submit();
   	});
});


function qnaBoardListPaging(curPage)
{
	document.qnaboardManagementForm.qnaBoardSeq.value = "";
	document.qnaboardManagementForm.curPage.value = curPage;
	document.qnaboardManagementForm.action = "/manager/qnamanagement";	
	document.qnaboardManagementForm.submit();
}
</script>

</html>
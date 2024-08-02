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
				<div class="row">
					<div class="col-md-6">
						<!-- TABLE STRIPED -->
						<div class="panel">
							<div class="panel-heading">
								<h3 class="panel-title">사용자 관리</h3>
							</div>
							<div class="panel-body">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>아이디</th>
											<th>이메일</th>
											<th>포인트</th>
											<th>가입일자</th>
										</tr>
									</thead>
									<tbody>
									<c:choose>
										<c:when test="${!empty stUserList}">
											<c:forEach var="stUserList" items="${stUserList}" varStatus="status">
												<tr>
													<td>${stUserList.userId}</td>
													<td>${stUserList.userEmail}</td>
													<td>${stUserList.userPoint}</td>
													<td>${stUserList.regDate}</td>
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
								<button type="button" onclick = "location.href='/manager/usermanagement'" class="btn btn-primary btn-toastr" data-context="info" data-position="top-right">더 보기</button>
							</div>
						</div>
						<!-- END TABLE STRIPED -->
					</div>
					<div class="col-md-6">
						<!-- TABLE STRIPED -->
						<div class="panel">
							<div class="panel-heading">
								<h3 class="panel-title">상품 관리</h3>
							</div>
							<div class="panel-body">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>번호</th>
											<th>상품명</th>
											<th>가격</th>
											<th>등록일자</th>
										</tr>
									</thead>
									<tbody>
									<c:choose>
										<c:when test="${!empty itemDataList}">
											<c:forEach var="itemDataList" items="${itemDataList}" varStatus="status">
												<tr>
													<td>${itemDataList.itemSeq}</td>
													<td>${itemDataList.itemName}</td>
													<td>${itemDataList.itemPrice}</td>
													<td>${itemDataList.regDate}</td>
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
								<button type="button"  onclick = "location.href='/manager/productmanagement'" class="btn btn-primary btn-toastr" data-context="info" data-position="top-right">더 보기</button>
							</div>
						</div>
						<!-- END TABLE STRIPED -->
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<!-- TABLE STRIPED -->
						<div class="panel">
							<div class="panel-heading">
								<h3 class="panel-title">후기 관리</h3>
							</div>
							<div class="panel-body">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>번호</th>
											<th>작성자</th>
											<th>제목</th>
											<th>등록일자</th>
										</tr>
									</thead>
									<tbody>
									<c:choose>
										<c:when test="${!empty reBoardList}">
											<c:forEach var="reBoardList" items="${reBoardList}" varStatus="status">
												<tr>
													<td>${reBoardList.reBoardSeq}</td>
													<td>${reBoardList.userId}</td>
													<td>${reBoardList.reBoardTitle}</td>
													<td>${reBoardList.regDate}</td>
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
								<button type="button"  onclick = "location.href='/manager/reviewmanagement'" class="btn btn-primary btn-toastr" data-context="info" data-position="top-right">더 보기</button>
							</div>
						</div>
						<!-- END TABLE STRIPED -->
					</div>
					<div class="col-md-6">
						<!-- TABLE STRIPED -->
						<div class="panel">
							<div class="panel-heading">
								<h3 class="panel-title">Qna 관리</h3>
							</div>
							<div class="panel-body">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>번호</th>
											<th>작성자</th>
											<th>등록일자</th>
											<th>답변여부</th>
										</tr>
									</thead>		
									<tbody>
									<c:choose>
										<c:when test="${!empty qnaBoardList}">
											<c:forEach var="qnaBoardList" items="${qnaBoardList}" varStatus="status">
												<tr>
													
													<td>${qnaBoardList.qnaBoardSeq}</td>
													<td>${qnaBoardList.userId}</td>
													<td>${qnaBoardList.regDate}</td>
													<td>${qnaBoardList.replyFlag}</td>
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
								<button type="button" onclick = "location.href='/manager/qnamanagement'"  class="btn btn-primary btn-toastr" data-context="info" data-position="top-right">더 보기</button>
							</div>
						</div>
						<!-- END TABLE STRIPED -->
					</div>
				</div>
			</div>
		</div>
		<!-- END MAIN CONTENT -->
	</div>
<!-- END MAIN -->
</div>
</body>

<script type="text/javascript">
<c:if test="${empty stManagerCookie}">
	location.href="/";
</c:if>
</script>

</html>
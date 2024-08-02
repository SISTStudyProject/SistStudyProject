<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ include file="/WEB-INF/views/include/titleTaglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>문의게시판</title>
	<link rel='stylesheet' href='/resources/css/woocommerce-layout.css' type='text/css' media='all'/>
	<link rel='stylesheet' href='/resources/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
	<link rel='stylesheet' href='/resources/css/woocommerce.css' type='text/css' media='all'/>
	<link rel='stylesheet' href='/resources/css/font-awesome.min.css' type='text/css' media='all'/>
	<link rel='stylesheet' href='/resources/css/style.css' type='text/css' media='all'/>
	<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
	<link rel='stylesheet' href='/resources/css/easy-responsive-shortcodes.css' type='text/css' media='all'/>
	<style>
		/* 높이값 고정 */
		html,body{height:100%; font-size:13px;}
		#page{height: 100%;}
		.container{height: 100%;}
		.table td, .table th{padding:6px;}
		.entry-header{display: flex;justify-content: space-between;}
		.search-bar{display: flex; gap: 5px;}
		select{height:33px; border: 1px solid #ccc; border-radius: 0;}
		input[type="text"]{width: 200px; height:33px;}
		input[type="submit"]{height: 33px;}
		.table th, .table td{text-align: center;}
		.table td:nth-of-type(2){text-align: left;}
				input[type="button"],
		input[type="text"] {
		border-radius:10px;
		}
		.pagination a:hover, .pagination .current {
		    background-color:#ffd700;
		    color: #fff;
		}
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
	
		function fn_view(qnaboardseq) // 제목 클릭
		{
			document.qnaForm.qnaboardSeq.value = qnaboardseq;
			document.qnaForm.action = "/qna/qnaView";
			document.qnaForm.submit();
		}
	
		function fn_list(value) // 페이지 번호 클릭
		{
			document.qnaForm.curPage.value = value;
			document.qnaForm.action = "/qna/qnaList";
			document.qnaForm.submit();
		}
		
		$(document).ready(function(){
			$("#write").on("click", function(){
				document.qnaForm.action = "/qna/qnaWrite";
				document.qnaForm.submit();
			});
			
			$("#search").on("click", function(){
		        document.qnaForm.searchValue.value = document.getElementById('searchVal').value;
		        document.qnaForm.curPage.value = 1;
				document.qnaForm.action = "/qna/qnaList";
				document.qnaForm.submit();
			});
		});

		
	</script>
</head>
<body>
<div id="page">
	<div class="container">
		<header id="masthead" class="site-header">
		<div class="site-branding">
			<h1 style="text-align:center;">Q & A</h1>
		</div>
		</header>
		<!-- #masthead -->
		<div id="content" class="site-content">
			<div id="primary" class="content-area column full">
				<main id="main" class="site-main" role="main">
				<article id="post-37" class="post-37 page type-page status-publish hentry">
				<header class="entry-header">
					<h1 class="entry-title"></h1>
					<div class="search-bar"> 
						<form>
							<input type="text" name="keyword" id="searchVal" class="inp-search" placeholder="무엇을 도와드릴까요?">
							<input type="button" style="height:35px;" id="search" class="clearfix btn" value="검색">
						</form>
					</div>
				</header>
				<!-- .entry-header -->
				<div class="entry-content">
						<table class="table" style="padding:0px;">
							<colgroup>
								<col style="width: 7%" />
								<col style="" />
								<col style="width: 7%" />
								<col style="width: 20%" />
								<col style="width: 7%" />
							</colgroup>
							<thead>
								<tr>
									<th>No</th>
									<th style="text-align:left;">제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>답변여부</th>
								</tr>
							</thead>
							<tbody>
						<c:if test="${!empty list}" >
							<c:forEach var="qnaboard" items="${list}" varStatus="status" >
								<tr>
									<td>${qnaboard.qnaBoardSeq}</td>
									<td>
									<a href="javascript:void(0)" onclick="fn_view(${qnaboard.qnaBoardSeq})">
									<c:if test="${qnaboard.secretFlag eq 'Y'}" >
									🔑
									</c:if>
									${qnaboard.qnaBoardTitle}
									</a>
									</td>
									<td style="color:gray;">${qnaboard.userId}</td>
									<td style="color:gray;">${qnaboard.regDate}</td>
									<td style="font-size:14px;">
									<c:if test="${qnaboard.replyFlag eq 'Y'}" >
										<div style="color:gray">답변완료</div>
									</c:if>
									<c:if test="${qnaboard.replyFlag eq 'N'}" >
										<div style="color:brown">답변대기</div>
									</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty list}" >
								<tr><th colspan="5">게시물이 존재하지 않습니다.</th></tr>
						</c:if>
							</tbody>
						</table>
				</div>

				<!-- 페이징 -->
				<div style="transform: translate(40%, 60%);" >
				<c:if test="${!empty paging}" >
					<nav class="pagination" style="cursor: pointer">
					<c:if test="${paging.prevBlockPage gt 0}">
					    <a class="next page-numbers" href="javascript:void(0)" onclick="fn_list(${paging.prevBlockPage})"> << Prev </a>
					</c:if>
					<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
					    <c:choose>
					        <c:when test="${i ne curPage}">
					            <span class="page-numbers current" onclick="fn_list(${i})">${i}</span>
					        </c:when>
					        <c:otherwise>
					            <a class="page-numbers" href="javascript:void(0)" style="cursor:default;">${i}</a>
					        </c:otherwise>
					    </c:choose>
					</c:forEach>
					<c:if test="${paging.nextBlockPage gt 0}">
					    <a class="next page-numbers" href="javascript:void(0)" onclick="fn_list(${paging.nextBlockPage})"> Next >> </a>
					</c:if>
					</nav>
				</c:if>
				</div>
				</main>
			</div>
		</div>
		<c:if test="${!empty cookieUserId}" >
		<input type="button" id="write" style="float:right; background-color:#daa520; border:0px; color:white; width:80px; height:30px;" class="clearfix btn" value="글 작성"/>
		</c:if>
	</div>
	
	<a href="#top" class="smoothup" title="Back to top"><span class="genericon genericon-collapse"></span></a>
	
</div>
<!-- #page -->
<script src='/resources/js/jquery.js'></script>
<script src='/resources/js/plugins.js'></script>
<script src='/resources/js/scripts.js'></script>
<script src='/resources/js/accordion.js'></script>
<script src='/resources/js/tabs.js'></script>
<script src='/resources/js/toggle.js'></script>
<script src='/resources/js/masonry.pkgd.min.js'></script>

<form name="qnaForm" id="qnaForm" method="post" >
	<input type="hidden" id="qnaboardSeq" name="qnaboardSeq" value="" />
	<input type="hidden" id="searchValue" name="searchValue" value="${searchValue}" />
	<input type="hidden" id="curPage" name="curPage" value="${curPage}" />
</form>

</body>
</html>
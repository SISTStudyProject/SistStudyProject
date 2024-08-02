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
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<style>

		html {
            border: none;
            padding:3px;
        }
        body {
            height: 100%;
            margin: 0;
            padding: 20px; 
            box-sizing: border-box;
            font-size:13px;
        }
		#page { height: 100%; }
		.container { height: 100%; }
		textarea {
		resize: none;
		}
		.entry-header { display: flex; justify-content: space-between; }
		.search-bar { display: flex; gap: 5px; }
		select { height: 33px; padding: 4px; border: 1px solid #ccc; border-radius: 0; }
		input[type="text"] { width: 200px; height: 33px; padding: 6px; }
		input[type="submit"] { height: 33px; }
		.table th, .table td { text-align: center; }
		.table td:nth-of-type(2) { text-align: left; }
		hr.hr-4, hr.hr-5  { border: 0; border-top: 1px solid gray; }
		button {
		text-align:center;
		}
		* { box-sizing: border-box; }
		input[type="button"],
		input[type="text"] {
		border-radius:10px;
		}
		#subjectH1 {
        cursor: pointer;
        }
        img {
        max-width: 100%; 
        height: 300px;}
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
		function fn_list()
		{
			document.qnaForm.curPage.value = value;
			document.qnaForm.action = "/qna/qnaList";
			document.qnaForm.submit();
		}
	      
		$(document).ready(function(){
			$("#list").on("click", function(){
				document.qnaForm.action = "/qna/qnaList";
				document.qnaForm.submit();
			});
			
			$("#search").on("click", function(){
		        document.qnaForm.searchValue.value = document.getElementById('searchVal').value;
		        document.qnaForm.curPage.value = 1;
				document.qnaForm.action = "/qna/qnaList";
				document.qnaForm.submit();
			});
			
			$("#delete").on("click", function(){
				if(confirm("글을 삭제하시겠습니까?") == true)
				{
					$.ajax({
						type:"POST",
						url:"/qna/qnaDeleteProc",
						data:{
							qnaBoardSeq:$("#qnaboardSeq").val()
						},
						beforeSend:function(xhr)
						{
							xhr.setRequestHeader("AJAX", "true");
						},
						success:function(response)
						{
							if(response == 404)
							{
								alert("입력값이 올바르지 않습니다.");
							}
							else if(response == 0)
							{
								alert("글 삭제가 완료되었습니다.");
								location.href = "/qna/qnaList";
							}
							else if(response == 500)
							{
								alert("글 식제 중 서버 오류가 발생했습니다.");
							}
							else if(response == 505)
							{
								alert("해당 접근이 올바르지 않습니다.");
							}
						},
						error:function(error)
						{
							alert("문의 글 등록 중 알 수 없는 오류가 발생했습니다.");
						}
					});
				}
			});
			
			$("#Mdelete").on("click", function(){
				if(confirm("답변을 삭제하시겠습니까?") == true)
				{
					$.ajax({
						type:"POST",
						url:"/qna/qnaReplyDelete",
						data:{
							qnaBoardSeq:$("#qnaboardSeq").val()
						},
						beforeSend:function(xhr)
						{
							xhr.setRequestHeader("AJAX", "true");
						},
						success:function(response)
						{
							if(response == 404)
							{
								alert("입력값이 올바르지 않습니다.");
							}
							else if(response == 0)
							{
								alert("답변 삭제가 완료되었습니다.");
								location.href = "/qna/qnaList";
							}
							else if(response == 500)
							{
								alert("답변 삭제 중 서버 오류가 발생했습니다.");
							}
							else if(response == 400)
							{
								alert("해당 접근이 올바르지 않습니다.");
							}
						},
						error:function(error)
						{
							alert("문의 글 등록 중 알 수 없는 오류가 발생했습니다.");
						}
					});
				}
			});
			
			$("#subjectH1").on("click", function(){
				location.href = "/qna/qnaList";
			});
			
			$("#reply").on("click", function(){
				
				if(confirm("답변을 등록하시겠습니까?") == true)
				{
					if($.trim($("#comment").val()).length <= 0)
					{
						alert("답글 내용을 입력해주세요.");
						$("#comment").focus();
						return;
					}
					
					$.ajax({
						type:"POST",
						url:"/qna/qnaReplyProc",
						data:{
							comment:$("#comment").val(),
							qnaBoardSeq:$("#qnaboardSeq").val()
						},
						beforeSend:function(xhr)
						{
							xhr.setRequestHeader("AJAX", "true");
						},
						success:function(response)
						{
							if(response == 404)
							{
								alert("입력값이 올바르지 않습니다.");
							}
							else if(response == 0)
							{
								alert("답변 등록이 완료되었습니다.");
								location.href = "/qna/qnaList";
							}
							else if(response == 500)
							{
								alert("답변 등록 중 서버 오류가 발생했습니다.");
							}
							else if(response == 400)
							{
								alert("해당 접근이 올바르지 않습니다.");
							}
						},
						error:function(error)
						{
							alert("문의 글 등록 중 알 수 없는 오류가 발생했습니다.");
						}
					});
				}

			});
		});
	</script>
</head>
<body>
<!-- 모달 창 -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true" style="border-radius:30px;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editModalLabel">답변 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="editForm">
          <div class="form-group">
            <textarea class="form-control" id="editComment" style="border-radius:10px; resize: none;"rows="5"></textarea>
          </div>
          <div style="text-align:right;">
          <button type="button" class="btn btn-primary" style=" background-color:#ffd700; border-radius:10px;" id="saveChanges">저장</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div id="page">
	<div class="container">
		<header id="masthead" class="site-header">
			<div class="site-branding">
				<h1 id="subjectH1" style="text-align:center;">Q & A</h1>
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
									<input type="text" name="keyword" id="searchVal" class="inp-search" placeholder="조회 값을 입력하세요">
									<input type="button" id="search" style="height:35px;" class="clearfix btn" value="검색">
								</form>
							</div>
						</header>
						<hr class="hr-4">
						<!-- .entry-header -->
						<div class="entry-content">
							<div id="primary" class="content-area column full">
								<main id="main" class="site-main" role="main">
									<div id="container">
										<div id="content" role="main">
											<div itemscope itemtype="http://schema.org/Product" class="product">
												<div class="images">
												</div>
												<div class="summary entry-summary">
													<div style="color:black;">
													<p>
													<c:if test="${!empty qnaFile}" >
													<div style="text-align:center;">
													<img src="/resources/upload/qnaBoardFile/${qnaFile.fileName}"  alt="이미지"/>
													</div>
													</c:if>
													</p>
														<table style="border-collapse: separate; border-spacing: none; border-top: none; border-bottom: none; margin:15px; line-height: 1; width:100%;">
															<tr itemprop="name" class="product_title entry-title"><th>${qnaBoard.qnaBoardTitle}</th> <td></td></tr>
															<tr><th>작성자 : ${qnaBoard.userId}</th> <td></td></tr>
															<tr><th>작성일 : ${qnaBoard.regDate}</th> <td></td></tr>
														</table>
													</div>
													<br>
													<p style="color:black; margin:15px;">
														${qnaBoard.qnaBoardContent}
													</p>
												</div><br>
												<div style="text-align:right;">
												<c:if test="${cookieUserId eq qnaBoard.userId}" >
												<input name="submit" type="button" id="delete" class="submit" style=" background-color:#ffd700; border:0px; width:50px;" value="삭제"/>	
												</c:if>
												
												<c:if test="${!empty cookieManagerId}" >
												<input name="submit" type="button" id="delete" class="submit" style=" background-color:#ffd700; border:0px; width:50px;" value="삭제"/>	
												</c:if>												
												<input name="submit" type="button" id="list" class="submit" style=" background-color:#ffd700; border:0px; width:50px;" value="목록"/>												
												</div>
												
												
												<!-- 매니저 아이디가 있고, 답변이 대기 중일 때 보여주는 작성 화면-->
												<c:if test="${!empty cookieManagerId and qnaBoard.replyFlag eq 'N'}" > 
												<br>
												<hr style="border: 0; border-top: 3px dashed gray;">
												<div style="text-align:center;" class="woocommerce-tabs wc-tabs-wrapper">
													<div class="panel entry-content wc-tab" id="tab-description">
														<div class="panel entry-content wc-tab" id="tab-reviews">
															<div id="reviews">
																<div id="review_form_wrapper">
																	<div id="review_form">
																		<div id="respond" class="comment-respond">
																			<form action="#" method="post" id="commentform" class="comment-form" novalidate>
																				<p class="comment-form-comment">
																					<label for="comment"></label>
																					<textarea id="comment" name="comment" cols="20" rows="5" aria-required="true" style="color:black; border-radius:10px; width: 70%; float:left;"></textarea>
																					<input name="submit" type="button" id="reply" class="submit" style="border-radius:10px;background-color:cornflowerblue; border:0px;" value="등록"/>
																				</p>
																				<p class="form-submit"></p>
																			</form>
																		</div>
																		<!-- #respond -->
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												</c:if>
												
												<!-- 답변완료상태일때 보여줄 화면 -->
												<c:if test="${qnaBoard.replyFlag eq 'Y' and !empty qnaReply}" > 
												<div class="woocommerce-tabs wc-tabs-wrapper">
													<div class="panel entry-content wc-tab" id="tab-description">
														<div class="panel entry-content wc-tab" id="tab-reviews">
															<div id="reviews">
																<div id="review_form_wrapper">
																	<div id="review_form">
																		<div id="respond" class="comment-respond">
																			<form action="#" method="post" id="commentform" class="comment-form" novalidate>
																				<p class="comment-form-comment" style="color:black;">
																				<span>
																				<table style="border-collapse: separate; padding:0 0 0;">
																				<tr><th>🥦 관리자</th>
																				<th>${qnaReply.regDate}</th>
																				</tr>
																				</table>
																				</span>
																				<span>${qnaReply.replyContent}</span><br>
																				<div style="text-align:right;">
																				<c:if test="${!empty cookieManagerId}">
																				<input name="submit" type="button" id="Mupdate" class="submit" style=" background-color:cornflowerblue; border:0px; width:50px;" value="수정"/>
																				<input name="submit" type="button" id="Mdelete" class="submit" style=" background-color:cornflowerblue; border:0px; width:50px;" value="삭제"/>
																				</c:if>
																				</div>
																				</p>
																				<p class="form-submit"></p>
																			</form>
																		</div>
																		<!-- #respond -->
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												</c:if>
												
											</div>
										</div>
									</div>
								</main>
								<!-- #main -->
							</div>
						</div>
						
					</article>
				</main>
			</div>
		</div>
	</div>
</div>
<!-- #page -->
<script src='/resources/js/jquery.js'></script>
<script src='/resources/js/plugins.js'></script>
<script src='/resources/js/scripts.js'></script>
<script src='/resources/js/accordion.js'></script>
<script src='/resources/js/tabs.js'></script>
<script src='/resources/js/toggle.js'></script>
<script src='/resources/js/masonry.pkgd.min.js'></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#Mupdate").on("click", function(){
                // 모달 창 띄우기
                $("#editModal").modal('show');
                // 현재 답변 내용을 모달 창의 textarea에 채워 넣기
                var currentContent = $(this).closest('p').find('span:last').text();
                $("#editComment").val(currentContent);
            });

            $("#saveChanges").on("click", function(){
                if($.trim($("#editComment").val()).length <= 0)
                {
                    alert("수정할 내용을 입력해주세요.");
                    $("#editComment").focus();
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "/qna/qnaReplyUpdate",
                    data: {
                        comment: $("#editComment").val(),
                        qnaBoardSeq: $("#qnaboardSeq").val()
                    },
                    beforeSend: function(xhr)
                    {
                        xhr.setRequestHeader("AJAX", "true");
                    },
                    success: function(response)
                    {
                        if(response == 404)
                        {
                            alert("입력값이 올바르지 않습니다.");
                        }
                        else if(response == 1)
                        {
                            alert("답변 수정이 완료되었습니다.");
                            document.qnaForm.action = "/qna/qnaView";
                            document.qnaForm.submit();
                        }
                        else if(response == 500)
                        {
                            alert("답변 수정 중 서버 오류가 발생했습니다.");
                        }
                        else if(response == 400)
                        {
                            alert("해당 접근이 올바르지 않습니다.");
                        }
                    },
                    error: function(error)
                    {
                        alert("답변 수정 중 알 수 없는 오류가 발생했습니다.");
                    }
                });
            });
        });
    </script>
    
<form name="qnaForm" id="qnaForm" method="post">
	<input type="hidden" id="qnaboardSeq" name="qnaboardSeq" value="${qnaBoard.qnaBoardSeq}"/>
	<input type="hidden" id="searchType" name="searchType" value="${searchType}"/>
	<input type="hidden" id="searchValue" name="searchValue" value="${searchValue}"/>
	<input type="hidden" id="curPage" name="curPage" value="${curPage}"/>
</form>

</body>
</html>

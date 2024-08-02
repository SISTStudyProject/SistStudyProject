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

		.entry-header { display: flex; justify-content: space-between; }
		.search-bar { display: flex; gap: 5px; }
		select { height: 33px; padding: 4px; border: 1px solid #ccc; border-radius: 0; }
		input[type="text"] { width: 200px; height: 33px; padding: 6px; }
		input[type="submit"] { height: 33px; }
		.table th, .table td { text-align: center; }
		.table td:nth-of-type(2) { text-align: left; }
		hr.hr-4, hr.hr-5  { border: 0; border-top: 1px solid gray; }

		* { box-sizing: border-box; }
		img { width: 100%; max-width: 400px; height: 300px; }
				input[type="button"],
		input[type="text"] {
		border-radius:10px;
		}
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#submit").on("click", function(){
		        
				if($.trim($("#title").val()).length <= 0)
				{
					alert("제목을 입력해주세요.");
					$("#title").focus();
					return;
				}
				if($.trim($("#content2").val()).length <= 0)
				{
					alert("문의 내용을 입력해주세요.");
					$("#content2").focus();
					return;					
				}
				if($('#secret').is(':checked'))
				{
					$("#secretFlag").val("Y");
				}
				
				var form = $("#writeForm")[0];
				var formData = new FormData(form);
				
				$.ajax({
					type:"POST",
					url:"/qna/qnaWriteProc",
					data:formData,
					enctype:"multipart/form-data",
					processData:false,
					contentType:false,
					cache:false,
					beforeSend:function(xhr)
					{
						xhr.setRequestHeader("AJAX", "true");
					},
					success:function(response)
					{
						if(response == 1)
						{
							alert("입력값이 올바르지 않습니다.");
						}
						else if(response == 0)
						{
							alert("글 등록이 완료되었습니다.");
							location.href = "/qna/qnaList";
						}
						else if(response == 500)
						{
							alert("글 등록 중 서버 오류가 발생했습니다.");
						}
					},
					error:function(error)
					{
						alert("문의 글 등록 중 오류가 발생했습니다.");
					}
				});
			});
			
			$("#list").on("click", function(){
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
						<hr class="hr-4">
						<!-- .entry-header -->
						<div class="entry-content">
							<div id="primary" class="content-area column full">
								<main id="main" class="site-main" role="main">
									<div id="container">
										<div id="content" role="main">
											<div itemscope itemtype="http://schema.org/Product" class="product">
											<form name="writeForm" id="writeForm" method="post"  enctype="multipart/form-data">
													<h2 itemprop="name" class="product_title entry-title" style="padding:2px;">
													<input type="text" id="title" name="title" placeholder="제목을 입력해주세요." style="color:black; width:300px; font-size:14px; border-radius:10px;"/></h2>
													<div style="color:black;">
														<table style="border-collapse: separate; border-spacing: none; border-top: none; border-bottom: none; margin:15px; line-height: 1; width:32%; float:right;">
															<tr><th>비밀글 여부 <input type="checkbox" id="secret"></th> <td></td></tr>
														</table>
													</div>
													<br>
													<span>
													<input type="file" id="boardFile" name="boardFile">
													</span>
													<br>
													<span style="color:black;">
													<textarea id="content2" name="content2" style="border-radius:10px; height:400px; color:black;" placeholder="내용을 입력해주세요." ></textarea>
													</span>
												<input type="hidden" id="secretFlag" name="secretFlag" value="N" />
												</form><br>
												<!-- .summary -->
												<div class="woocommerce-tabs wc-tabs-wrapper">
													<div class="panel entry-content wc-tab" id="tab-description">
														<div class="panel entry-content wc-tab" id="tab-reviews">
															<div id="reviews">
																<div id="review_form_wrapper">
																	<div id="review_form">
																		<div id="respond" class="comment-respond">
																			<form action="#" method="post" id="commentform" class="comment-form" novalidate>
																				<p class="comment-form-comment" style="text-align:right;">
																					<input name="submit" type="button" id="list" class="submit" style="background-color:gold; border:0px; width:50px;" value="목록"/>

																					<input name="submit" type="button" id="submit" class="submit" style="background-color:gold; border:0px; width:50px;" value="등록"/>

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

<form name="qnaForm" id="qnaForm" method="post">
	<input type="hidden" id="qnaboardSeq" name="qnaboardSeq" value=""/>
	<input type="hidden" id="searchValue" name="searchValue" value="${searchValue}"/>
	<input type="hidden" id="curPage" name="curPage" value="${curPage}"/>
</form>
</body>
</html>

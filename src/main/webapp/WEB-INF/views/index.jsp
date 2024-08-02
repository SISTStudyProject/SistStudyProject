<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head2.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Monami</title>
<link rel='stylesheet' href='/resources/css/woocommerce-layout.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
<link rel='stylesheet' href='/resources/css/woocommerce.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/font-awesome.min.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/style.css' type='text/css' media='all'/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/easy-responsive-shortcodes.css' type='text/css' media='all'/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>

<style>
	.selector-for-some-widget {
	  box-sizing: content-box;
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
	.box-height {
		height: 200px;
		width: 100%;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	
});

function fn_single(itemSeq) {
	document.itemForm.itemSeq.value = itemSeq;
// 	document.itemForm.sortBy.value = $("#orderby").val();
	document.itemForm.action = "/shop/single";
	document.itemForm.submit();
}

function fn_list(curPage) {
	document.itemForm.itemSeq.value = "";	
	document.itemForm.curPage.value = curPage;
	document.itemForm.action = "/shop/shop";
	document.itemForm.submit();
}

function fn_sortBy(){
	document.itemForm.sortBy.value = $("#sortOption").val();
	document.itemForm.curPage.value = 1;
	document.itemForm.action = "/shop/shop";
	document.itemForm.submit();
}

function fn_cate(category){
	//document.itemForm.sortBy.value = $("#sortOption").val();
	document.itemForm.itemCate.value = category;
	document.itemForm.curPage.value = 1;
	document.itemForm.action = "/shop/shop";
	document.itemForm.submit();
}
</script>

</head>
<body
	class="archive post-type-archive post-type-archive-product woocommerce woocommerce-page">

<form id="itemForm" name="itemForm" method="post">
	<input type="hidden" id="itemSeq" name="itemSeq" value="1" /> 
	<input type="hidden" id="sortBy" name="sortBy" value="${sortBy}" /> 
	<input type="hidden" id="curPage" name="curPage" value="${curPage}" />
	<input type="hidden" id="itemCate" name="itemCate" value="${itemCate}"/>
</form>

	<div id="page">
		<div class="container">
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
			
			<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="/resources/images/black1.jpg" style="height: 700px;	width: 100%;"alt="...">
    </div>
    <div class="carousel-item">
      <img src="/resources/images/black4.jpg" style="height: 700px; width: 100%;" alt="...">
    </div>
    <div class="carousel-item">
      <img src="/resources/images/black3.jpg" style="height: 700px;	width: 100%;"  alt="...">
    </div>
    <div class="carousel-item">
      <img src="/resources/images/black2.jpg" style="height: 700px;	width: 100%;" alt="...">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
			

			
			<!-- #masthead -->
			<div id="content" class="site-content">
				<div id="primary" class="content-area column full">
					<main id="main" class="site-main" role="main">
<c:if test="${itemCate != null and itemCate != ''}">
						<div style="margin-left:48%;font-size:30px;">${itemCate}</div>
</c:if>
<c:if test="${itemCate == null or itemCate == ''}">
						<div style="margin-left:48%;font-size:30px;">best</div>
</c:if>
						
						
						<div style="display: flex;justify-content: space-between;align-items: center;margin-bottom:10px;">
							<p class="woocommerce-result-count">Showing ${paging.startRow}–${paging.endRow} of ${paging.totalCount} results</p>
							<form class="woocommerce-ordering" method="get">
								<select id="sortOption" name="sortOption" class="sortOption" onchange="fn_sortBy()">
									<option value="newness" selected="selected">Default</option>
									<option value="popularity" <c:if test='${sortBy eq "popularity"}'>selected</c:if>>Sort by popularity</option>
									<option value="newness" <c:if test='${sortBy eq "newness"}'>selected</c:if>>Sort by newness</option>
									<option value="priceAsc" <c:if test='${sortBy eq "priceAsc"}'>selected</c:if>>Sort by price: low to high</option>
									<option value="priceDesc" <c:if test='${sortBy eq "priceDesc"}'>selected</c:if>>Sort by price: high to low</option>
								</select>
							</form>
						</div>

						<ul class="products">

<c:forEach var="item" items="${itemList}" varStatus="status">
	<c:if test="${status.index%4 == 0}">
							<li class="first product">
								<a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
									<img src="/resources/upload/${item.fileName}" alt="">
									<h3>${item.itemName}</h3> 
									<span class="price"><span class="amount">${item.itemPrice}원</span></span>
								</a>
								<a href="#" class="button">Add to cart</a>
							</li>
	</c:if>
	<c:if test="${status.index%4 == 1}">
							<li class="product">
								<a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
									<img src="/resources/upload/${item.fileName}" alt="">
									<h3>${item.itemName}</h3> 
									<span class="price"><span class="amount">${item.itemPrice}원</span></span>
								</a>
								<a href="#" class="button">Add to cart</a>
							</li>
	</c:if>
	<c:if test="${status.index%4 == 2}">
							<li class="product">
								<a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
									<img src="/resources/upload/${item.fileName}" alt="">
									<h3>${item.itemName}</h3> 
									<span class="price"><span class="amount">${item.itemPrice}원</span></span>
								</a>
								<a href="#" class="button">Add to cart</a>
							</li>
	</c:if>
	<c:if test="${status.index%4 == 3}">
							<li class="last product">
								<a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
									<img src="/resources/upload/${item.fileName}" alt="">
									<h3>${item.itemName}</h3> 
									<span class="price"><span class="amount">${item.itemPrice}원</span></span>
								</a>
								<a href="#" class="button">Add to cart</a>
							</li>
	</c:if>
</c:forEach>
						</ul>
						
						
					<c:if test="${!empty paging}">
						<nav class="woocommerce-pagination">
							<ul class="page-numbers">
						<c:if test="${paging.prevBlockPage gt 0}">
								<li><a class="next page-numbers" href="#"><</a></li>
						</c:if>
							
						<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
							<c:choose>
								<c:when test="${i eq curPage}">
								<li><span class="page-numbers current">${i}</span></li>
								</c:when>
								<c:otherwise>
								<li><span class="page-numbers" onclick="fn_list(${i})">${i}</span></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:if test="${paging.nextBlockPage gt 0}">
								<li><a class="next page-numbers" href="#">></a></li>
						</c:if>
							</ul>
						</nav>
						</c:if>
						
					</main>
					<!-- #main -->
				</div>
				<!-- #primary -->
			</div>
			<!-- #content -->
		</div>
		<!-- .container -->
		<footer id="colophon" class="site-footer">
			<div class="container">
				<div class="site-info">
					<h1
						style="font-family: 'Herr Von Muellerhoff'; color: #ccc; font-weight: 300; text-align: center; margin-bottom: 0; margin-top: 0; line-height: 1.4; font-size: 46px;">Moschino</h1>
						Shared by <i class="fa fa-love"></i><a
						href="https://bootstrapthemes.co">BootstrapThemes</a>

				</div>
			</div>
		</footer>
		<a href="#top" class="smoothup" title="Back to top"><span
			class="genericon genericon-collapse"></span></a>
	</div>
	<!-- #page -->
	<!-- <script src='js/jquery.js'></script> -->
	<!-- <script src='js/plugins.js'></script> -->
	<!-- <script src='js/scripts.js'></script> -->
	<!-- <script src='js/masonry.pkgd.min.js'></script> -->
</body>
</html>
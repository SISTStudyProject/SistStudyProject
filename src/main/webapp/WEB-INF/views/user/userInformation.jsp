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
					<h3 style="margin-left:39.5%;">MyPage Information</h3>					
					
					<div class="container" style="border-radius: 25px / 25px; border: 1px solid;">
						<br> 
						<div style="margin-left: 25%;">
							<h4 style="display:inline;">UserId : <h5 style="display:inline;">${stUser.userId}</h5></h4>	
							
							<h4 style="display:inline; margin-left: 20%;">UserPoint : <h5 style="display:inline;">${stUser.userPoint}</h5></h4>											
						</div>
						<br>
						<br>
						<div style="margin-left: 22.5%;">
							<h4 style="display:inline;">UserName : <h5 style="display:inline;">${stUser.userName}</h5></h4>	
							
							<h4 style="display:inline; margin-left: 18.5%;">UserEmail : <h5 style="display:inline;">${stUser.userEmail}</h5></h4>	
						</div>	
						<br>
						<br>
						<div style="margin-left: 23%;">
							<h4 style="display:inline;">UserTel : <h5 style="display:inline;">${stUser.userTel}</h5></h4>
							<h4 style="display:inline; margin-left: 13.5%;" >RegisterDate : <h5 style="display:inline;">${stUser.regDate}</h5></h4>		
						</div>
						<br>
						<br>
						<div style="margin-left: 20%;">
							<h4 style="display:inline;">UserAddress : <h5 style="display:inline;">${stUser.userAddress}</h5></h4>	
						</div>
						<br>
						<br>
						<br>
						<div style="margin-left: 27.5%;">
							<a href="/user/mypage/informationchange" class="button">정보 수정</a>
							<a href="/user/mypage/paymentlist" class="button">구매 내역</a>	
							<a href="/user/mypage/reviewlist" class="button">내 리뷰 목록</a>
							<a href="/user/mypage/qnalist" class="button">내 문의 내역</a>			
						</div>
						<br>
						<br>						
						<br>
					</div>
					<br>
					<br>
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
</body>

<script type="text/javascript">
<c:if test="${empty stUserCookie}">
	location.href="/";
</c:if>

<c:if test="${stUser eq null}">
	alert("잘못된 접근입니다.");
	location.href="/shop/shop";
</c:if>



</script>
</html>
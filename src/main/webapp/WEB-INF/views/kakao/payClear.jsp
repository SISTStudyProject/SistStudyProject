<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<%@ include file="/WEB-INF/views/include/head2.jsp"  %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Moschino | Minimalist Free HTML Portfolio by WowThemes.net</title>

<link rel='stylesheet' href='/resources/css/woocommerce-layout.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
<link rel='stylesheet' href='/resources/css/woocommerce.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/font-awesome.min.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/style.css' type='text/css' media='all'/>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/easy-responsive-shortcodes.css' type='text/css' media='all'/>

<style>
.container {
    max-width: 800px;
    margin: 0 auto;
}

.text-center {
    text-align: center;
}

.order-section {
    border: 1px solid #ddd;
    padding: 10px;
    margin-bottom: 20px;
}

.order-item {
    border-bottom: 1px solid #ddd;
    
}

.order-item:last-child {
    border-bottom: none;
}

.order-item-image {
    width: 100px;
    height: auto;
}

.order-item-details {
    flex: 1;
    padding: 0 10px;
}

.order-item-price,
.order-item-total {
    text-align: right;
}

.terms-section,
.user-info-section,
.total-section {
    border: 1px solid #ddd;
    padding: 10px;
    margin-bottom: 20px;
}

h4 {
    border-bottom: 1px solid #ddd;
    padding-bottom: 10px;
    margin-bottom: 10px;
}

.form-group {
    margin-bottom: 10px;
}

.d-flex {
    display: flex;
}

.justify-content-between {
    justify-content: space-between;
}

.justify-content-center {
    justify-content: center;
}

.align-items-center {
    align-items: center;
}

.btn {
    padding: 10px 20px;
    margin: 10px;
}

.btn-primary {
    background-color: #007bff;
    border: none;
    color: white;
}

.btn-secondary {
    background-color: #6c757d;
    border: none;
    color: white;
}

@media (max-width: 768px) {
    .order-item {
        flex-direction: column;
        align-items: flex-start;
         width: 300px; /* 이미지 너비 설정 */
            height: auto; /* 이미지 높이 자동 조정 */
            margin-right: 10px; /* 이미지 오른쪽 여백 */
    }
   

    .order-item-price,
    .order-item-total {
        text-align: left;
    }
}
</style>

<script>
$(document).ready(function(){

});

function fn_tag(category){
	document.itemForm.itemCate.value = category;
	document.itemForm.action = "/shop/shop";
	document.itemForm.submit();
}

function fn_single(itemSeq) {
	document.itemForm.itemSeq.value = itemSeq;
	document.itemForm.action = "/shop/single";
	document.itemForm.submit();
}

</script>


</head>
<body class="single single-product woocommerce woocommerce-page">

<form id="itemForm" name="itemForm" method="post" action ="/shop/single">
	<input type="hidden" id="itemSeq" name="itemSeq" value="1" />
	<input type="hidden" id="itemCate" name="itemCate" value="${item.itemCate}"/>
</form>

<div id="page">
	<div class="container">
			<header id="masthead" class="site-header">
				<div class="site-branding">
					<h1 class="site-title">
						<a href="index.html" rel="home">Monami</a>
					</h1>
					<h2 class="site-description">By buying our product, you can become a minimalist</h2>
				</div>
<%@ include file="/WEB-INF/views/include/nav.jsp"%>
			</header>
<div class="container">
<c:choose>
	<c:when test="${!empty approve}">
	<h2>결제가 정상적으로 완료되었습니다.</h2>
	결제 일시: ${approve.approved_at}
	<br/>
	주문 번호: ${approve.partner_order_id}
	<br/>
	상품명: ${approve.item_name}
	<br/>
	상품 수량: ${approve.quantity}
	<br/>
	결제 금액: ${approve.amount.total}
	<br/>
	결제 방법: ${approve.payment_method_type}<br/>
	</c:when>
	<c:otherwise>
	<h2>카카오페이 결제 중 오류가 발생하였습니다.</h2>
	</c:otherwise>
</c:choose>
</div>
	<!-- .container -->
	<footer id="colophon" class="site-footer">
	<div class="container">
		<div class="site-info">
			<h1 style="font-family: 'Herr Von Muellerhoff';color: #ccc;font-weight:300;text-align: center;margin-bottom:0;margin-top:0;line-height:1.4;font-size: 46px;">Moschino</h1>
			Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a>

		</div>
	</div>
	</footer>
	<a href="#top" class="smoothup" title="Back to top"><span class="genericon genericon-collapse"></span></a>
</div>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
</script>
</body>
</html>
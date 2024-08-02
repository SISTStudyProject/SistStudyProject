<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header id="masthead" class="site-header">
	<div class="cart-css" onclick="fn_toCart()">
    <img src="/resources/images/icons8-가방-64.png" >
    <div class="cartNum-css">${cartTotalCnt}</div>
   </div>
</header>

<script>
function fn_toCart(){
		var user = '${user}';
		
		if(user == null || user == ''){
		   alert("장바구니는 회원만 이용 가능합니다.");
		   return;
		}
		
		location.href = "/shop/myCart";
}
</script>
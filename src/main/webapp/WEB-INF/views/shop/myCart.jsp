<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head2.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='/resources/css/woocommerce-layout.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
<link rel='stylesheet' href='/resources/css/woocommerce.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/font-awesome.min.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/style.css' type='text/css' media='all'/>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/easy-responsive-shortcodes.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/myCart.css' type='text/css' media='all'/>
<style>
.cart-css{
   position: fixed;
   right: 80px;
   top: 80px;
   width:30px;
   cursor:pointer;
}
.cartNum-css{
   position: fixed;
   right: 91px;
   top: 89px;
   font-size:11px;
   color:gary;
   cursor:pointer;
}
</style>

<script>

$(document).ready(function(){
	
});


function fn_selectAll(source) {
	const isChecked = $(source).prop('checked');
	$('input[type="checkbox"]').prop('checked', isChecked);
}

function fn_single(itemSeq){
	document.itemForm.itemSeq.value = itemSeq;
	document.itemForm.action = "/shop/single";
	document.itemForm.submit();	
}


function increaseNum(itemSeq) {
    var itemNum = $('#itemNumInput_' + itemSeq);
    var curNum = parseInt(itemNum.val(), 10);
    if(curNum < 100){
    	itemNum.val(curNum + 1);
    	$("#itemNum").val(itemNum.val());
    	
    	$.ajax({
    	    type:"POST",
    	    url:"/itemNumUpdateProc",
    	    data:{
    	    	itemSeq:itemSeq,
    	    	itemNum:$("#itemNum").val()
    	    },
    	    datatype:"JSON",
    	    cache:false,
    	    beforeSend:function(xhr){
    	       xhr.setRequestHeader("AJAX", "true");
    	    },
    	    success:function(res){
    	       if(res == 200){
    	            //alert("수량이 변경되었습니다.");
    	    		location.reload();
    	       }
    	       else{
    	          alert("수량 변경 중 오류가 발생하였습니다.");
    	       }
    	    },
    	    error:function(error){
    	    	alert("수량 변경 중 예상치 못한 오류가 발생하였습니다.");
    	    }
    	});
    	
    }else{
    	alert("최대 100개까지 주문 가능합니다.");
    }
}

function decreaseNum(itemSeq) {
    var itemNum = $('#itemNumInput_' + itemSeq);
    var curNum = parseInt(itemNum.val(), 10);
    if (curNum > 1) {
    	itemNum.val(curNum - 1);
    	$("#itemNum").val(itemNum.val());
    	
    	$.ajax({
    	    type:"POST",
    	    url:"/itemNumUpdateProc",
    	    data:{
    	    	itemSeq:itemSeq,
    	    	itemNum:$("#itemNum").val()
    	    },
    	    datatype:"JSON",
    	    cache:false,
    	    beforeSend:function(xhr){
    	       xhr.setRequestHeader("AJAX", "true");
    	    },
    	    success:function(res){
    	       if(res == 200){
    	          //alert("수량이 변경되었습니다.");
    	    	   location.reload();
    	       }
    	       else{
    	          alert("수량 변경 중 오류가 발생하였습니다.");
    	       }
    	    },
    	    error:function(error){
    	    	alert("수량 변경 중 예상치 못한 오류가 발생하였습니다.");
    	    }
    	});
    	
    }
}

function fn_delete(itemSeq){
	if(!confirm("해당 상품을 장바구니에서 삭제하시겠습니까?")){
		return;
	}

	//fn_deleteProc();
	
	$.ajax({
	    type:"POST",
	    url:"/itemDeleteProc",
	    data:{
	    	itemSeq:itemSeq
	    },
	    datatype:"JSON",
	    cache:false,
	    beforeSend:function(xhr){
	       xhr.setRequestHeader("AJAX", "true");
	    },
	    success:function(res){
	       if(res == 200){
	    		location.reload();
	       }
	       else{
	          alert("삭제 중 오류가 발생하였습니다.");
	       }
	    },
	    error:function(error){
	    	alert("삭제 중 예상치 못한 오류가 발생하였습니다.");
	    }
	});
}

function fn_someDel() {
    var list = [];
    var checkboxes = document.getElementsByTagName('input');

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].type == 'checkbox' && checkboxes[i].checked) {
            var itemSeq = checkboxes[i].getAttribute('data-itemseq');
            list.push(itemSeq);
        }
    }

    console.log('선택된 itemSeq 값:', list);

}

// function fn_deleteProc(){
	
// }

function fn_order(){
	var list = [];
	var checkboxes = document.getElementsByTagName('input');
	
	for (var i = 0; i < checkboxes.length; i++) {
	    if (checkboxes[i].type == 'checkbox' && checkboxes[i].getAttribute('data-itemseq') != null) {
	        var itemSeq = checkboxes[i].getAttribute('data-itemseq');
	        list.push(itemSeq);
	    }
	}
	
	console.log('주문할 전체 itemSeq 값:', list);
}

</script>
</head>
<body>
<form id="itemForm" name="itemForm" method="post">
	<input type="hidden" id="itemSeq" name="itemSeq" value="1" />
	<input type="hidden" id="itemNum" name="itemNum" value="1" />
</form>
<div id="page">
	<div class="container">
		<header id="masthead" class="site-header">
			<%@ include file="/WEB-INF/views/include/header.jsp"%>
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
		</header>
		
		<!-- 본문 -->
		<div>
			<div class="cartName-css">장바구니</div>
			
			<table>
			    <thead>
			        <tr>
			            <th><input type="checkbox" onclick="fn_selectAll(this)">전체 선택</th>
			            <th>번호</th>
			            <th >상품 사진</th>
			            <th colspan="2">상품 정보</th>
			            <th>수량</th>
			            <th>상품구매금액</th>
			        </tr>
			    </thead>
			    <tbody>
<c:choose>
	<c:when test="${not empty list}">
		<c:forEach var="item" items="${list}" varStatus="status">
			        <tr>
			            <td><input type="checkbox" data-itemseq="${item.itemSeq}"></td>
			            <td>${status.index + 1}</td>
			            <td>
			            	<img class="item-css" src="/resources/upload/${item.fileName}" 
			            		 onclick="fn_single('${item.itemSeq}')" alt="상품사진" >
			            </td>
			            <td>
			            	<div class="item-css2" onclick="fn_single('${item.itemSeq}')">${item.itemName}
			            		<div style="font-size:10px;">${item.itemCode}</div>
			            		</div>
			            </td>
			            <td>
			            	<fmt:formatNumber value="${item.itemPrice}" type="number" groupingUsed="true"/>
			            </td>
			            <td>
							<div class="number-wrapper">
					            <button type="button" class="button-css" onclick="decreaseNum('${item.itemSeq}')">-</button>
					            <input type="number" id="itemNumInput_${item.itemSeq}" value="${item.itemNum}" min="1" class="number-css" readonly>
					            <button type="button" class="button-css" onclick="increaseNum('${item.itemSeq}')">+</button>
					        </div>
			            </td>
			            <td><fmt:formatNumber value="${item.itemPrice * item.itemNum}" type="number" groupingUsed="true"/> won</td>
			            <td><button onclick="fn_delete('${item.itemSeq}')" class="delete-css">x 삭제</button></td>
			        </tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<tr>
			<td colspan="8" style="text-align:center;">장바구니가 비어 있습니다.</td>
		</tr>
	</c:otherwise>
</c:choose>
			    </tbody>
			</table>
			<button type="button" onclick="fn_someDel()">선택 삭제</button>
			<button type="button">장바구니 비우기</button>
			
			<hr />
			
			<a href="/shop/payment">
				<button onclick="herf='/shop/payment'">선택상품 주문</button>
			</a>
			
		</div>
		<br /><br /><br />
		
	</div>
</div>
		
</body>
</html>
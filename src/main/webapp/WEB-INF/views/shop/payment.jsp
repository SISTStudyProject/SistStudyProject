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
.form-group {
    margin-bottom: 15px;
}
.form-group label {
    display: block;
    margin-bottom: 5px;
}
.form-group input[type="text"],
.form-group input[type="button"] {
    width: 100%;
    padding: 10px;
    box-sizing: border-box;
    font-size: 16px;
}
.form-group input[type="button"] {
    width: auto;
    display: inline-block;
}
#sample6_postcode,
#sample6_address,
#sample6_detailAddress {
    width: calc(100% - 15px);
    margin-bottom: 10px;
}
#sample6_extraAddress {
    display: inline-block;
    width: 100%;
    margin-top: 5px;
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
 .postcode-group {
            display: flex;
            align-items: center;
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
		<%@ include file="/WEB-INF/views/include/nav.jsp"%>
		<!-- #주문목록 -->
		<div id="content" class="site-content">
			<div id="primary" class="content-area column full">
				<main id="main" class="site-main" role="main">
				<h2 style="text-align: center;">orderList</h2>
<ul class="order-list">
    <c:forEach var="item" items="${itemList}" varStatus="status">
        <li class="order-item d-flex justify-content-between align-items-center p-3 mb-3">
            <div class="d-flex align-items-center">
                <img src="/resources/upload/${item.fileName}" class="order-item-image" alt="">
                <div class="order-item-details">
                    <p>${item.itemName}</p>
                    <span class="order-item-total"><span class="amount">${item.itemPrice}원</span></span>
                    <span class="order-item-total">${item.itemNum}개</span>
                </div>
            </div>
        </li>
            <input type="hidden" class="order-item-code" value="${item.itemCode}">
           	<input type="hidden" class="order-item-Name" value="${item.itemName}">
           	<input type="hidden" class="order-item-quantity" value="${item.quantity}">
           	<input type="hidden" class="order-item-itemPrice" value="${item.itemPrice}">
    </c:forEach>
</ul>
				<hr/>
				
				<!-- #주문정보 -->
				<h2 style="text-align: center;">orderInfo</h2>
				<form>
					<div class="form-group">
					    <label for="name">신청인</label>
					    <c:choose>
					    <c:when test="${user != null}">
					    	<input type="text" id="name" class="form-control" value="${user.userName}">
					    </c:when>
					    <c:otherwise>
					    	<input type="text" id="name" class="form-control" value="">
					    </c:otherwise>
					    </c:choose>
					    
					</div>
					<div class="form-group">
					    <label for="email">이메일</label>
					   <c:choose>
					    <c:when test="${user != null}">
					    	<input type="text" id="email" class="form-control" value="${user.userEmail}">
					    </c:when>
					    <c:otherwise>
					    	<input type="text" id="email" class="form-control" value="">
					    </c:otherwise>
					    </c:choose>
					</div>
					<div class="form-group">
					    <label for="phone">휴대폰 번호</label>
<c:choose>
					    <c:when test="${user != null}">
					    	<input type="text" id="phone" class="form-control" value="${user.userTel}">
					    </c:when>
					    <c:otherwise>
					    	<input type="text" id="phone" class="form-control" value="">
					    </c:otherwise>
					    </c:choose>					</div>
					<div class="form-group">
					    <label for="address">수령지</label>
					    <div class="postcode-group">
<input type="text" id="sample6_postcode" placeholder="우편번호">
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" style="margin-left:10px; margin-bottom:10px;"></div>
<input type="text" id="sample6_address" placeholder="주소"><span id="sample6_extraAddress"></span><br>
<input type="text" id="sample6_detailAddress" placeholder="상세주소">

				</div>
	         	</form>

	            	
	            	<!-- #포인트 -->
	            	<c:if test="${user!= null}">
	            	<hr/>
	            	<div class="point">
		            	<p>포인트 사용: <input type="number" id="usePoint"> / <span class="amount" id="totalPoint">${user.userPoint}원</span></p>
		            </div>
	            	<hr/>
	            	</c:if>
	            	
	            <!-- #결제정보 -->	
				<h2 style="text-align: center;">orderInfo</h2>
	            	<div class="total-section mb-4">
			            <h4>총 주문금액</h4>
			            <p>주문 금액: <span class="amount" id="totalP">${totalPrice}원</span></p>
			            <p>배송 금액: <span class="amount" id="sendingP">3000 원</span></p>
			            <p>할인 금액: <span id="finalPoint"></span> 원</p>
			            <p><strong>최종 결제 금액: <span id="finalP"></span> 원</strong></p>
			        </div>
			        <div class="d-flex justify-content-center">
			        <input type="button" class="btn btn-primary" value="결제하기" id="payment">
			           
			        </div>
				</main>
				<!-- #main -->
			</div>
			<!-- #primary -->
		</div>
		<!-- #content -->
	</div>

	   <form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp" action="/kakao/payPopUp">
   		<input type="hidden" name="orderId" id="orderId" value=""/>
   		<input type="hidden" name="tId" id="tId" value=""/>
   		<input type="hidden" name="pcUrl" id="pcUrl" value=""/>
   		<input type="hidden" name="totalAmaount" id="totalAmaount" value=""/>
   		<input type="hidden" name="point" id="point" value=""/>
   		</form>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function() {
	var totalPoint = parseInt($('#totalPoint').text().replace('원', ''));
	if (!(totalPoint > 0)) {
		$('#usePoint').val(0);
	    $('#usePoint').attr("disabled", true);
	}
	$("#finalPoint").text($('#usePoint').val());
    $('#usePoint').on('input', function() {
        var usePoint = parseInt($(this).val());
        if (usePoint > totalPoint) {
            $(this).val(totalPoint);
        } else if (usePoint < 0) {
            $(this).val(0);
        }
        $("#finalPoint").text($('#usePoint').val());
        calculateFinalPrice();
    });
    calculateFinalPrice();
    
    var itemName ="";
    var quantity ="";
    
    $("#payment").on("click", function() {
        if (checkForm()) {
            if (confirm("이대로 진행할까요?")) {
                var orderList = []; // 주문 항목 배열 초기화

                $('.order-item').each(function() {
                    var $item = $(this);
                    var itemCode = $item.find('.order-item-code').val();
                    var itemName = $item.find('.order-item-details p').text(); // 수정: 클래스명 변경
                    var quantity = $item.find('.order-item-quantity').val();
                    var itemPrice = $item.find('.order-item-total .amount').text().replace('원', '').trim();
				
                    var orderItem = {
                        itemCode: itemCode,
                        itemName: itemName,
                        quantity: quantity,
                        itemPrice: itemPrice
                    };
                    orderList.push(orderItem);
                });

                console.log(JSON.stringify({
                    orderList: orderList, // 주문 항목 배열 전송
                    totalAmount: $("#finalP").text().trim() // 최종 결제 금액 전송
                }));
                // 주문 항목 데이터를 서버로 전송
                $.ajax({
                    type: "POST", // POST 방식으로 전송
                    url: "/kakao/payReady", // 데이터를 전송할 URL
                    contentType: "application/json", // 전송하는 데이터 타입이 JSON임을 명시
                    data: JSON.stringify({
                        orderList: orderList, // 주문 항목 배열 전송
                        totalAmount: $("#finalP").text().trim() // 최종 결제 금액 전송
                    }),
                    dataType: "json", // 서버로부터 받을 데이터 타입 지정
                    success: function(response) {
                        console.log(response);
                        if (response.code == 0) {
                            var orderId = response.data.orderId;
                            var tId = response.data.tId;
                            var pcUrl = response.data.pcUrl;
                            var itemName = response.data.itemName;
                            var itemCode = response.data.itemCode;
                            var totalAmaount = response.data.totalAmaount;
                            var point = $('#usePoint').val();
                            
                            $("#orderId").val(orderId);
                            $("#tId").val(tId);
                            $("#pcUrl").val(pcUrl);
                            $("#itemName").val(itemName);
                            $("#itemCode").val(itemCode);
                            $("#totalAmaount").val(totalAmaount);
                            $("#point").val(point);

                            var win = window.open('', 'kakaoPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=100,top=100');
                            $("#kakaoForm").submit();
                        } else {
                            alert("오류가 발생하였습니다.");
                            $("#payment").prop("disabled", false);
                        }
                    },
                    error: function(error) {
                        console.error(error);
                        alert("서버 오류가 발생하였습니다.");
                        $("#payment").prop("disabled", false);
                    }
                });
            }
        }
    });

});
function checkForm (){
	var name = $('#name').val().trim();
    var email = $('#email').val().trim();
    var phone = $('#phone').val().trim();
    var address = $('#sample6_address').val().trim();
    var postcode = $('#sample6_postcode').val().trim();;

    // 이름 필드 유효성 검사
    if (name === '') {
        alert('이름을 입력해주세요.');
        return false; // 폼 전송 중지
    }

    // 이메일 필드 유효성 검사
    if (email === '') {
        alert('이메일을 입력해주세요.');
        return false; // 폼 전송 중지
    }

    // 휴대폰 번호 필드 유효성 검사
    if (phone === '') {
        alert('휴대폰 번호를 입력해주세요.');
        return false; // 폼 전송 중지
    }

    // 주소 필드 유효성 검사
    if (address === '') {
        alert('주소를 입력해주세요.');
        return false; // 폼 전송 중지
    }

    // 우편번호 필드 유효성 검사
    if (postcode === '') {
        alert('우편번호를 입력해주세요.');
        return false; // 폼 전송 중지
    }

    // 모든 필드가 유효성 검사를 통과하면 true를 반환하여 폼을 제출합니다.
    return true;
}
function calculateFinalPrice() {
    var totalPrice = parseInt('${totalPrice}'); 
    var shippingCost = 3000;
    var discountAmount = $('#usePoint').val();
    var finalPrice = totalPrice + shippingCost - discountAmount;

    $('#finalP').text(finalPrice);
}
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수


                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){

                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }

                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }

                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }

                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
</body>
</html>
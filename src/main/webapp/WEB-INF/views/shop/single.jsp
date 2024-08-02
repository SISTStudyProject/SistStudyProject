<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<%@ include file="/WEB-INF/views/include/head2.jsp"  %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MONAMI | Minimalist Free HTML Portfolio by WowThemes.net</title>

<link rel='stylesheet' href='/resources/css/woocommerce-layout.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
<link rel='stylesheet' href='/resources/css/woocommerce.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/font-awesome.min.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/style.css' type='text/css' media='all'/>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/easy-responsive-shortcodes.css' type='text/css' media='all'/>

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

function fn_reboardList(itemSeq)
{
	document.itemForm.itemSeq.value = itemSeq;
	location.href = "/reboard/list?itemSeq=" + itemSeq;
}

$(document).ready(function(){

});

function fn_tag(category){
   document.itemForm.itemCate.value = category;
   document.itemForm.action = "/shop/shop";
   document.itemForm.submit();
}

function fn_single(itemSeq) {
	document.itemForm.itemSeq.value = itemSeq;
	location.href = '/shop/single?itemSeq=' + itemSeq;
}

function fn_addCart(itemSeq){
	
	var itemNum = $('#itemNumInput').val();
	var user = '${user}';
	
	if(user == null || user == ''){
		alert("장바구니는 회원만 이용 가능합니다.");
		return;
	}

   if(itemNum < 1 || itemNum > 100){
      alert("수량은 1개부터 최대 100개까지 선택할 수 있습니다.");
      return;
   }
   
   $("#itemNum").val(itemNum);
   
	$.ajax({
		type:"POST",
		async: false,
		url:"/addToCartProc",
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
				alert("장바구니 담기 성공!");
				if(confirm("장바구니로 이동하시겠습니까?")){
					location.href = "/shop/myCart";
				}else{
					location.reload();
				}
			}
			else if(res == 111){
				if(!confirm("해당 상품은 이미 장바구니에 존재합니다. 수량을 추가하시겠습니까?")){
					return;
				}else{
					fn_itemNumUpdate();
				}
			}
			else{
				alert("장바구니에 상품을 추가하는 중 오류가 발생했습니다.");
			}
		},
		error:function(error){
			alert("장바구니에 상품을 추가하는 중 예상치 못한 오류가 발생했습니다.");
		}
	});
}

function fn_itemNumUpdate(){
	$.ajax({
	    type:"POST",
	    async: false,
	    url:"/itemNumUpdateProc",
	    data:{
	       itemSeq:$("#itemSeq").val(),
	       itemAddNum:$("#itemNum").val()
	    },
	    datatype:"JSON",
	    cache:false,
	    beforeSend:function(xhr){
	       xhr.setRequestHeader("AJAX", "true");
	    },
	    success:function(res){
	       if(res == 201){
	           if(confirm("수량이 변경되었습니다. 장바구니로 이동하시겠습니까?")){
	        	   location.href = "/shop/myCart";
	           } else {
	               location.reload();
	           }
	       }else{
	          alert("수량 변경 중 오류가 발생했습니다.");
	       }
	    },
	    error:function(error){
	       alert("수량 변경 중 예상치 못한 오류가 발생했습니다.");
	    }
	});
}

</script>


</head>
<body class="single single-product woocommerce woocommerce-page">

<form id="itemForm" name="itemForm" method="post">
   <input type="hidden" id="itemSeq" name="itemSeq" value="${itemSeq}" />
   <input type="hidden" id="itemNum" name="itemNum" value="0" />
   <input type="hidden" id="itemCate" name="itemCate" value="" />
</form>

<div id="page">
   <div class="container">
         <%@ include file="/WEB-INF/views/include/header.jsp"%>
         <%@ include file="/WEB-INF/views/include/nav.jsp"%>
      
      <!-- #masthead -->
      <div id="content" class="site-content">
         <div id="primary" class="content-area column full">
            <main id="main" class="site-main" role="main">
            <div id="container">
               <div id="content" role="main">
                  <nav class="woocommerce-breadcrumb" itemprop="breadcrumb"><a href="/">Home</a> / <a href="/shop/shop">Clothing</a> / <a href="#" onclick="fn_tag('${itemData.itemCate}')">${itemData.itemCate}</a></nav>
                  <div itemscope itemtype="http://schema.org/Product" class="product">

   <c:forEach begin="1" end="1" varStatus="loop"> 
                     <div class="images">
                        <a itemprop="image" class="woocommerce-main-image zoom" title="" data-rel="prettyPhoto">                        
                        <img src="/resources/upload/${itemData.fileName}" class="slide"></img>
                        </a>
                     </div>
    </c:forEach> 

                     <div class="summary entry-summary">
                        <h1 itemprop="name" class="product_title entry-title">${itemData.itemName}</h1>
                        <div class="woocommerce-product-rating" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
			<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i>
			<a onclick="fn_reboardList('${itemData.itemSeq}')" class="woocommerce-review-link" rel="nofollow">(<span itemprop="reviewCount" class="count">${reboardTotal}</span> customer reviews)</a>
			</div>
                        <div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                           <p class="price">
                              <span class="amount">${itemData.itemPrice}원</span>
                           </p>
                           <meta itemprop="price" content="35"/>
                           <meta itemprop="priceCurrency" content="USD"/>
                           <link itemprop="availability" href="http://schema.org/InStock"/>
                        </div>
                        <div itemprop="description">
                           <p>
                              ${itemData.itemIntro}
                           </p>
                        </div>
                        <form class="cart" method="post" enctype='multipart/form-data'>
                           <div class="quantity">
                              <input type="number" id="itemNumInput" step="1" min="1" max="100" name="quantity" value="1" title="Qty" class="input-text qty text" size="4"/>
                           </div>                           
                           <button type="button" onclick="fn_addCart('${itemData.itemSeq}')" class="single_add_to_cart_button button alt">Add to cart</button>
                        </form>
                        <div class="product_meta">
                           <span class="posted_in">Categories: 
                           <a href="#" onclick="fn_tag('')" rel="tag">all</a>
                           <a href="#" onclick="fn_tag('${itemData.itemCate}')" rel="tag">${itemData.itemCate}</a>, 
                           </span>
                        </div>
                     </div>
                     <!-- .summary -->
                     <div class="woocommerce-tabs wc-tabs-wrapper">
                        <div class="panel entry-content wc-tab" id="tab-description">
                           <h2>Product Description</h2>
                           <p>
                              ${itemData.itemIntro}
                           </p>
                        </div>

                     </div>
                     
                     
                     <div class="related products">
                        <h2>Related Products</h2>
                        <ul class="products">
      <c:forEach var="item" items="${itemRecList}" varStatus="status">
         <c:if test="${status.index%4 == 0}">
                           <li class="first product">
                              <a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
                                 <img src="/resources/upload/${item.fileName}" alt="">
                                 <h3>${item.itemName}</h3> 
                                 <span class="price"><span class="amount">${item.itemPrice}원</span></span>
                              </a>
                              <a onclick="fn_single('${item.itemSeq}')" class="button">Show Detail</a>
                           </li>
         </c:if>
         <c:if test="${status.index%4 == 1}">
                           <li class="product">
                              <a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
                                 <img src="/resources/upload/${item.fileName}" alt="">
                                 <h3>${item.itemName}</h3> 
                                 <span class="price"><span class="amount">${item.itemPrice}원</span></span>
                              </a>
                              <a onclick="fn_single('${item.itemSeq}')" class="button">Show Detail</a>
                           </li>
         </c:if>
         <c:if test="${status.index%4 == 2}">
                           <li class="product">
                              <a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
                                 <img src="/resources/upload/${item.fileName}" alt="">
                                 <h3>${item.itemName}</h3> 
                                 <span class="price"><span class="amount">${item.itemPrice}원</span></span>
                              </a>
                              <a onclick="fn_single('${item.itemSeq}')" class="button">Show Detail</a>
                           </li>
         </c:if>
         <c:if test="${status.index%4 == 3}">
                           <li class="last product">
                              <a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
                                 <img src="/resources/upload/${item.fileName}" alt="">
                                 <h3>${item.itemName}</h3> 
                                 <span class="price"><span class="amount">${item.itemPrice}원</span></span>
                              </a>
                              <a onclick="fn_single('${item.itemSeq}')" class="button">Show Detail</a>
                           </li>
         </c:if>
      </c:forEach>
                        </ul>
                     </div>
                     
                     
                  </div>
               </div>
            </div>
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
         <h1 style="font-family: 'Herr Von Muellerhoff';color: #ccc;font-weight:300;text-align: center;margin-bottom:0;margin-top:0;line-height:1.4;font-size: 46px;">Moschino</h1>
         Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a>

      </div>
   </div>
   </footer>
   <a href="#top" class="smoothup" title="Back to top"><span class="genericon genericon-collapse"></span></a>
</div>
<!-- #page -->
<!-- <script src='js/jquery.js'></script> -->
<!-- <script src='js/plugins.js'></script> -->
<!-- <script src='js/scripts.js'></script> -->
<!-- <script src='js/masonry.pkgd.min.js'></script> -->
</body>
</html>
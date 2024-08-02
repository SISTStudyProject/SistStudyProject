<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head2.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Moschino | shop</title>
<link rel='stylesheet' href='/resources/css/woocommerce-layout.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
<link rel='stylesheet' href='/resources/css/woocommerce.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/font-awesome.min.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/style.css' type='text/css' media='all'/>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/easy-responsive-shortcodes.css' type='text/css' media='all'/>

<style>
.category {
   display: flex;
   position: reletive;
   justify-content: center;
   align-items: center;
   z-index: 1;
   padding: 10px 0;
   margin-top: 30px;
   margin-bottom: 30px;
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
}
.clicked {
    font-weight: bold !important;
    color: #737373;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	
});

function fn_single(itemSeq) {
   document.itemForm.itemSeq.value = itemSeq;
   location.href = '/shop/single?itemSeq=' + itemSeq;
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

function fn_addCart(itemSeq){
   //alert("장바구니 담기 -- itemSeq : " + itemSeq);
   
   var user = '${user}';
   
   if(user == null || user == ''){
      alert("장바구니는 회원만 이용 가능합니다.");
      return;
   }
   
   $("#itemSeq").val(itemSeq);
   
   $.ajax({
       type:"POST",
       async: false,
       url:"/addToCartProc",
       data:{
          itemSeq:$("#itemSeq").val()
       },
       datatype:"JSON",
       cache:false,
       beforeSend:function(xhr){
          xhr.setRequestHeader("AJAX", "true");
       },
       success:function(res){
          if(res == 200){
             alert("장바구니에 추가되었습니다.");
             location.reload();
          }
          else if(res == 111){
             if(!confirm("해당 상품은 이미 장바구니에 존재합니다. 수량을 추가하시겠습니까?")){
                 return;
             }
             fn_itemNumUpdate();
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
       url:"/itemNumUpdateProc",
       data:{
          itemSeq:$("#itemSeq").val()
       },
       datatype:"JSON",
       cache:false,
       beforeSend:function(xhr){
          xhr.setRequestHeader("AJAX", "true");
       },
       success:function(res){
          if(res == 201){
             alert("수량이 변경되었습니다.");
             location.reload();
          }
          else{
             alert("수량 변경 중 오류가 발생했습니다.");
          }
       },
       error:function(error){
          alert("수량 변경 중 예상치 못한 오류가 발생했습니다.");
       }
   });
}

// //장바구니 이동
// function fn_toCart(){
// 	var user = '${user}';
	
// 	if(user == null || user == ''){
// 		alert("장바구니는 회원만 이용 가능합니다.");
// 		return;
// 	}
	
// 	location.href = "/shop/myCart";   //location.href = window.location.protocol + "//" + window.location.host + "/shop/myCart";
// }


</script>

</head>
<body class="archive post-type-archive post-type-archive-product woocommerce woocommerce-page">

<form id="itemForm" name="itemForm" method="post">
   <input type="hidden" id="itemSeq" name="itemSeq" value="1" /> 
   <input type="hidden" id="sortBy" name="sortBy" value="${sortBy}" /> 
   <input type="hidden" id="curPage" name="curPage" value="${curPage}" />
   <input type="hidden" id="itemCate" name="itemCate" value="${itemCate}"/>
</form>
   <div id="page">
      <div class="container">
         <%@ include file="/WEB-INF/views/include/header.jsp"%>
         <%@ include file="/WEB-INF/views/include/nav.jsp"%>

         
         <!-- #masthead -->
         <div id="content" class="site-content">
            <div id="primary" class="content-area column full">
               <main id="main" class="site-main" role="main">
               
                  <div class="category">
                     <div class="item-cate <c:if test='${itemCate == ""}'>clicked</c:if>" onclick="fn_cate('')">all</div>
                     <div class="item-cate <c:if test='${itemCate == "outer"}'>clicked</c:if>" onclick="fn_cate('outer')">outer</div>
                     <div class="item-cate <c:if test='${itemCate == "top"}'>clicked</c:if>" onclick="fn_cate('top')">top</div>
                     <div class="item-cate <c:if test='${itemCate == "bottom"}'>clicked</c:if>" onclick="fn_cate('bottom')">bottom</div>
                     <div class="item-cate <c:if test='${itemCate == "dress"}'>clicked</c:if>" onclick="fn_cate('dress')">dress</div>
                     <div class="item-cate <c:if test='${itemCate == "acc"}'>clicked</c:if>" onclick="fn_cate('acc')">acc</div>
                  </div>
<c:if test="${itemCate != null and itemCate != ''}">
                  <div style="margin-left:48%;font-size:30px;">${itemCate}</div>
</c:if>
<c:if test="${itemCate == null or itemCate == ''}">
                  <div style="margin-left:48%;font-size:30px;">all</div>
</c:if>
                  
                  
                  <div style="display: flex;justify-content: space-between;align-items: center;margin-bottom:10px;">
                     <p class="woocommerce-result-count">Showing ${paging.startRow}–${paging.endRow} of ${paging.totalCount} results</p>
                     <form class="woocommerce-ordering" method="get">
                        <select id="sortOption" name="sortOption" class="sortOption" onchange="fn_sortBy()">
                           <option value="newness" selected="selected" <c:if test='${sortBy eq "newness"}'>selected</c:if>>newness</option>
                           <option value="popularity" <c:if test='${sortBy eq "popularity"}'>selected</c:if>>popularity</option>
                           <option value="priceAsc" <c:if test='${sortBy eq "priceAsc"}'>selected</c:if>>price: low to high</option>
                           <option value="priceDesc" <c:if test='${sortBy eq "priceDesc"}'>selected</c:if>>price: high to low</option>
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
                        <a onclick="fn_addCart('${item.itemSeq}')" class="button">Add to cart</a>
                     </li>
   </c:if>
   <c:if test="${status.index%4 == 1}">
                     <li class="product">
                        <a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
                           <img src="/resources/upload/${item.fileName}" alt="">
                           <h3>${item.itemName}</h3> 
                           <span class="price"><span class="amount">${item.itemPrice}원</span></span>
                        </a>
                        <a onclick="fn_addCart('${item.itemSeq}')" class="button">Add to cart</a>
                     </li>
   </c:if>
   <c:if test="${status.index%4 == 2}">
                     <li class="product">
                        <a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
                           <img src="/resources/upload/${item.fileName}" alt="">
                           <h3>${item.itemName}</h3> 
                           <span class="price"><span class="amount">${item.itemPrice}원</span></span>
                        </a>
                        <a onclick="fn_addCart('${item.itemSeq}')" class="button">Add to cart</a>
                     </li>
   </c:if>
   <c:if test="${status.index%4 == 3}">
                     <li class="last product">
                        <a onclick="fn_single('${item.itemSeq}')" style="cursor: pointer;"> 
                           <img src="/resources/upload/${item.fileName}" alt="">
                           <h3>${item.itemName}</h3> 
                           <span class="price"><span class="amount">${item.itemPrice}원</span></span>
                        </a>
                        <a onclick="fn_addCart('${item.itemSeq}')" class="button">Add to cart</a>
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
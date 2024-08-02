<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head2.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MONAMI | REVIEW</title>
<link rel='stylesheet' href='/resources/css/woocommerce-layout.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
<link rel='stylesheet' href='/resources/css/woocommerce.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/font-awesome.min.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/style.css' type='text/css' media='all'/>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/easy-responsive-shortcodes.css' type='text/css' media='all'/>


<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>

<style>
   .category {
      display: flex;
      position: reletive;
      justify-content: center;
      align-items: center;
      z-index: 1;
      padding: 10px 0;
/*       border-top: 1px solid; */
/*       border-bottom: 1px solid; */
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
   .products {
      display: flex;
      flex-wrap: wrap;
      justify-content: center; 
      align-items: center;
      list-style-type: none;
      padding: 0;
   }
   .product {
      box-sizing: border-box;
      padding: 10px;
      width: 25%; 
      text-align: center; 
   }
   .product img {
     width: 100%;
     border:gray solid 0.01px;
   }
</style>

<script type="text/javascript">
	$(document).ready(function() {
	   
	});
	
	function fn_view(reBoardSeq)
	{
		document.reBoardForm.reBoardSeq.value = reBoardSeq;
		document.reBoardForm.action = "/reboard/view";
		document.reBoardForm.submit();
	}
</script>

</head>
<body
   class="archive post-type-archive post-type-archive-product woocommerce woocommerce-page">

<form id="reBoardForm" name="reBoardForm">
   <input type="hidden" id="itemSeq" name="itemSeq" value="${itemSeq}" />
   <input type="hidden" id="reBoardSeq" name="reBoardSeq" value="" />
</form>

   <div id="page">
      <div class="container">
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>
         <!-- #masthead -->
         <div id="content" class="site-content">
            <div id="primary" class="content-area column full">
               <main id="main" class="site-main" role="main">
               
                  <div class="category">
                     <div class="item-cate" onclick="fn_cate('')">all</div>
                     <div class="item-cate" onclick="fn_cate('outer')">outer</div>
                     <div class="item-cate" onclick="fn_cate('top')">top</div>
                     <div class="item-cate" onclick="fn_cate('bottom')">bottom</div>
                     <div class="item-cate" onclick="fn_cate('dress')">dress</div>
                     <div class="item-cate" onclick="fn_cate('acc')">acc</div>
                  </div>
				  
				  <div style="text-align:right">
				     <b>totalCount : ${totalCount}</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  </div>
                  <br>
                  
				<div style="text-align:center" >
				<c:choose>
				<c:when test="${!empty list}" >
			    <ul class="products" id="products">
			        <c:forEach var="reBoard" items="${list}" varStatus="status">
			            <li class="product">
			                <a style="text-align:center" onclick="fn_view('${reBoard.reBoardSeq}')" style="cursor: pointer;">
			                <c:choose>
			                    <c:when test="${not empty reBoard.reBoardFileList}">
			                        <img src="/resources/upload/reboardFolder/${reBoard.reBoardFileList.get(0).fileName}" alt="">
			                    </c:when>
			                    <c:otherwise>
			                        <img src="/resources/upload/reboardFolder/default.avif" alt="default">
			                    </c:otherwise>
			                </c:choose>
			                    <h3 style="text-align:left">
			                    <c:choose>
		                            <c:when test="${fn:length(reBoard.reBoardTitle) > 6}">
		                                ${fn:substring(reBoard.reBoardTitle, 0, 6)}...
		                            </c:when>
		                            <c:otherwise>
		                                ${reBoard.reBoardTitle}
		                            </c:otherwise>
		                        </c:choose>
		                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                        ${reBoard.regDate}
			                    </h3>
		                         </a>
		                        <div style="text-align:left">
			                    <c:choose>
		                            <c:when test="${fn:length(reBoard.reBoardContent) > 10}">
		                                ${fn:substring(reBoard.reBoardContent, 0, 10)}...
		                            </c:when>
		                            <c:otherwise>
		                                ${reBoard.reBoardContent}
		                            </c:otherwise>
		                        </c:choose>
		                        </div>
			            </li>
			            <input type="hidden" id="itemSeq2" name="itemSeq2" value="${reBoard.itemSeq}" />
			        </c:forEach>
			    </ul>
			    </c:when>
			    <c:otherwise>
			    <ul class="products" id="products">
			    조회하신 상품의 후기가 존재하지 않습니다.
			    </ul>
			    </c:otherwise>
			    </c:choose>
			    </div>
			    <script>
			        let page = 1;
			        let loading = false;
			
			        async function loadMore() {
			            if (loading) return;
			            loading = true;
			
			            try {
			                const response = await fetch(`/reBoard/loadMore?page=1`);
			                const data = await response.json();
			
			                const products = document.getElementById('products');
			                data.forEach(reBoard => {
			                    const li = document.createElement('li');
			                    li.className = 'product';
			                    li.innerHTML = `
			                        <a onclick="fn_single('${reBoard.reBoardSeq}')" style="cursor: pointer;">
			                            //<img src="/resources/upload/reBoardFolder/" alt="">
			                            <h3>${reBoard.reBoardTitle}</h3>
			                        </a>
			                    `;
			                    products.appendChild(li);
			                });
			
			                page++;
			                loading = false;
			            } catch (error) {
			                console.error('Error loading more data:', error);
			                loading = false;
			            }
			        }
			
			        window.addEventListener('scroll', () => {
			            if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 500) {
			                loadMore();
			            }
			        });
			    </script>
                  
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
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/manager/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/manager/include/navigation.jsp" %>
<div id="wrapper">
	<!-- MAIN -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="container-fluid">
				<h3 class="page-title">상품 등록</h3>
				<!-- INPUTS -->
					<div class="panel">
						<div class="panel-heading"></div>
						<div class="panel-body">
							<a class="page-title">상품명</a><input id="itemName" name="itemName" type="text" class="form-control" placeholder="상품 명">
							<br>
							<a class="page-title">상품코드</a><input id="itemCode" name="itemCode" type="text" class="form-control" placeholder="상품코드">
							<br>
							<a class="page-title">카테고리</a>
							<select id="itemCate" name="itemCate" class="form-control">
								<option value="">선택해주세요.</option>
								<option value="outer">outer</option>
								<option value="top">top</option>
								<option value="bottom">bottom</option>
								<option value="dress">dress</option>
								<option value="acc">acc</option>
							</select>
							<br>	
							<a class="page-title">상품소개</a><textarea id="itemIntro" name="itemIntro"class="form-control" placeholder="소개내용" rows="4"></textarea>
							<br>
							<a class="page-title">가격</a><input id="itemPrice" name="itemPrice" type="text" class="form-control" placeholder="가격">
							<br>
							<a class="page-title">재고</a><input id="stock" name="stock" type="text" class="form-control" placeholder="수량">
							<br>
							<form>
							<a class="page-title">이미지</a><input id="itemDataImangeFile" name="itemDataImangeFile" type="file" class="form-control" placeholder="">
							<br>
							<a id="new"></a>
							</form>
							
							<br>
							<br>
							
							<button id = "productWriteBtn" name = "productWriteBtn" class = "btn btn-primary btn-toastr">등록하기</button>
						
						</div>
						
					</div>
					<!-- END INPUTS -->
				
			</div>
		</div>
		<!-- END MAIN CONTENT -->
	</div>
<!-- END MAIN -->
</div>
</body>


<script type="text/javascript">
<c:if test="${empty stManagerCookie}">
	location.href="/";
</c:if>

$(document).ready(function()
{		
	$("#productWriteBtn").on("click", function()
	{
		
		if($.trim($("#itemName").val()).length <= 0)
		{
			alert("상품명을 입력해주세요.");
			$("#itemName").focus();
			return;
		}
		
		if($.trim($("#itemCode").val()).length <= 0)
		{
			alert("상품코드를 입력해주세요.");
			$("#itemCode").focus();
			return;
		}
		
		if($.trim($("#itemCate").val()).length <= 0)
		{
			alert("카테고리를 선택해주세요.");
			$("#itemCate").focus();
			return;
		}
		
		if($.trim($("#itemIntro").val()).length <= 0)
		{
			alert("상품 소개를 입력하세요.");
			$("#itemIntro").focus();
			return;
		}
		
		if($.trim($("#itemPrice").val()).length <= 0)
		{
			alert("상품 가격을 입력하세요.");
			$("#itemPrice").focus();
			return;
		}
		
		if($.trim($("#stock").val()).length <= 0)
		{
			alert("재고를 입력하세요.");
			$("#stock").focus();
			return;
		}
		
		if(itemDataImangeFile.files.length === 0)
		{
			alert("이미지를 업로드 해 주세요"); 
		    return;
		}
		
		var fileVal = $("#itemDataImangeFile").val();
		
	    if(fileVal != "")
	    {
	        var ext = fileVal.split('.').pop().toLowerCase(); //확장자분리
	        //아래 확장자가 있는지 체크
	        if($.inArray(ext, ['jpg','jpeg','png']) == -1) 
	        {
	        	alert("jpg, jpeg, png 파일만 업로드 할 수 있어요."); 
	        	return;
	        }
	    }
		
		if(confirm("상품을 등록하시겠어요?") == true)
		{
			productWriteAjax();
		}
	});
	

});

function productWriteAjax()
{
	var itemName = $('#itemName').val();
	var itemCode = $('#itemCode').val();
	var itemCate = $('#itemCate').val();
	var itemIntro = $('#itemIntro').val();
	var itemPrice = $('#itemPrice').val();
	var stock = $('#stock').val();
	
	var itemDataImangeFile = $("#itemDataImangeFile")[0].files[0];
	var formData = new FormData();
    formData.append('itemDataImangeFile', itemDataImangeFile);
    formData.append('itemName', itemName);
    formData.append('itemCode', itemCode);
    formData.append('itemCate', itemCate);
    formData.append('itemIntro', itemIntro);
    formData.append('itemPrice', itemPrice);
    formData.append('stock', stock);
    
    
	$.ajax
	({
		type:"POST",
		url:"/manager/managerProductWriteProc",
		data: formData,
		enctype:"multipart/form-data",
		datatype:"JSON",
        contentType: false,
        processData: false,
		befoerSend:function(xhr)
		{
			xhr.setRequestHeader("AJAX", "true");	
		},
		success:function(response)
		{
			if(!icia.common.isEmpty(response))
			{
				icia.common.log(response);
				var code = icia.common.objectValue(response, "code", -500);
				
				if(code == 200)
				{
					alert("상품이 등록되었습니다.");
					location.href = "/manager/productmanagement";	
				}
				else if(code == 410)
				{
					alert("jpg, jpeg, png 파일만 업로드 할 수 있어요.");
					return;
				}
				else
				{
					alert("에러가 발생했습니다. 다시 시도해주세요.");
					return;
				}	
			}
			else
			{
				alert("에러가 발생했습니다. 다시 시도해주세요.");
				return;
			}	
		},
		error:function(xhr, status, error)
		{
			icia.common.error(error);
		}
	});
}


</script>

</html>
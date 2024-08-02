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
				<h3 class="page-title">사용자 정보수정</h3>
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="input-group"></div>
					
						<div class="panel-heading"></div>
							<div class="panel-body">
								<table class="table table-striped">
									<thead>
						            	<tr>
						                	<th scope="row">아이디</th>
						                  	<td>${stUser.userId} <input type="hidden" id="userId" name="userId" value="${stUser.userId}" /></td>
						               	</tr>
					               	</thead>
					               	<tbody>
					               		<tr>
					               			<th scope="row">비밀번호</th>
						                  	<td><input class="form-control" type="password" id="userPwd" name="userPwd" value="${stUser.userPwd}"placeholder="비밀번호" /></td>
						                </tr>
					               	</tbody>
					               	<thead>
						            	<tr>
						                	<th scope="row">이메일</th>
						                  	<td><input class="form-control" type="text" id="userEmail" name="userEmail" value="${stUser.userEmail}"placeholder="이메일" /></td>
						               	</tr>
					               	</thead>
					               	<tbody>
					               		<tr>
					               			<th scope="row">전화번호</th>
						                  	<td><input class="form-control" type="text" id="userTel" name="userTel" value="${stUser.userTel}"placeholder="전화번호" /></td>
						                </tr>
					               	</tbody>
					                <thead>
						            	<tr>
						                	<th scope="row">주소</th>
						                  	<td>${stUser.userAddress}</td>
						               	</tr>
					               	</thead>
					               	<tbody>
					               		<tr>
					               			<th scope="row">포인트</th>
						                  	<td><input class="form-control" type="text" id="userPoint" name="userPoint" value="${stUser.userPoint}" placeholder="포인트" /></td>
						                </tr>
					               	</tbody>					               	
					                <thead>
					               		<tr>
					               			<th scope="row">가입일자</th>
						                  	<td>${stUser.regDate}</td>
						                </tr>
					               	</thead>
					               	<tbody>
					               		<tr>
					               			<th scope="row">상태</th>
						                  	<td>
						                    	<select id="status" name="status" class="form-control">
						                   			<option value="Y" <c:if test='${stUser.status eq "Y"}'> selected </c:if>>정상</option>
						                    		<option value="N" <c:if test='${stUser.status eq "N"}'> selected </c:if>>정지</option>
						                    	</select>
						                  	</td>
						                </tr>
					               	</tbody>
								</table>
								<button id = "userInformationChangeBtn" name = "userInformationChangeBtn" class = "btn btn-primary btn-toastr">변경하기</button>
								<button class = "btn btn-primary btn-toastr" onclick="location.href='/manager/usermanagement'">닫기</button>
							</div>
					</div>
					<!-- END TABLE STRIPED -->
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
	var emailCheck = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	var telCheck = /^\d{3}-\d{3,4}-\d{4}$/;
	var pwdCheck = /^.*(?=^.{8,32}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	
	$("#userInformationChangeBtn").on("click", function() 
	{		
		if(icia.common.isEmpty($("#userPwd").val()))
		{
			alert("비밀번호를 입력하세요.");
			$("#userPwd").focus();
			return;
		}
		
		//정규표현식과 맞지 않으면 
		if(!pwdCheck.test($("#userPwd").val()))
		{
			alert("비밀번호 형식이 올바르지 않아요. 8~32자 및 영문, 숫자, 특수문자를 포함 해주세요.");
			$("#userPwd").focus();
			return;
		}
		
		if(icia.common.isEmpty($("#userEmail").val()))
		{
			alert("이메일을 입력하세요.");
			$("#userEmail").focus();
			return;
		}
		
		//정규표현식과 맞지 않으면 
		if(!emailCheck.test($("#userEmail").val()))
		{
			alert("이메일 형식이 올바르지 않아요. 형식에 맞춰주세요. ex) manager@gmail.com");
			$("#userEmail").focus();
			return;
		}
		
		if(icia.common.isEmpty($("#userTel").val()))
		{
			alert("전화번호를 입력하세요.");
			$("#userTel").focus();
			return;
		}
		
		//정규표현식과 맞지 않으면 
		if(!telCheck.test($("#userTel").val()))
		{
			alert("전화번호 형식이 올바르지 않아요. 형식에 맞춰주세요. ex) 010-1234-5678");
			$("#userTel").focus();
			return;
		}
		
		if(icia.common.isEmpty($("#userPoint").val()))
		{
			alert("포인트를 입력하세요.");
			$("#userPoint").focus();
			return;
		}
		
		if(confirm("회원정보를 수정하시겠어요?") == true)
		{
			userStatusAjax(userId);
		}
	});
	
});


function userStatusAjax(userId)
{
	$.ajax
	({
		type:"POST",
		url:"/manager/userManagementInformationChange",
		data:
		{
			userId:$('#userId').val(),
			userPwd:$('#userPwd').val(),
			userEmail:$('#userEmail').val(),
			userTel:$('#userTel').val(),
			userPoint:$('#userPoint').val(),
			status:$('#status').val(),
			
		},
		datatype:"JSON",
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
					alert("변경이 완료되었습니다.");
					location.href = "/manager/usermanagement";	
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
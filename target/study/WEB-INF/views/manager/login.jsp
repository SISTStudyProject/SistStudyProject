<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/manager/include/head.jsp" %>
</head>
<body>
<!-- WRAPPER -->
<div id="wrapper">
	<div class="vertical-align-wrap">
		<div class="vertical-align-middle">
			<div class="auth-box " style="width: 20%">
				<div class="content">
					<div class="header">
						<p class="lead">Login to your account</p>
					</div>
					<form class="form-auth-small">
						<div class="form-group">
							<label for="signin-email" class="control-label sr-only">아이디</label>
							<input type="email" class="form-control" id="managerId" name="managerId" maxlength="32" placeholder="아이디">
						</div>
						<div class="form-group">
							<label for="signin-password" class="control-label sr-only">비밀번호</label>
							<input type="password" class="form-control" id="managerPwd" name="managerPwd" maxlength="256" placeholder="비밀번호">
						</div>
						<div class="form-group clearfix">
							<p class="input-msg" id="managerMsg"></p>	
						</div>
						<button type="button" id="btnLogin" class="btn btn-primary btn-lg btn-block">로그인</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END WRAPPER -->
</body>

<script type="text/javascript">
$(document).ready(function() 
{
	$("#managerId").on("keypress", function(e)
	{
		if(e.which == 13)
		{
			manager_login();
		}
	});
	
	$("#managerPwd").on("keypress", function(e)
	{
		if(e.which == 13)
		{
			manager_login();
		}
	});
	
	$("#btnLogin").on("click", function()
	{
		manager_login();
	});
});


function manager_login()
{
	if($.trim($("#managerId").val()).length <= 0)
	{
		$("#managerId").val("");
		$("#managerId").focus();
		document.getElementById("managerMsg").innerHTML = "아이디를 입력해주세요.";
		return;
	}
	
	if($.trim($("#managerPwd").val()).length <= 0)
	{
		$("#managerPwd").val("");
		$("#managerPwd").focus();
		document.getElementById("managerMsg").innerHTML = "비밀번호를 입력하세요.";
		return;
	}
	
	$.ajax
	({
		type:"POST",
		url:"/manager/loginProc",
		data:
		{
			managerId:$("#managerId").val(),
			managerPwd:$("#managerPwd").val()
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
					location.href = "/manager/index";	
				}
				else
				{
					$("#managerId").val("");
					$("#managerPwd").val("");
					document.getElementById("managerMsg").innerHTML = "아이디 또는 비밀번호가 일치하지 않습니다.";
					return;
				}	
			}
			else
			{
				$("#managerId").val("");
				$("#managerPwd").val("");
				document.getElementById("managerMsg").innerHTML = "아이디 또는 비밀번호가 일치하지 않습니다.";
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
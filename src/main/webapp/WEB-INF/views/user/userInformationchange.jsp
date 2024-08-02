<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/include/head2.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Monami | shop</title>
<link rel='stylesheet' href='/resources/css/woocommerce-layout.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/woocommerce-smallscreen.css' type='text/css' media='only screen and (max-width: 768px)'/>
<link rel='stylesheet' href='/resources/css/woocommerce.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/font-awesome.min.css' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/style.css' type='text/css' media='all'/>
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700' type='text/css' media='all'/>
<link rel='stylesheet' href='/resources/css/easy-responsive-shortcodes.css' type='text/css' media='all'/>

<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript" src="/resources/js/icia.ajax.js"></script>

<style>
	.div1 
	{
	  width : 100px;
	  height: 100px;
	  background-color: #f5d682;
	  border: 1px solid red;
	}

	.category {
		display: flex;
		position: reletive;
		justify-content: center;
		align-items: center;
		z-index: 1;
		padding: 10px 0;
/* 		border-top: 1px solid; */
/* 		border-bottom: 1px solid; */
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
</style>
</head>
<body class="archive post-type-archive post-type-archive-product woocommerce woocommerce-page">
	<div id="page">
		<div class="container">
		<%@ include file="/WEB-INF/views/include/nav.jsp"%>

		<div id="content" class="site-content">
			<div id="primary" class="content-area column full">
				<main id="main" class="site-main" role="main">
					<h3 style="margin-left:35%;"> MyPage Information Change</h3>					
					<div class="container" style="border-radius: 25px / 25px; border: 1px solid;">
						<br>
						<br>
						<input type="hidden" id="userId" name="userId" value="${stUser.userId}">
						<input type="hidden" id="userPwd" name="userPwd" value="">
						<div style="margin-left: 25%;">
							<h4 style="display:inline;">UserId : ${stUser.userId}</h4>	
						</div>
						<br>
						<br>
						<div style="margin-left: 20%;">
							<h4 style="display:inline;">NewPassword : <input type="password" style="display:inline; width:300px;" id="userPasswordChange" name="userPasswordChange" placeholder="비밀번호를 입력 해 주세요"></h4>	
								<h6 style="margin-left: 5%;"> 비밀번호는 영문+숫자+특수문자 포함 8~32자를 사용해주세요. </h6>
							<h4 style="margin-left: -2%;">PasswordVerify : <input type="password" style="display:inline; width:300px;" id="userPwdVerify" name="userPwdVerify" placeholder="비밀번호를 입력 해 주세요"></h4>	
								<h6 style="margin-left: 5%;"> 비밀번호 확인란을 입력 해주세요. </h6>
						</div>
						<br>
						<div style="margin-left: 22.5%;">
							<h4 style="display:inline;">UserName : <input type="text" style="display:inline; width:300px;" id="userName" name="userName" placeholder="이름을 입력 해 주세요" value="${stUser.userName}"></h4>	
						</div>	
						<br>
						<div style="margin-left: 22.5%;">
							<h4 style="display:inline;">UserEmail : <input type="text" style="display:inline; width:300px;" id="userEmail" name="userEmail" placeholder="이메일을 입력 해 주세요" value="${stUser.userEmail}"></h4>	
								<h6 style="margin-left: 2.5%;"> 이메일은 형식에 맞게 입력해주세요. ex) monami@example.com </h6>
						</div>	
						<br>
						<div style="margin-left: 24.5%;">
							<h4 style="display:inline;">UserTel : <input type="text" style="display:inline; width:300px;" id="userTel" name="userTel" placeholder="전화번호를 입력 해 주세요" value="${stUser.userTel}"></h4>
								<h6 style="margin-left: 2.5%;"> 전화번호는 형식에 맞게 입력해주세요. ex) 010-1234-5678</h6>
						</div>
						<br>
						<div style="margin-left: 19.5%;">
							<h4 style="display:inline;">UserBirthDay : <input type="date" style="display:inline; width:300px;" id="userBirth" name="userBirth"value="${stUser.userBirth}" style="display:inline;"></h4>
								<h6 style="margin-left: 5%;"> 생일은 형식에 맞게 입력해주세요. ex) 1999-09-09</h6>	
						</div>
						<br>
						<div style="margin-left: 19.5%;">
							<h4 style="display:inline;">UserAddress : <input type="text" style="display:inline; width:550px;" id="userAddress" name="userAddress" value="${stUser.userAddress}" placeholder="주소를 입력 해 주세요"></h4>	
						</div>
						<br>
						<br>
						<br>
						<div style="margin-left: 38.5%;">
							<a id="userInformationChangeBtn" name="userImformationChangeBtn" class="button">변경 하기</a>
							<a id="userResignBtn" name="userResignBtn"  class="button">회원탈퇴</a>		
						</div>
						<br>
						<br>						
						<br>
					</div>
					<br>
					<br>
				</main>
			</div>
		</div>
	</div>
		<!-- .container -->
		<footer id="colophon" class="site-footer">
			<div class="container">
				<div class="site-info">
					<h1	style="font-family: 'Herr Von Muellerhoff'; color: #ccc; font-weight: 300; text-align: center; margin-bottom: 0; margin-top: 0; line-height: 1.4; font-size: 46px;">Monami</h1> Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a>
				</div>
			</div>
		</footer>
		<a href="#top" class="smoothup" title="Back to top"><span class="genericon genericon-collapse"></span></a>
	</div>
</body>

<script type="text/javascript">
<c:if test="${empty stUserCookie}">
	location.href="/";
</c:if>

<c:if test="${stUser eq null}">
	alert("잘못된 접근입니다.");
	location.href="/shop/shop";
</c:if>

$(document).ready(function()
{
	var emptyCheck = /\s/g;
	var emailCheck = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
	var telCheck = /^\d{3}-\d{3,4}-\d{4}$/;
	var pwdCheck = /^.*(?=^.{8,32}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	var dateCheck = /^(19[7-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
			
	$("#userInformationChangeBtn").on("click", function() 
	{		
		
		if($.trim($("#userPasswordChange").val()).length <= 0)
		{
			alert("비밀번호를 입력하세요.");
			$("#userPasswordChange").focus();
			return;
		}
		
		if(emptyCheck.test($("#userPasswordChange").val()))
		{
			alert("비밀번호에 공백을 넣을 수 없어요.");
			$("#userPasswordChange").focus();
			return;
		}
		
		//정규표현식과 맞지 않으면 
		if(!pwdCheck.test($("#userPasswordChange").val()))
		{
			alert("비밀번호 형식이 올바르지 않아요. 8~32자 및 영문, 숫자, 특수문자를 포함 해주세요.");
			$("#userPasswordChange").focus();
			return;
		}
		
		if($.trim($("#userPwdVerify").val()).length <= 0)
		{
			alert("비밀번호 확인란을 입력하세요.");
			$("#userPwdVerify").focus();
			return;
		}
		
		if($("#userPasswordChange").val() != $("#userPwdVerify").val())
		{
			alert("비밀번호가 일치하지 않아요.");
			$("#userPwdVerify").focus();
			return;	
		}
		
		$("#userPwd").val($("#userPasswordChange").val());

		//---------------------------------------------------------------
		
		
		if($.trim($("#userName").val()).length <= 0)
		{
			alert("이름을 입력하세요.");
			$("#userName").focus();
			return;
		}
		
		if(emptyCheck.test($("#userName").val()))
		{
			alert("이름에 공백을 넣을 수 없어요.");
			$("#userName").focus();
			return;
		}
		
		//---------------------------------------------------------------
		
		if($.trim($("#userEmail").val()).length <= 0)
		{
			alert("이메일을 입력하세요.");
			$("#userEmail").focus();
			return;
		}
		
		if(emptyCheck.test($("#userEmail").val()))
		{
			alert("이메일에 공백을 넣을 수 없어요.");
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
		
		//---------------------------------------------------------------
		
		if($.trim($("#userTel").val()).length <= 0)
		{
			alert("전화번호를 입력하세요.");
			$("#userTel").focus();
			return;
		}
		
		if(emptyCheck.test($("#userTel").val()))
		{
			alert("전화번호에 공백을 넣을 수 없어요.");
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

		//---------------------------------------------------------------
		
		//정규표현식과 맞지 않으면 
		if(!dateCheck.test($("#userBirth").val()))
		{
			alert("생일 형식이 올바르지 않아요. 형식에 맞춰주세요. ex) 1999-09-09");
			$("#userBirth").focus();
			return;
		}
		
		//---------------------------------------------------------------
		
		if($.trim($("#userAddress").val()).length <= 0)
		{
			alert("주소를 입력하세요.");
			$("#userAddress").focus();
			return;
		}
		
		//---------------------------------------------------------------
		
		if(confirm("회원정보를 수정하시겠어요?") == true)
		{
			userInformationChangeFunction(userId);
		}
	});
	
	$("#userResignBtn").on("click", function() 
	{	
		if(confirm("정말로 회원탈퇴 하시겠어요? 작성된 후기 및 문의내역은 삭제되지 않아요.") == true)
		{
			userResign(userId);
		}
	});
});


function userInformationChangeFunction(userId)
{
	$.ajax
	({
		type:"POST",
		url:"/user/userInformationChangeProc",
		data:
		{
			userId:$('#userId').val(),
			userPwd:$('#userPwd').val(),
			userName:$('#userName').val(),
			userEmail:$('#userEmail').val(),
			userTel:$('#userTel').val(),
			userBirth:$('#userBirth').val(),
			userAddress:$('#userAddress').val()			
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
					location.href = "/user/mypage";	
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

function userResign()
{
	$.ajax
	({
		type:"POST",
		url:"/user/userResign",
		data:
		{
			userId:$('#userId').val()			
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
					alert("회원탈퇴가 완료되었습니다.");
					location.href = "/";
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
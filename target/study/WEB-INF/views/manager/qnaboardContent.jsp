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
				<h3 class="page-title">문의 상세</h3>
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="input-group"></div>
						<input type="hidden" id="qnaBoardSeq" name="qnaBoardSeq" value="${qnaBoard.qnaBoardSeq}">
						<div class="panel-body">
							<c:if test="${!empty qnaBoard.qnaFile}">
				            	<img src="/resources/upload/${qnaBoard.qnaFile.fileName}" alt="" class="img-fluid">
							</c:if>
						</div>
								
							<div class="panel-body">
								<h4>문의 제목 : ${qnaBoard.qnaBoardTitle}</h4>
							</div>
							<div class="panel-body">
								<h5>문의 내용</h5>
								<div class="well">
									<p class="text-left">작성자 : <code>${qnaBoard.userId} </code> </p>
									<br>
									<p class="text-left"><code>${qnaBoard.qnaBoardContent} </code> </p>
									<br>
									<p class="text-right">작성일 : <code>${qnaBoard.regDate} </code> </p>
								</div>
							</div>
							<br>
							<br>
							<br>
							<div class="panel-body">
								<h5>답변 내용</h5>
							<c:choose>
								<c:when test="${!empty qnaBoard.qnaReply}">
									<c:forEach var="qnaReply" items="${qnaBoard.qnaReply}" varStatus="status">
										
										<div class="well">
											<p class="text-left">작성자 : <code>${qnaReply.managerId} </code> </p>
											<br>
											<p class="text-left">답변 내용 : <code>${qnaReply.replyContent} </code> </p>
											<br>
											<p class="text-right">작성일 : <code>${qnaReply.regDate} </code> </p>
											
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
								<div class="well">
										<p class="text-left"><code>등록된 답변이 없습니다.</code> </p>
								</div>
								</c:otherwise>
							</c:choose>
							</div>
							
							<div class="panel-body">
							
								<textarea id="replyContent" name="replyContent"class="form-control" placeholder="답변 글" rows="4"></textarea>
								<br>
								<br>
								
								<button type="button" id ="replyBtn" name="replyBtn"class = "btn btn-primary btn-toastr" >답변 등록</button>
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
	$("#replyBtn").on("click", function()
	{
		if(icia.common.isEmpty($("#replyContent").val()))
		{
			alert("답변을 입력해주세요.");
			$("#replyContent").focus();
			return;
		}
		
		if(confirm("답변을 작성하시겠어요?") == true)
		{
			qnaContentAjax(qnaBoardSeq);
		}
	});
});

function qnaContentAjax(qnaBoardSeq)
{
	$.ajax
	({
		type:"POST",
		url:"/manager/qnaReplyProc",
		data:
		{
			qnaBoardSeq:$('#qnaBoardSeq').val(),
			replyContent:$('#replyContent').val()
			
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
					alert("작성이 완료되었습니다.");
					location.href = location.href;	
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
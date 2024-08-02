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
            <h3 class="page-title">후기 상세</h3>
               <!-- TABLE STRIPED -->
               <div class="panel">
                  <div class="input-group"></div>
                  <input type="hidden" id="reBoardSeq" name="reBoardSeq" value="${reBoard.reBoardSeq}">   
                     <div class="panel-body">
                        <h4>후기 제목 : ${reBoard.reBoardTitle}</h4>
                     </div>
                     
                     <div class="panel-body">
                        <c:if test="${!empty reBoard.reBoardFile}">
                              <img src="/resources/upload/${reBoard.reBoardFile.fileName}" alt="" class="img-fluid">
                        </c:if>
                     </div>
                     <div class="panel-body">
                        <h5>후기 내용</h5>
                        <div class="well">
                           <p class="text-left">작성자 : <code>${reBoard.userId} </code> </p>
                           <br>
                           <p class="text-left"><code>${reBoard.reBoardContent} </code> </p>
                           <br>
                           <p class="text-right">작성일 : <code>${reBoard.regDate} </code> </p>
                           <button type="button" id ="reviewDeleteBtn" name="reviewDeleteBtn" class = "btn btn-primary btn-toastr" >글 삭제</button>
                        </div>
                        <br>
                     </div>
                     <div class="panel-body">
                        <h5>답글 내용</h5>
                     <c:choose>
                        <c:when test="${!empty reBoard.reBoardReplyList}">
                           <c:forEach var="reBoardReplyList" items="${reBoard.reBoardReplyList}" varStatus="status">
                              <c:if test="${reBoardReplyList.status eq 'N'.charAt(0)}">
                                 <c:if test="${reBoardReplyList.replyOrder == 0}">
                                    <div class="well" id="${reBoardReplyList.replySeq}">
                                       <p class="text-left">작성자 : <code>${reBoardReplyList.userId} </code> </p>
                                       <br>
                                       <p class="text-left">댓글 내용 : <code>${reBoardReplyList.replyContent} </code> </p>
                                       <br>
                                       <p class="text-right">작성일 : <code>${reBoardReplyList.regDate} </code> </p>
                                       <button type="button" id ="reviewDeleteBtn" name="reviewDeleteBtn" class = "btn btn-primary btn-toastr" onclick="replyDeleteAjax('${reBoardReplyList.replySeq}')">댓글 삭제</button>
                                    </div>
                                 </c:if>
                                 <c:if test="${reBoardReplyList.replyOrder != 0}">
                                    <div style="margin-left:100px;" class="well" id="${reBoardReplyList.replySeq}">
                                       <p class="text-left">작성자 : <code>${reBoardReplyList.userId} </code> </p>
                                       <br>
                                       <p class="text-left">댓글 내용 : <code>${reBoardReplyList.replyContent} </code> </p>
                                       <br>
                                       <p class="text-right">작성일 : <code>${reBoardReplyList.regDate} </code> </p>
                                       <button type="button" id ="reviewDeleteBtn" name="reviewDeleteBtn" class = "btn btn-primary btn-toastr" onclick="replyDeleteAjax('${reBoardReplyList.replySeq}')" >댓글 삭제</button>
                                    </div>
                                 </c:if>
                              </c:if>   
                              <c:if test="${reBoardReplyList.status eq 'Y'.charAt(0)}">
                                 <c:if test="${reBoardReplyList.replyOrder == 0}">
                                    <div class="well" id="${reBoardReplyList.replySeq}">
                                          <p class="text-left">작성자 : <code>${reBoardReplyList.userId} </code> </p>
                                          <br>
                                          <p class="text-left">댓글 내용 : <code>${reBoardReplyList.replyContent} </code> </p>
                                          <br>
                                          <p class="text-right">작성일 : <code>${reBoardReplyList.regDate} </code> </p>
                                          <br>
                                          <p class="text-left"><code>삭제된 댓글입니다.</code> </p>
                                    
                                    </div>
                                 </c:if>
                                 <c:if test="${reBoardReplyList.replyOrder != 0}">
                                    <div style="margin-left:100px;" class="well" id="${reBoardReplyList.replySeq}">
                                       <p class="text-left">작성자 : <code>${reBoardReplyList.userId}</code> </p>
                                       <br>
                                       <p class="text-left">댓글 내용 : <code>${reBoardReplyList.replyContent} </code> </p>
                                       <br>
                                       <p class="text-right">작성일 : <code>${reBoardReplyList.regDate} </code> </p>
                                       <br>
                                       <p class="text-left"><code>삭제된 대댓글입니다.</code> </p>
                                    </div>
                                 </c:if>

                              </c:if>   
                              
                  
                           </c:forEach>
                        </c:when>
                        <c:otherwise>
                        <div class="well">
                              <p class="text-left"><code>등록된 댓글이 없습니다.</code> </p>
                        </div>
                        </c:otherwise>
                     </c:choose>
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

<c:if test="${reBoard eq null}">
   alert("잘못된 접근입니다.");
   location.href="/manager/reviewmanagement";
</c:if>

$(document).ready(function()
{
   $("#reviewDeleteBtn").on("click", function()
   {
      if(confirm("후기글을 삭제 하시겠어요?") == true)
      {
         reviewDeleteAjax(reBoardSeq);   
      }
   });
   
   
});

function replyDeleteAjax(Seq)
{
   var replyDeleteSeq = Seq;
   
   if(confirm("댓글을 삭제 하시겠어요?") == true)
   {
      $.ajax
      ({
         type:"POST",
         url:"/manager/replyDeleteProc",
         data:
         {
            replySeq:replyDeleteSeq
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
                  alert("삭제가 완료되었습니다.");
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
   
}

function reviewDeleteAjax(reBoardSeq)
{
   $.ajax
   ({
      type:"POST",
      url:"/manager/reviewDeleteProc",
      data:
      {
         reBoardSeq:$('#reBoardSeq').val()
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
               alert("삭제가 완료되었습니다.");
               location.href = "/manager/reviewmanagement";   
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
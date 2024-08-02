<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <%@ include file="/WEB-INF/views/include/head2.jsp"%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MONAMI | review</title>
    <link rel="stylesheet" href="/resources/css/woocommerce-layout.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="/resources/css/woocommerce-smallscreen.css" type="text/css" media="only screen and (max-width: 768px)"/>
    <link rel="stylesheet" href="/resources/css/woocommerce.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="/resources/css/font-awesome.min.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="/resources/style.css" type="text/css" media="all"/>
    <link href="https://fonts.googleapis.com/css?family=Oswald:400,500,700%7CRoboto:400,500,700%7CHerr+Von+Muellerhoff:400,500,700%7CQuattrocento+Sans:400,500,700" rel="stylesheet" type="text/css" media="all"/>
    <link rel="stylesheet" href="/resources/css/easy-responsive-shortcodes.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Custom styles here */
        body {
            height: 100%;
            margin: 0;
            padding: 20px;
            box-sizing: border-box;
            font-size: 13px;
        }
        .container {
            height: 100%;
        }
        table {
        	border-collapse: separate;
        }
        table tr {
		    border-top: 1px solid white; 
		    border-bottom: 1px solid white; 
		}
        textarea {
            resize: none;
        }
        .entry-header {
            display: flex;
            justify-content: space-between;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function fn_list() {
            document.reForm.action ="/reboard/list";
            document.reForm.submit();
        }
        $(document).ready(function(){
            $("#list").on("click", function(){
                document.reForm.action ="/reboard/list";
                document.reForm.submit();
            });
            
            $("#deleteM").on("click", function(){
                if(confirm("글을 삭제하시겠습니까?") == true)
                {
                    $.ajax({
                            type:"POST",
                            url:"/reboard/reboardDelete",
                            data:{
                            	reBoardSeq:$("#reBoardSeq").val()
                            },
                            datatype:"JSON",
                            beforeSend:function(xhr)
                            {
                                xhr.setRequestHeader("AJAX", "true");
                            },
                            success:function(response)
                            {
                                if(response == 0)
                                {
                                    alert("글이 삭제되었습니다.");
                                    document.reForm.action ="/reboard/list";
                                    document.reForm.submit();
                                }
                                else if(response == 404)
                                {
                                    alert("해당 글이 존재하지 않습니다.");
                                }
                                else if(response == 410)
                                {
                                    alert("글 삭제 중 오류가 발생했습니다.");
                                }
                                else
                                {
                                    alert("글 삭제 중 알 수 없는 오류가 발생했습니다.");
                                }
                            },
                            error:function(xhr, status, error)
                            {
                                alert('에러 발생');
                            }
                    });
                }
            });
            
            $("#update").on("click", function(){
                document.reForm.method = "POST";
                document.reForm.action ="/reboard/updateView";
                document.reForm.submit();
            });
            
            $("#delete").on("click", function(){
                if(confirm("글을 삭제하시겠습니까?") == true)
                {
                    $.ajax({
                            type:"POST",
                            url:"/reboard/reboardDelete",
                            data:{
                            	reBoardSeq:$("#reBoardSeq").val()
                            },
                            datatype:"JSON",
                            beforeSend:function(xhr)
                            {
                                xhr.setRequestHeader("AJAX", "true");
                            },
                            success:function(response)
                            {
                                if(response == 0)
                                {
                                    alert("글이 삭제되었습니다.");
                                    document.reForm.action ="/reboard/list";
                                    document.reForm.submit();
                                }
                                else if(response == 404)
                                {
                                    alert("해당 글이 존재하지 않습니다.");
                                }
                                else if(response == 410)
                                {
                                    alert("글 삭제 중 오류가 발생했습니다.");
                                }
                                else
                                {
                                    alert("글 삭제 중 알 수 없는 오류가 발생했습니다.");
                                }
                            },
                            error:function(xhr, status, error)
                            {
                                alert('에러 발생');
                            }
                    });
                }
            });
        });
    </script>
</head>
<body>
<form name="reForm" id="reForm" method="get">
    <input type="hidden" id="itemSeq" name="itemSeq" value="${reboard.itemSeq}" />
    <input type="hidden" id="reBoardSeq" name="reBoardSeq" value="${reboard.reBoardSeq}" />
</form>
    <!-- Main content -->
    <div id="page">
        <div class="container">
                <!-- Navigation menu -->
			<%@ include file="/WEB-INF/views/include/nav.jsp"%>

            <!-- Content area -->
            <div id="content" class="site-content">
                <article id="post-37" class="post-37 page type-page status-publish hentry">
                    <header class="entry-header">
                        <h1 class="entry-title"></h1>
                    </header>

                    <!-- Entry content -->
                    <div class="entry-content">
                        <div id="container">
                            <div id="content" role="main">
                             <br>
                              <h1>&nbsp;&nbsp;&nbsp;${reboard.reBoardTitle}</h1>
                              <div style="text-align:right;">
                                작성자 : ${reboard.userId} &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
                                작성일 : ${reboard.regDate} &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
                                조회수 : ${reboard.reBoardReadCnt}
                              </div>
                              <br>
                                <div itemscope itemtype="http://schema.org/Product" class="product" >
                                    <div class="images" style="text-align:center;">
                                        <c:if test="${!empty reboard.reBoardFileList}">
                                            <table style="text-align:center">
                                                <c:forEach var="file" items="${reboard.reBoardFileList}">
                                                    <th style="text-align:center"><img src="/resources/upload/reboardFolder/${file.fileName}" style="float:center;width:50%; height:50%;"></th>
                                                </c:forEach>
                                            </table>
                                        </c:if>
                                    </div>
                                    <br>
                                    <!-- Review content -->
                                    <p style="color:black; margin:15px;">
                                        &nbsp;&nbsp;&nbsp;${reboard.reBoardContent}
                                    </p>
                                    <div style="text-align:right;">
                                        <c:if test="${cookieUserId eq reboard.userId}">
                                            <input name="submit" type="button" id="delete" class="submit" style="background-color: black; border: 0px; width: 50px;" value="삭제"/>    
                                            <input name="submit" type="button" id="update" class="submit" style="background-color: black; border: 0px; width: 50px;" value="수정"/>
                                        </c:if>
                                        <c:if test="${!empty cookieManagerId}">
                                            <input name="submit" type="button" id="deleteM" class="submit" style="background-color: black; border: 0px; width: 50px;" value="삭제"/>    
                                        </c:if>    
                                        <input name="submit" type="button" id="list" class="submit" style="background-color: black; border: 0px; width: 50px;" value="목록"/>                                                
                                    </div>
                                    <br>
                                    <hr style="border:solid gray 1px;" />
                                    <br>
                                    
                                    <h3>&nbsp;&nbsp;&nbsp;comments</h3>
                                    <div class="container">
                                    <c:if test="${!empty reboard.reBoardReplyList}">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>작성자</th>
                                                    <th>내용</th>
                                                    <th>작성일</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            
											<c:forEach var="reply" items="${reboard.reBoardReplyList}">
											    <tr>
											        <c:if test="${reply.status eq 'N'.charAt(0)}">
											            <td style="padding-left: ${reply.replyOrder > 1 ? '50px;' : '0px;'} color: ${reply.replyOrder > 1 ? 'gray;' : 'black;'} font-size:${reply.replyOrder > 1 ? '10px;' : '14px;'} ">
											                <c:if test="${reply.replyOrder > 1}">ㄴ></c:if>${reply.userId}
											            </td>
											            <td style="padding-left: ${reply.replyOrder > 1 ? '50px;' : '0px;'} color: ${reply.replyOrder > 1 ? 'gray;' : 'black;'} font-size:${reply.replyOrder > 1 ? '10px;' : '14px;'}">${reply.replyContent}</td>
											            <td style="padding-left: ${reply.replyOrder > 1 ? '50px;' : '0px;'} color: ${reply.replyOrder > 1 ? 'gray;' : 'black;'} font-size:${reply.replyOrder > 1 ? '10px;' : '14px;'}">${reply.regDate}</td>
											            <td>
											                <!-- 대댓글 작성 버튼 -->
											                <button type="button" class="btn btn-link reply-button" data-replyseq="${reply.replySeq}" data-replygroup="${reply.replyGroup}" style="background-color: gray; border: none; color: white">
											                    대댓글 작성
											                </button>
											                <c:if test="${cookieUserId eq reply.userId}">
											                    <button type="button" class="btn btn-link delete-reply" data-replyseq="${reply.replySeq}" id="replyD"style="background-color: gray; border: none; color: white">
											                        삭제
											                    </button>
											                    <input type="hidden" id="replySeq" value="${reply.replySeq}" />
											                </c:if>
											            </td>
											        </c:if>
											        <c:if test="${reply.status eq 'Y'.charAt(0)}">
											            <td colspan="4" style="color:gray">사용자 또는 관리자에 의해 삭제된 댓글입니다.</td>
											        </c:if>
											    </tr>
											
											    <!-- 대댓글 입력 폼 -->
											    <tr id="reply2Form-${reply.replySeq}" class="reply-form-row collapse" style="text-align:right;">
											        <td style="text-align:right;">
											            <div class="reply-form" style="text-align:right;">
											                <form id="reReForm-${reply.replySeq}" method="post">
											                    <input type="hidden" name="reBoardSeq" value="${reboard.reBoardSeq}"/>
											                    <input type="hidden" id="replyGroup2" name="replyGroup" value="${reply.replyGroup}"/> 
											                    <input type="hidden" id="replyOrder" name="replyOrder" />
											                    <div class="form-group" style="width:300px;">
											                        <label for="replyContent"></label>
                    												<textarea class="form-control replyContent2" id="replyContent2-${reply.replySeq}" rows="3" placeholder="대댓글을 남겨보세요." required></textarea>
											                    </div>
											                    <div style="text-align:right;">
											                        <button style="background-color:black" type="button" class="btn btn-primary reReBtn" data-replyseq="${reply.replySeq}">작성</button>
											                    </div>
											                </form>
											            </div>
											        </td>
											    </tr>
											</c:forEach>

                                            </tbody>
                                        </table>
                                    </c:if>

                                        <br><br>
                                        <!-- 댓글 입력 폼 -->
                                        <form action="/reboard/insert2" method="post">
                                            <input type="hidden" name="reBoardSeq" value="${reboard.reBoardSeq}"/>
                                            <input type="hidden" name="replyGroup" value="0"/> 
                                            <input type="hidden" name="replyOrder" value="0"/> 
                                            <div class="form-group">
                                                <label for="replyContent"></label>
                                                <textarea class="form-control" id="replyContent" name="replyContent" rows="5" placeholder="댓글을 남겨보세요." required></textarea>
                                            </div>
                                            <div style="text-align:right; ">
                                                <button style="background-color:black" type="submit" class="btn btn-primary" id="replyInsert">작성</button>
                                            </div>
                                        </form>
                                    </div>
    
                                    </div>
                                    <!-- #comments -->
                                </div>
                            </div>
                        </div>
                    </div>
                </article>
            </div>
        </div>
    </div>
        <script type="text/javascript">
        $(document).ready(function() {
        	
            // 대댓글 작성 폼 보이기
            $(document).on("click", ".reply-button", function() {
            	var replySeq = $(this).data("replyseq");
                $("#reply2Form-" + replySeq).toggle();  // 클릭한 댓글의 폼만 보이도록 토글
            });

            // 대댓글 작성
            $(document).on("click", ".reReBtn", function() {
            	var replySeq = $(this).data("replyseq");
            	
            	var replyContent = $("#replyContent2-" + replySeq).val();
                var replyGroup = $(this).closest("tr").prev().find(".reply-button").data("replygroup"); // 대댓글의 replyGroup 값 가져오기
                var form = $("#reReForm-" + replySeq);

                $.ajax({
                    type: "POST",
                    url: "/reboard/reInsert",
                    data: {
                    	reBoardSeq: $("#reBoardSeq").val(),
                    	replyContent2: replyContent,
                        replyGroup: replyGroup
                    },
                    success: function(response) {
                        if (response == 0) {
                            alert("댓글 등록이 완료되었습니다.");
                            document.forms['reForm'].action = "/reboard/view";
                            document.forms['reForm'].submit();
                        } else {
                            alert("댓글 등록에 실패하였습니다.");
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('댓글 작성에 실패했습니다.');
                    }
                });
            });

            // 댓글 삭제
            $(document).on("click", "#replyD", function() {
                if (confirm("댓글을 삭제하시겠습니까?")) {
                    var replySeq = $(this).data("replyseq");

                    $.ajax({
                        type: "POST",
                        url: "/reboard/deleteReply",
                        data: {
                            replySeq: replySeq
                        },
                        success: function(response) {
                            if (response == 0) {
                                alert("댓글이 삭제되었습니다.");
                                document.forms['reForm'].action = "/reboard/view";
                                document.forms['reForm'].submit();
                            } else if (response === 404) {
                                alert("해당 댓글이 존재하지 않습니다.");
                            } else {
                                alert("댓글 삭제 중 오류가 발생했습니다.");
                            }
                        },
                        error: function(xhr, status, error) {
                            alert('에러 발생');
                        }
                    });
                }
            });

            // 댓글 작성
            $("#replyInsert").on("click", function(e) {
                e.preventDefault();  // 기본 폼 제출 방지
                $.ajax({
                    type: "POST",
                    url: "/reboard/insert2",
                    data: {
                        reBoardSeq: $("#reBoardSeq").val(),
                        replyContent: $("#replyContent").val(),
                        replyGroup: $("#replyGroup").val()
                    },
                    success: function(response) {
                        if (response == 0) {
                            alert("댓글 등록이 완료되었습니다.");
                            document.forms['reForm'].action = "/reboard/view";
                            document.forms['reForm'].submit();
                        } else {
                            alert("댓글 등록에 실패하였습니다.");
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('댓글 작성에 실패했습니다.');
                    }
                });
            });


        });
    </script>
    <!-- #page -->
    <!-- Scripts -->
    <script src="/resources/js/jquery.js"></script>
    <script src="/resources/js/plugins.js"></script>
    <script src="/resources/js/scripts.js"></script>
    <script src="/resources/js/accordion.js"></script>
    <script src="/resources/js/tabs.js"></script>
    <script src="/resources/js/toggle.js"></script>
    <script src="/resources/js/masonry.pkgd.min.js"></script>
</body>
</html>

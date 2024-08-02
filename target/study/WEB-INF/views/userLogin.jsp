<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/views/include/head.jsp" %>

<style>
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
.ibm-plex-sans-kr-regular {
  font-family: "IBM Plex Sans KR", sans-serif;
  font-weight: 400;
  font-style: normal;
}
.form-signin {
  max-width: 330px;
  padding: 15px;
  margin: 0 auto;
}
.form-signin .form-signin-heading,
.form-signin .checkbox {
  margin-bottom: 10px;
}
.form-signin .checkbox {
  font-weight: 400;
}
.form-signin .form-control {
  position: relative;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  height: auto;
  padding: 10px;
  font-size: 16px;
}
.form-signin .form-control:focus {
  z-index: 2;
}
.form-signin input[type="text"] {
  margin-bottom: 5px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}
.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
@import url('https://fonts.googleapis.com/css?family=Mukta');
body{
  font-family: 'Mukta', sans-serif;
   height:100vh;
   min-height:550px;
   background-image: url(https://static1.squarespace.com/static/55d344b4e4b0b49feaef5198/55ddfac4e4b0edc068bc3e3e/55ddfb08e4b0e281188cbcec/1440611087009/side-room2.jpg?format=1500w);
   background-repeat: no-repeat;
   background-size:cover;
   background-position:center;
   position:relative;
   padding:40px;
}
a{
  text-decoration:none;
  color:#444444;
}
.login-reg-panel{
    position: relative;
    top: 50%;
    transform: translateY(-50%);
   text-align:center;
    width:90%;
   right:0;left:0;
    margin:auto;
    height:550px;
    background-color: rgba(30,30,30, 0.9);
}
.white-panel{
    background-color: rgba(255,255, 255, 1);
    height:550px;
    position:absolute;
    top:-50px;
    width:50%;
    right:calc(50% - 50px);
    transition:.3s ease-in-out;
    z-index:0;
}
.login-reg-panel input[type="radio"]{
    position:relative;
    display:none;
}
.login-reg-panel{
    color:#B8B8B8;
}
.login-reg-panel #label-login, 
.login-reg-panel #label-register{
    border:1px solid #9E9E9E;
    padding:0 5px;
    width:150px;
    display:block;
    text-align:center;
    border-radius:3px;
    cursor:pointer;
}
.login-info-box{
    width:30%;
    padding:0 50px;
    top:20%;
    left:0;
    position:absolute;
    text-align:left;
}
.register-info-box{
    width:30%;
    padding:0 50px;
    top:20%;
    right:0;
    position:absolute;
    text-align:left;
    
}
.right-log{right:50px !important;}

.login-show, 
.register-show{
    z-index: 1;
    display:none;
    opacity:0;
    transition:0.3s ease-in-out;
    color:#242424;
    text-align:left;
    padding:50px;
}
.show-log-panel{
    display:block;
    opacity:0.9;
}
.login-show input[type="text"], .login-show input[type="password"]{
    width: 100%;
    display: block;
    margin:20px 0;
    padding: 15px;
    border: 1px solid #b5b5b5;
    outline: none;
}
.login-show input[type="button"] {
    max-width: 150px;
    width: 100%;
    background: #444444;
    color: #f9f9f9;
    border: none;
    padding: 10px;
    text-transform: uppercase;
    border-radius: 2px;
    float:right;
    cursor:pointer;
}
.login-show a{
    display:inline-block;
    padding:10px 0;
}

.register-show input[type="text"], .register-show input[type="password"]{
    width: 100%;
    display: block;
    margin:20px 0;
    padding: 15px;
    border: 1px solid #b5b5b5;
    outline: none;
}
.register-show input[type="button"] {
    max-width: 150px;
    width: 100%;
    background: #444444;
    color: #f9f9f9;
    border: none;
    padding: 10px;
    text-transform: uppercase;
    border-radius: 2px;
    float:right;
    cursor:pointer;
}
.credit {
    position:absolute;
    bottom:10px;
    left:10px;
    color: #3B3B25;
    margin: 0;
    padding: 0;
    font-family: Arial,sans-serif;
    text-transform: uppercase;
    font-size: 12px;
    font-weight: bold;
    letter-spacing: 1px;
    z-index: 99;
}

.container{
   width:100%;
   

   
}
.pwdModal{
}
.modalText{
    width: 80%;
    margin:20px 0;
    padding: 15px;
    border: 1px solid #b5b5b5;
    outline: none;
}
#modalContainer {
  width: 100%;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(0, 0, 0, 0.5);
  z-index: 100;
}

#modalContent {
  background-color: #ffffff;
  width: 300px;
  height: 200px;
  padding: 15px;
  z-index: 101;
  border-radius: 0.5rem;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
}
#findPwd {
  text-decoration:none;
  color:#eaeaea;
  cursor: pointer;
}
#findPwd :hover {
   text-color: darkgrey;
}
  
#modalCloseButton{
   padding: 0.5rem 1rem;
     font-weight: 500;
     border: 2px solid #e5e5e5;
     border-radius: 0.25rem;
     background-color: transparent;
}
#modalSubmitBtn{
padding: 0.5rem 1rem;
     font-weight: 500;
     border: 2px solid #e5e5e5;
     border-radius: 0.25rem;
   color: #FFF;
     background-color: #2e44ff;
     border-color: #2e44ff;
} 
.results{
   display:none;
   font-size: 12px;
   color: red;
   margin-left:10%;
   margin-top:-12px;
}
#idResult{
   color:red;
   font-size: 12px;
   margin-top:-12px;
   margin-bottom:-12px;
   display:none;
}


</style>

</head>
<body>
<%-- <%@ include file="/WEB-INF/views/include/navigation.jsp" %>  --%>
<div style="height:100%;display:flex;justify-content: center;">
<div class="container ibm-plex-sans-kr-regular">

   <div class="pwdModal" id="modalContainer">
      <div id="modalContent">
         <div>가입한 아이디, 혹은 이메일을 입력하세요.</div>
          <input type="text" id="userInfo" class="modalText" style="margin-left:10%;">
             <div class="results">
                <div id="SendingS">전송이 완료되었습니다. 메일함을 확인해 주세요</div>
                <div id="SendingE">존재하지 않는 아이디 혹은 메일 주소입니다.</div>
                <div id="SendingF">전송에 실패하였습니다. 관리자에게 문의해 주세요.</div>
             </div>
          <button id="modalCloseButton">닫기</button>
          <input type="button" id="modalSubmitBtn" value="제출"/>
        </div>         
   </div>
   
   <div class="login-reg-panel">
      <div class="login-info-box">
         <h2>Have an account?</h2>
         <p>계정이 있으시다면, 로그인으로 더 많은 혜택을 누리세요.</p>
         <label id="label-register" for="log-reg-show">Login</label>
         <input type="radio" name="active-log-panel" id="log-reg-show"  checked="checked">
      </div>
                     
      <div class="register-info-box">
         <h2>Don't have an account?</h2>
         <p>2분만에 회원가입하고 최대 30% 할인받기.</p>
         <label id="label-login" for="log-login-show">Register</label>
         <input type="radio" name="active-log-panel" id="log-login-show">
      </div>
                     
      <div class="white-panel">
         <div  id="loginForm" class="login-show">
            <h2>LOGIN</h2>
            <form class="form-signin">
            <input type="text" id="userId" name="userId" maxlength="20" placeholder="아이디를 입력">
            <input type="password" id="userPwd" name="userPwd" maxlength="20" placeholder="비밀번호를 입력">
            <input type="button" value="로그인" id="btnLogin" >
            </form>
            <!-- <div id="findPwd">Forgot password?</div> -->
            
         </div>
         <div class="register-show">
            <h2>REGISTER</h2>
            <form id="registerForm">
               <input type="text" id="userId2" name="userId" placeholder="아이디 입력">
               <div id="idResult">
                  <div id="idResult"></div>
               </div>
               <input type="text" id="userName" name="userName"  placeholder="이름 입력">
               <input type="text" id="userEmail" name="userEmail"  placeholder="이메일 입력">
               <input type="password" id="pwd" name="pwd"  placeholder="비밀번호">
               <input type="password" id="pwdCheck" name="pwdCheck"  placeholder="비밀번호 확인">
               <input type="button" id="submitRegiBtn" value="회원가입">
               <input type="hidden" id="userPwd2" name="pwd" value="">
            </form>
         </div>
      </div>
   </div>

   <!-- <form class="form-signin">
       <h2 class="form-signin-heading m-b3">userLogin</h2>
      <label for="userId" class="sr-only">아이디</label>
      <input type="text" id="userId" name="userId" class="form-control" maxlength="20" placeholder="아이디">
      <label for="userPwd" class="sr-only">비밀번호</label>
      <input type="password" id="userPwd" name="userPwd" class="form-control" maxlength="20" placeholder="비밀번호">
        
      <button type="button" id="btnLogin" class="btn btn-lg btn-primary btn-block">로그인</button>
       <button type="button" id="btnReg" class="btn btn-lg btn-primary btn-block">회원가입</button>
   </form> -->
</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
   $('.login-info-box').fadeOut();
    $('.login-show').addClass('show-log-panel');

    $('#modalContainer').hide();
    $("#findPwd").on("click", function() {
      $('#modalContainer').show();
      $('#modalContent').show();
    });
    $("#modalCloseButton").on("click", function() {
      $('#modalContainer').hide();
      $('#modalContent').hide();
    });
    $("#submitRegiBtn").on("click",function(){
       fn_regiCheck();
    });
    $("#userId2").on("keypress", function(e){
      if(e.which == 13){
         fn_regiCheck();
      }
    });
    $("#userId2").on("keyup", function(e){
       if($("#userId2").val().length>4){
          fn_regiCheck();
       }
    });
    $("#userName").on("keypress", function(e){
      if(e.which == 13){
         fn_regiCheck();
      }
    });
    $("#userEmail").on("keypress", function(e){
      if(e.which == 13){
         fn_regiCheck();
      }
    });
    $("#pwd").on("keypress", function(e){
      if(e.which == 13){
         fn_regiCheck();
      }
    });
    $("#pwdCheck").on("keypress", function(e){
      if(e.which == 13){
         fn_regiCheck();
      }
    });
    $("#modalSubmitBtn").on("click",function(){
       if($.trim($("#userInfo").val()).length <= 0){
          alert("아이디 혹은 이메일을 입력해 주세요.");
       }
       else{
          findPwd($.trim($("#userInfo").val()));
       }
    });

   $('.login-reg-panel input[type="radio"]').on('change', function() {
       if($('#log-login-show').is(':checked')) {
           $('.register-info-box').fadeOut(); 
           $('.login-info-box').fadeIn();
           
           $('.white-panel').addClass('right-log');
           $('.register-show').addClass('show-log-panel');
           $('.login-show').removeClass('show-log-panel');
           
       }
       else if($('#log-reg-show').is(':checked')) {
           $('.register-info-box').fadeIn();
           $('.login-info-box').fadeOut();
           
           $('.white-panel').removeClass('right-log');
           
           $('.login-show').addClass('show-log-panel');
           $('.register-show').removeClass('show-log-panel');
       }
   });
   
   $("#userId").focus();
   $("#userId").on("keypress", function(e)
   {
      if(e.which == 13)
      {
         fn_loginCheck();
      }
   });
   
   $("#userPwd").on("keypress", function(e)
   {
      if(e.which == 13)
      {
         fn_loginCheck();
      }
   });
   
   $("#btnLogin").on("click", function()
   {
      fn_loginCheck();
   });
   
   $("#btnReg").on("click", function()
   {
      location.href = "/user/regForm";
   });
});
function register(){
   console.log('회원가입 시작');
   console.log($("#userId2").val()+','+$("#userPwd2").val()+','+$("#userEmail").val()+','+$("#userName").val());
   $.ajax({
      type:"POST",
      url:"/regProc",
      data:{
         userId:$("#userId2").val(),
         userPwd:$("#userPwd2").val(),
         userEmail:$("#userEmail").val(),
         userName:$("#userName").val()
      },
      datatype:"JSON",
      befoerSend:function(xhr){
         xhr.setRequestHeader("AJAX", "true");   
      },
      success:function(response){
         if(!icia.common.isEmpty(response)){
            var code = icia.common.objectValue(response, "code", -500);
            console.log(code);
            if(code == 0){
               alert('회원가입 성공');
               location.reload();
            }
            else if(code == 300){
               alert('이미 존재하는 아이디입니다.');
               $("#userId2").val('');
               $("#userId2").focus();
            }
            else{
               alert("통신 오류");
               console.log(code);
            }
         }
         else{
            alert("오류가 발생했습니다.");
         }
      },
      error:function(xhr, status, error){
         icia.common.error(error);
      }
   });
   
}
function fn_regiCheck(){
    var emtCheck = /\s/g;
    var idCheck = /^[a-zA-Z0-9]{4,12}$/;
    
    if(emtCheck.test($("#userId2").val())){
       alert("아이디는 공백 포함 불가");
       return;
    }
    if(!idCheck.test($("#userId2").val())){
       alert("아이디는 4-12자의 영문, 숫자만 포함 가능");
       $("#userId2").val("");
       return;
    }
    fn_regiCheck1();
    if($("#userName").val().length<1){
       alert('이름을 입력해 주세요');
       $("#userName").focus();
       return;
    }
    var n_RegExp = /^[가-힣]{2,15}$/; //이름
    var e_RegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

    if(!n_RegExp.test($("#userName").val())){
       alert("이름은 한글로 입력해 주세요.");
       $("#userName").val('');
       $("#userName").focus();
       return;
    }
    if($("#userEmail").val().length<1){
       alert('이메일을 입력해 주세요');
       $("#userEmail").focus();
       return;
    }
    if(!e_RegExp.test($("#userEmail").val())){
       alert("메일이 형식에 맞지 않습니다.");
       $("#userEmail").val('');
       $("#userEmail").focus();
       return;
    }
    if($("#pwd").val().length <1){
       alert('비밀번호를 입력해 주세요');
       $("#pwd").focus();
       return;
    }
    if(!idCheck.test($("#pwd").val())){
       alert("비밀번호는 4-12자의 영문, 숫자만 포함 가능");
       $("#pwd").val("");
       return;
    }
    if($("#pwdCheck").val().length<1){
       alert('비밀번호 확인을 입력해 주세요');
       $("#pwdCheck").focus();
       return;
    }
    if($("#pwd").val() != $("#pwdCheck").val()){
       alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
       $("#pwdCheck").val('');
       $("#pwdCheck").focus();
       return;
    }
    
    else if ($("#pwd").val() === $("#pwdCheck").val()){
       console.log('비밀번호와 비밀번호 확인 일치');
       $("#userPwd2").val($("#pwd").val());
       register();
    }
   
}
function fn_regiCheck1(){

      $.ajax({
         type:"POST",
         url:"/idcheck",
         data:{
            userId:$("#userId2").val()
         },
         datatype:"JSON",
         befoerSend:function(xhr){
            xhr.setRequestHeader("AJAX", "true");   
         },
         success:function(response){
            if(!icia.common.isEmpty(response)){
               var code = icia.common.objectValue(response, "code", -500);
               console.log(code);
               if(code == 0){
                  $("#idResult").text('사용 가능한 아이디입니다.').show();
               }
               else if(code == -1){
                  $("#idResult").text('이미 사용중인 아이디입니다.').show();
               }
               else{
                  alert("통신 오류");
               }
            }
            else{
               alert("오류가 발생했습니다.");
            }
         },
         error:function(xhr, status, error){
            icia.common.error(error);
         }
      });
   
}
function fn_loginCheck(){
   if($.trim($("#userId").val()).length <= 0){   
      alert("아이디를 입력하세요.");
      $("#userId").val("");
      $("#userId").focus();
      return;
   }
   
   if($.trim($("#userPwd").val()).length <= 0){   
      alert("비밀번호를 입력하세요.");
      $("#userPwd").val("");
      $("#userPwd").focus();
      return;
   }
   console.log($.trim($("#userId").val()));
   console.log($.trim($("#userPwd").val()));
   $.ajax
   ({
      type:"POST",
      url:"/userLoginProc",
      data:
      {
         userId:$("#userId").val(),
         userPwd:$("#userPwd").val()
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
            
            //code값이 없으면 -500으로 리턴
            var code = icia.common.objectValue(response, "code", -500);
            
            if(code == 0)
            {
               location.href = "/shop/shop";   
            }
            else{
            
               if(code == 404){
                  alert("아이디와 일치하는 사용자 정보가 없습니다.");
                  $("#userId").focus();
               }
               else if(code == 400){
                  alert("파라미터 값이 올바르지 않습니다.");
                  $("#userId").focus();
               }
               else if(code == 403){
                  alert("정지된 사용자 입니다.");
                  $("#userId").focus();
               }
               else if(code == 405){
                  alert("아이디 혹은 비밀번호가 오류.");
                  $("#userId").val('');
                  $("#userPwd").val('');
                  $("#userPwd").focus();
               }
               else{
                  alert("오류가 발생했습니다.");
                  $("#userId").focus();
               }   
            }   
         }
         else{
            //객체가 비어있는 경우
            alert("오류가 발생했습니다.");
            $("#userId").focus();
         }   
      },
      complete:function(data){
         //응답 종료시 실행, 사용빈도수 낮음
         icia.common.log(data);
      },
      error:function(xhr, status, error){
         icia.common.error(error);
      }
   });
}
</script>
</body>
</html>
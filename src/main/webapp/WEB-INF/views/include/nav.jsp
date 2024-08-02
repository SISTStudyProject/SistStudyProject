<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<header id="masthead" class="site-header">
   <div class="site-branding">
      <h1 class="site-title">
         <a href="index" rel="home">Monami</a>
      </h1>
      <h2 class="site-description">By buying our product, you can become a minimalist</h2>
   </div>

<%     
Cookie[] cookies = request.getCookies();
String authCookieValue ="";
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("AUTH_COOKIE_USER".equals(cookie.getName())) {
            authCookieValue = cookie.getValue();
            
        }
    }
}
    if( authCookieValue.length() > 0 && !authCookieValue.equals("null") &&  authCookieValue!= null){
%>



<nav id="site-navigation" class="main-navigation">
   <button class="menu-toggle">Menu</button>
   <a class="skip-link screen-reader-text" href="#content">Skip to content</a>
   <div class="menu-menu-1-container">
      <ul id="menu-menu-1" class="menu">
         <li><a href="/">Home</a></li>
         <li><a href="">About</a></li>
         <li><a href="/shop/shop">Shop</a></li>
         <li><a href="/qna/qnaList">QnA</a></li>
         <li><a href="/reboard/list">Review</a></li>
         <li><a href="/logOut">LogOut</a></li>
         <li><a href="/user/mypage">My Page</a>
            <ul class="sub-menu">
               <li><a href="/user/mypage/informationchange">Information Change</a></li>
               <li><a href="/user/mypage/paymentlist">MyPayment</a></li>
               <li><a href="/user/mypage/reviewlist">Review List</a></li>
               <li><a href="/user/mypage/qnalist">QnaList</a></li>
            </ul>
         </li>
      </ul>
   </div>
</nav>
<%
   }
   else{
%>
<%= authCookieValue %>
<nav id="site-navigation" class="main-navigation">
   <button class="menu-toggle">Menu</button>
   <a class="skip-link screen-reader-text" href="#content">Skip to content</a>
   <div class="menu-menu-1-container">
      <ul id="menu-menu-1" class="menu">
         <li><a href="">Home</a></li>
         <li><a href="">About</a></li>
         <li><a href="/shop/shop">Shop</a></li>
         <li><a href="/qna/qnaList">QnA</a></li>
         <li><a href="/reboard/list">Review</a></li>         
         <li><a href="contact.html">Contact</a></li>
         <li><a href="/userLogin">Sign In/Sign Up</a></li>
      </ul>
   </div>
</nav>

<%
   }
%>

</header>


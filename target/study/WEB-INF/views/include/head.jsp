<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title><spring:eval expression="@env['site.title']" /></title>
<link rel="shortcut icon" href="/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" type="text/css">

<!-- VENDOR CSS -->
<link rel="stylesheet" href="/resources/manager/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/manager/assets/vendor/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/manager/assets/vendor/linearicons/style.css">
<link rel="stylesheet" href="/resources/style.css">
<!-- MAIN CSS -->
<link rel="stylesheet" href="/resources/manager/assets/css/main.css">

<link rel="stylesheet" href="/resources/manager/assets/css/demo.css">

<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">

<link rel="apple-touch-icon" sizes="76x76" href="/resources/manager/assets/img/apple-icon.png">
<link rel="icon" type="image/png" sizes="96x96" href="/resources/manager/assets/img/favicon.png">

<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript" src="/resources/js/icia.ajax.js"></script>

<%    
response.setHeader("Cache-Control","no-store");    
response.setHeader("Pragma","no-cache");    
response.setDateHeader("Expires",0);    
if (request.getProtocol().equals("HTTP/1.1"))  
        response.setHeader("Cache-Control", "no-cache");  
%>
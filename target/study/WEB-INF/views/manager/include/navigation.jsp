<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="wrapper">
<!-- LEFT SIDEBAR -->
	<div id="sidebar-nav" class="sidebar">
		<div class="sidebar-scroll">
			<nav>
				<ul class="nav">
					<li><a class=""> <span>${stManagerCookie} 님</span></a></li>
			
					<li><a href="/manager/index" class=""><i class="lnr lnr-home"></i> <span>Dashboard</span></a></li>
					<li><a href="/manager/usermanagement" class=""><i class="lnr lnr-chart-bars"></i> <span>사용자 관리</span></a></li>
					<li><a href="/manager/productmanagement" class=""><i class="lnr lnr-chart-bars"></i> <span>상품 관리</span></a></li>
					<li><a href="/manager/reviewmanagement" class=""><i class="lnr lnr-chart-bars"></i> <span>후기 관리</span></a></li>
					<li><a href="/manager/qnamanagement" class=""><i class="lnr lnr-chart-bars"></i> <span>QnA 관리</span></a></li>
				</ul>
				<ul class="nav">
					<li><a href="/manager/logout" class=""><i class="lnr lnr-cog"></i> <span>로그아웃</span></a></li>
				</ul>
			</nav>
		</div>
	</div>
<!-- END LEFT SIDEBAR -->
</div>
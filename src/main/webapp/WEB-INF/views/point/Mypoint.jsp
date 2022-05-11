<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>test</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(function(){
	$("#menubar").mouseenter(function(){
		var type = '<%=(String)session.getAttribute("loginType")%>';
		var tag = "<div class='d-grid'>";
		tag +="<div class='row  justify-content-end'>"
			if(type == 'admin'){
				tag += "<a class='nav-link col-2 link-light' id='menubar' href='mypoint'> 포인트 확인</a>";
				tag += "<a class='nav-link col-2 link-light' href='memberlist'>회원 관리</a>";
				tag += "<a class='nav-link col-2 link-light' href='shop/myBasket'>장바구니</a>";
				tag += "<a class='nav-link col-2 link-light' href='shop/myPage'>주문내역</a>";
				tag += "<div class='col-2'></div>";
			}else{
				tag += "<a class='nav-link col-2 link-light' id='menubar' href='mypoint'> 포인트 확인</a>";
				tag += "<a class='nav-link col-2 link-light' href='shop/myBasket'>장바구니</a>";
				tag += "<a class='nav-link col-2 link-light' href='shop/myPage'>주문내역</a>";
				tag += "<div class='col-2'></div>";
			}
		tag += "</div>";
		tag += "</div>";
		$("#sidemenu").html(tag);
		});
	$("#sidemenu").mouseleave(function(){
		$("#sidemenu").html('');
		});
	})
</script>
<style type="text/css">
#alarm{
		background-color: #198754;
		color: white;	
		border : 0;
		outline : 0;
	}
</style>
</head>
<body>
	<div class="container-fluid" style="padding: 0px">
		<nav class="navbar navbar-expand-md navbar-dark bg-success">
			<div class="container justify-content-around">
				<div class="navbar-nav px-2">
					<a class="navbar-brand  d-flex gap-1" href="/pet/">
					<img src="/img/paws.png" style="height:40px;">
					<span class="my-auto">猫の手ch.</span>			
					</a>
				</div>
				<div class="navbar-nav px-3 gap-5">
					<div class="nav-item">
						<a class="nav-link" href="board">게시판</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="info">뉴스</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="shop/shopMain">쇼핑몰</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="map">편의 시설</a>
					</div>
					<div class="nav-item">
						<a class="nav-link active" id="menubar">마이페이지</a>
					</div>
				</div>
				<div class="navbar-nav">
					<div class="nav-item ">
						<c:if test="${loginId == null }">
							<i class="bi bi-key-fill d-inline-block" style="color: white;"></i>
							<a class="nav-link d-inline-block" href="login">Login</a>
						</c:if>
						<c:if test="${loginId != null }">
							<i class="bi bi-door-open-fill" style="color: white"></i>
							<a class="nav-link d-inline-block" href="logout">Logout</a>
							<button id="alarm" type="button" onclick="location.href='alarm'">
                            <i class="bi bi-bell-fill"></i>
                            알림
                            <span class="badge bg-light ms-1 text-dark rounded-pill">${alarmCount }</span>
                        </button>
						</c:if>
					</div>
				</div>
			</div>
		</nav>
		<div id="sidemenu" class="overflow-hidden bg-secondary bg-opacity-50 fw-bold"></div>
		<div class="d-flex mx-3 flex-column justify-content-center" id="wrapper" style="min-height: 100vh;">
			<c:if test="${list == null }">
			
			</c:if>
			
			<div class="d-flex flex-column justify-content-around" style="min-height:50vh;">
				<div class="d-flex justify-content-between my-4 fs-3">
					<div>포인트 이력(10개까지만 표시)</div>
					<div>총 포인트 : ${sum }</div>
				</div>
				<table class="table border">
				<thead>
					<tr>
						<th>날짜</th>
						<th>포인트</th>
						<th>획득 유형</th>
						<th>적립/사용</th>
					</tr>
				</thead>
				<c:if test="${list != null}">
				<c:forEach var="i" items="${list }">
					<tr >
						<td >${i.inputdate }</td>
						<td >${i.getpoint }</td>
						<td> ${i.gettype }</td>
						<td>${i.inputtype }</td>
					</tr>
				</c:forEach>
				<c:if test="${list.size() < 10 }">
					<tr>
						<td rowspan="${10-list.size() }" colspan="4"></td>
					<tr>				
				</c:if>
				</c:if>
				<c:if test="${list == null }"	>
					<tr class="text-center text-bold fs-4">
						<td colspan="4" rowspan="10">${Msg }</td>
					</tr>
				</c:if>
				</table>
				</div>
			
		</div>
		<footer
			id="footer"
			class="footer mt-auto border-top border-2 py-3 text-white bg-dark bg-opacity-25">
			<div class="container-fluid">
				<ul class="nav justify-content-around align-items-center">
					<li class="nav-item">
						<div class="fw-bold">팀명 : 猫の手ch.</div>
						<div class="fw-bold">팀장 : 주지훈</div>
						<div class="fw-bold">조원 : 정어진, 김영현, 최연준</div>
					</li>
					<li class="nav-item">
						<div class="fw-bold">비상연락망</div>
						<div class="fw-bold fs-3">000-0000-0000</div>					
					</li>
					<li class="nav-item"><div class="fw-bold">이 프로젝트를 봐주셔서 감사합니다.</div></li>
				</ul>
			</div>
		</footer>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
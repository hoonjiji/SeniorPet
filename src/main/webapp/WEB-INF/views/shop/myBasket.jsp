<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>myBasket</title>
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
	function deleteCheck(basketnum){
		if(confirm("장바구니 목록에서 해당 상품을 삭제하시겠습니까?")){
			location.href = "/pet/shop/basketDelete?basketnum=" + basketnum;
		}
	}
	$(function(){
		$("#menubar").mouseenter(function(){
			var type = '<%=(String)session.getAttribute("loginType")%>';
			var tag = "<div class='d-grid'>";
			tag +="<div class='row  justify-content-end'>"
			if(type == 'admin'){
				tag += "<a class='nav-link col-2 link-light' id='menubar' href='../mypoint'> 포인트 확인</a>";
				tag += "<a class='nav-link col-2 link-light' href='../memberlist'>회원 관리</a>";
				tag += "<a class='nav-link col-2 link-light' href='myBasket'>장바구니</a>";
				tag += "<a class='nav-link col-2 link-light' href='myPage'>주문내역</a>";
				tag += "<div class='col-2'></div>";
			}else{
				tag += "<a class='nav-link col-2 link-light' id='menubar' href='../mypoint'> 포인트 확인</a>";
				tag += "<a class='nav-link col-2 link-light' href='myBasket'>장바구니</a>";
				tag += "<a class='nav-link col-2 link-light' href='myPage'>주문내역</a>";
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
	tr {text-align: center;}
</style>
</head>
<body>
<header>
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
						<a class="nav-link" href="../board">게시판</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="../info">뉴스</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="shopMain">쇼핑몰</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="../map">편의 시설</a>
					</div>
					<div class="nav-item">
						
						<a class="nav-link active" id="menubar">마이페이지</a>
					</div>
				</div>
				<div class="navbar-nav">
					<div class="nav-item ">
						<c:if test="${loginId == null }">
							<jsp:include page="../modal.jsp"/>
							<i class="bi bi-key-fill d-inline-block" style="color: white;"></i>
							<a class="nav-link d-inline-block" onclick="openModal();">Login</a>
						</c:if>
						<c:if test="${loginId != null }">
							<i class="bi bi-door-open-fill" style="color: white"></i>
							<a class="nav-link d-inline-block" href="../logout">Logout</a>
							<button id="alarm" type="button" onclick="location.href='../alarm'">
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
	</div>
</header>

<div class="d-flex flex-nowrap border border-1" id="wrapper" style="min-height: 90vh;">
<!-- 장바구니 목록 -->
<!-- 관리자도 유저도 모두 사용 가능 -->
<div class="container" style="margin-top: 10px;">
	<c:if test="${not empty loginId}">
		<form action="order" id="order" method="post">
			<table class="table text-center border">
				<thead>
					<tr>
						<td class="fs-2 fw-bold" colspan="2">장바구니</td>
					</tr>
				</thead>
				<tr>
					<th>상품명</th>
					<th>주문 날짜</th>
					<th>주문 수량</th>
					<th>총 주문 금액</th>
					<th>주문 취소</th>
				</tr>
				<c:choose>
				<c:when test="${not empty myBasketList}">
					<c:forEach var="list" items="${myBasketList }">
						<tr>
							<td>${list.pro_name }</td>
							<td>${list.inputdate }</td>
							<td>${list.ordercount }</td>
							<td>${list.orderprice }</td>
							<td><a href="javascript:deleteCheck(${list.basketnum })">취소</a></td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="5" style="text-align: center;">
							<input type="submit" value="주문">
							<!-- 원래라면 주문버튼을 누를 시 결제 api로 이어지도록 해야함 -->
						</td>
					</tr>
				</c:when>
				<c:when test="${empty myBasketList}">
					<tr>
						<td colspan="5" style="text-align: center;"><h6>장바구니에 찜한 상품이 없습니다.</h6></td>
					</tr>
				</c:when>
				</c:choose>
			</table>
		</form>
	</c:if>
</div>
	<c:if test="${empty loginId }">
		<h3>로그인 후에 이용가능합니다.</h3>
	</c:if>	
</div>

<footer id="footer" class="footer mt-auto py-3 text-white bg-dark bg-opacity-25">
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
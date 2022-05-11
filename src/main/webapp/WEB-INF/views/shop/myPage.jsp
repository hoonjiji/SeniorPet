<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>my page</title>
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
	function deleteCheck(ordernum){
		if(confirm("주문을 취소하시겠습니까?")){
			location.href = "/pet/shop/deleteOrder?ordernum=" + ordernum;
		}
	}
	function insertItem(){
		location.href = "/pet/shop/itemStorage";
	}
	function updateItemCheck(shopnum){
		location.href = "/pet/shop/itemUpdate?shopnum=" + shopnum;
	}
	function deleteItemCheck(shopnum){
		if(confirm("등록된 상품을 삭제하시겠습니까?")){
			location.href = "/pet/shop/deleteItem?shopnum=" + shopnum;
		}
	}
	
	function updateStatus(num){
		debugger;
		var ordernum = $("#ordernum"+num).text();
		
		var orderstatus = $("#orderstatus"+ num +" option:selected").val();
		console.log(orderstatus);
		$.ajax({
			url: "updateStatus",
			type: "post",
			dataType: "json",
			traditional: true,
			data: {
				"ordernum" : ordernum,
				"id" : null,
				"ordercount" : 0,
				"orderprice" : 0,
				"pro_id" : 0,
				"pro_name" : null,
				"orderdate" : null,
				"orderstatus" : orderstatus
			},
			success: function(changedOrder){
				console.log(changedOrder);
				alert("상태 변경 성공");
			}/* ,
			error: function(request, status, error){
				console.log(error);
				alert("상태 변경 실패");
			} */
		});
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
	summary{font-size: 25px;}
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
	<!-- 관리자의 경우 주문 상품 목록 표시 -->
		<!-- 상품등록 및 상품 수정, 주문목록 확인 및 상태창 변경(상품준비중, 배송중, 배송완료 등) -->
	<!-- 사용자의 경우 구매한 상품 목록 표시 -->
		<!-- 주문 취소 기능, 상태창은 read only -->
	<div class="container" style="margin-top: 10px;">
		<table class="table text-center border">
			<thead>
				<tr>
					<td class="fs-2 fw-bold" colspan="2">주문 내역</td>
				</tr>
			</thead>
			<tr>
				<th>주문 번호</th>
				<th>상품명</th>
				<th>주문 수량</th>
				<th>총 주문 금액</th>				
				<th>주문 날짜</th>
				<th>주문 상태</th>
				<th>주문 취소</th>
			</tr>
			<c:if test="${empty myOrderList }">
				<tr>
					<td colspan="7">주문한 상품이 없습니다.</td>
				<tr>
			</c:if>
			<c:if test="${not empty myOrderList}">
			<c:forEach var="myOrder" items="${myOrderList }">
				<tr>
					<td>${myOrder.ordernum}</td>
					<td>${myOrder.pro_name}</td>
					<td>${myOrder.ordercount}</td>
					<td>${myOrder.orderprice}</td>
					<td>${myOrder.orderdate}</td>
					<td>${myOrder.orderstatus}</td>
					<td><a href="javascript:deleteCheck(${myOrder.ordernum })">취소</a></td>
				</tr>
			</c:forEach>
			</c:if>
		</table>
	

	<c:if test="${loginType eq 'admin' }">
	<details>
	<summary>관리자 목록</summary>
		<details>
		<summary>주문된 전체 상품 목록</summary>
			<table class="table text-center border">
				<tr>
					<th>주문 번호</th>
					<th>주문자 아이디</th>
					<th>상품명</th>
					<th>주문 수량</th>
					<th>총 주문 금액</th>
					<th>주문 날짜</th>
					<th>상품 상태</th>
				</tr>
				<c:choose>
				<c:when test="${not empty orderList }">
					<c:forEach var="order" items="${orderList }">
						<tr>
							<td id="ordernum${order.ordernum}" name="ordernum${order.ordernum}">${order.ordernum}</td>
							<td>${order.id}</td>
							<td>${order.pro_name}</td>
							<td>${order.ordercount}</td>
							<td>${order.orderprice}</td>
							<td>${order.orderdate}</td>
							<td>
							<select id="orderstatus${order.ordernum}" name="orderstatus" onchange="updateStatus('${order.ordernum}')">
								<option value="">현재상태:${order.orderstatus}</option>
								<option value="상품준비중">상품준비중</option>
								<option value="상품배송중">상품배송중</option>
								<option value="상품도착">상품도착</option>
							</select>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:when test="${empty orderList }">
					<tr>
						<td colspan="7">들어온 주문이 없습니다.</td>
					<tr>
				</c:when>
				</c:choose>
			</table>
		</details>
		<details>
		<summary>입고된 전체 상품 목록</summary>
			<table class="table text-center border">
				<tr>
					<th>상품 번호</th>
					<th>상품명</th>
					<th>가격</th>
					<th>재고</th>
					<th>입고일자</th>
					<th>추천수</th>
					<th>비고</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				<c:choose>
				<c:when test="${empty shopList }">
					<tr>
						<td colspan="9">현재 입고된 상품이 없습니다.</td>
					</tr>
				</c:when>
				<c:when test="${not empty shopList }">
				<c:forEach var="item" items="${shopList }">
					<tr>
						<td>${item.shopnum }</td>
						<td>${item.pro_name }</td>
						<td>${item.price }</td>
						<td>${item.stock }</td>
						<td>${item.inputdate }</td>
						<td>${item.good }</td>
						<td>${item.pro_type }</td>
						<td><a href="javascript:updateItemCheck(${item.shopnum })">수정</a></td>
						<td><a href="javascript:deleteItemCheck(${item.shopnum })">삭제</a></td>
					</tr>
				</c:forEach>
				</c:when>
				</c:choose>
				<button onclick="insertItem()">새 상품 입고</button>
			</table>
		</details>
	</details>
	</c:if>
	</div>
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
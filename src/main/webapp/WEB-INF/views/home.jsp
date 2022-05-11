<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>猫の手ch.</title>
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
			<div class="container justify-content-between">
				<div class="navbar-nav px-2">
					<a class="navbar-brand  d-flex gap-1" href="/pet/">
					<img src="/img/paws.png" style="height:40px;">
					<span class="my-auto">猫の手ch.</span>			
					</a>
				</div>
				<div class="navbar-nav px-3 gap-5">
					<div class="nav-item">
						<a class="nav-link" href="board">Board</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="info">News</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="shop/shopMain">Shopping</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="map">Map</a>
					</div>
					<div class="nav-item">
						
						<a class="nav-link" id="menubar">MyPage</a>
					</div>
				</div>
				<div class="navbar-nav">
					<div class="nav-item ">
						<c:if test="${loginId == null }">
							<jsp:include page="modal.jsp"/>
							<i class="bi bi-key-fill d-inline-block" style="color: white;"></i>
							<a class="nav-link d-inline-block" onclick="openModal();">Login</a>
						</c:if>
						<c:if test="${loginId != null }">
							<i class="bi bi-door-open-fill" style="color: white"></i>
							<a class="nav-link d-inline-block" href="logout">Logout</a>
							<button id="alarm" type="button" onclick="location.href='alarm'">
                            <i class="bi bi-bell-fill"></i>
                           		 Alarm
                            <span class="badge bg-light ms-1 text-dark rounded-pill">${alarmCount }</span>
                        </button>
						</c:if>
					</div>
				</div>
			</div>
		</nav>
		<div id="sidemenu" class="overflow-hidden bg-secondary bg-opacity-50 fw-bold"></div>
		<div class="d-grid container-fluid" id="wrapper"
			style="min-height: 100vh;">
		<div class="row overflow-hidden" style="min-height:60vh;">
			<div class="col-12 p-0 text-center">
				<img alt="" src="/img/Cat - Dog - Hills.jpg" style="height: 31rem; width:90vw;">
			</div>
		</div>
		<div class="row my-4 gap-2 justify-content-around">
			<div class="col-5 border pt-2" style="border-radius:30px;">
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="col-2 text-center">Board</th>
								<th class="text-end"><a class="text-decoration-none" href="board">more +</a></th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${boardlist != null }">
							<c:forEach var="board" items="${boardlist }">
							<tr style="cursor: pointer;" onClick="location.href='read?boardnum=${board.boardnum}'">
								<td class="text-break" colspan="2">${board.title }</td>
							</tr>
							</c:forEach>
						</c:if>
						</tbody>
						
					</table>
			</div>
			<div class="col-5 border pt-2" style="border-radius:30px;">
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="col-2 text-center">News</th>
								<th class="text-end"><a class="text-decoration-none" href="info">more +</a></th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${infolist != null }">
							<c:forEach var="info" items="${infolist }">
							<tr style="cursor: pointer;" onclick="location.href='readinfo?infonum=${info.infonum}'">
								<td class="text-break" colspan="2" >${info.title }</td>
							</tr>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
			</div>
		</div>
		</div>
		<footer
			id="footer"
			class="footer mt-auto py-3 text-white bg-dark bg-opacity-25">
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
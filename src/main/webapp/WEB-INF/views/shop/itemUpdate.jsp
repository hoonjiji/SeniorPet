<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>item update</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- 아이콘 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
<script type="text/javascript">
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
	$(document).ready(function(){
		autosize($("textarea"));
	});
</script>
<style type="text/css">
	#alarm{
		background-color: #198754;
		color: white;	
		border : 0;
		outline : 0;
	}
	#pro_name, textarea {width: 500px;}
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
	<!-- 상품 정보 수정란 -->
	<!-- 관리자 전용 페이지 -->
	<div class="container my-auto">
	<form action="update" id="updateForm" method="post" enctype="multipart/form-data">
		<table class="table text-center border">
			<thead>
				<tr>
					<td class="fs-2 fw-bold" colspan="2">상품 수정</td>
				</tr>
			</thead>
			<tr>
				<th>상품명</th>
				<td>
					<input type="text" id="pro_name" name="pro_name" value="${item.pro_name }" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th>상품 정보</th>
				<td>
					<textarea id="pro_info" name="pro_info" rows="5" cols="22" style="resize:none" required="required">${item.pro_info }</textarea>
				</td>
			</tr>
			<tr>
				<th>상품 이미지</th>
				<td>
					<input type="file" id="upload" name="upload" accept="image/*">
				</td>
			</tr>
			<tr>
				<th>상품 가격</th>
				<td>
					<input type="number" id="price" name="price" value="${item.price }" required="required">
				</td>
			</tr>
			<tr>
				<th>입고 수량</th>
				<td>
					<input type="number" id="stock" name="stock" value="${item.stock }" required="required">
				</td>
			</tr>
			<tr>
				<th>입고 날짜</th>
				<td>
					<input type="date" id="inputdate" name="inputdate" value="${item.inputdate }" required="required">
				</td>
			</tr>
			<tr>
				<th>상품 종류</th>
				<td>
					<select id="pro_type" name="pro_type" required="required">
						<option value="">선택</option>
						<option value="edible">식품의약품</option>	
						<option value="acce">액세서리</option>
						<option value="interior">인테리어</option>
						<option value="others">기타</option>
					</select>
					<input type="hidden" id="shopnum" name="shopnum" value="${item.shopnum }" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><input type="submit" value="수정"></td>
			</tr>
		</table>
	</form>
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
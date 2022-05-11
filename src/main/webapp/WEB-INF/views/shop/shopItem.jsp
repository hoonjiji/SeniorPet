<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>shop item</title>
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
	function pagingFormSubmit(currentPage) {
		var form = document.getElementById("pagingForm");
		var page = document.getElementById("page");
		
		page.value = currentPage;
		form.submit();
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
    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
        -webkit-appearance: none;
    }
    textarea {
    	resize:none;
		border:none;
		overflow: hidden;
		outline: none;
		width: 100%;
		height: auto;
    }
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
						<a class="nav-link active" href="shopMain">쇼핑몰</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="../map">편의 시설</a>
					</div>
					<div class="nav-item">
						
						<a class="nav-link" id="menubar">마이페이지</a>
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

<!-- Navigation-->
<nav class="d-flex justify-content-end my-2">
    <!-- <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="#!">Start Bootstrap</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#!">About</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">All Products</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Popular Items</a></li>
                        <li><a class="dropdown-item" href="#!">New Arrivals</a></li>
                    </ul>
                </li>
            </ul> -->
            <!-- 상품명 검색하기 -->
			<form class="d-flex" id="pagingForm" method="get" action="shopList">
				<input type="hidden" name="page" id="page">
				<input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="searchText" value="${searchText }">
				<button class="btn btn-outline-success" type="button" onclick="pagingFormSubmit(1)">Search</button>
			</form>&nbsp;
            <form class="d-flex" method="get" action="myBasket">
                <button class="btn btn-outline-dark" type="submit">
                    <i class="bi-cart-fill me-1"></i>
                    Cart
                    <span class="badge bg-dark text-white ms-1 rounded-pill">${myBasketTotal }</span>
                </button>
            </form>
        <!-- </div>
    </div> -->
</nav>

<!-- <div class="d-flex flex-nowrap border border-2" id="wrapper" style="height: 1000px"> -->
	<!-- Product section-->
	<section class="py-5">
	    <div class="container px-4 px-lg-5 my-5">
	        <div class="row gx-4 gx-lg-5 align-items-center">
	            <div class="col-md-6"><img class="card-img-top mb-3 mb-md-0" src="/img/${item.pro_image }" alt="..." /></div>
	            <div class="col-md-6">
	                <!-- <div class="small mb-1">SKU: BST-498</div> -->
	                <h1 class="display-5 fw-bolder">${item.pro_name }</h1>
	                <div class="fs-5 mb-5">
	                    <!-- <span class="text-decoration-line-through">$45.00</span> -->
	                    <span>￦${item.price }</span><br>
	                    <span>재고 수량 : ${item.stock }</span>
		                <div class="d-flex small text-warning mb-2">
	                        <div class="bi-star-fill">추천수<span class="text-secondary">(${item.good })</span></div>
	                    </div>
	                </div>
	                <%-- <p class="lead">${item.pro_info }</p> --%>
	                <textarea class="lead" readonly>${item.pro_info }</textarea>
	                <form action="insertBasket" method="post" onsubmit="return stockCheck(${item.stock })">
	                <div class="d-flex">
	                    <input class="form-control text-center me-3" id="inputQuantity" name="ordercount" type="number" placeholder="0" required="required" style="max-width: 3rem" />
	                    <button class="btn btn-outline-dark flex-shrink-0" type="submit">
	                        <i class="bi-cart-fill me-1"></i>
	                        	카트 담기
	                    </button>
	                    <input type="hidden" name="shopnum" value="${item.shopnum }">
	                </div>
	                </form>
	            </div>
	        </div>
	    </div>
	</section>
	
	<!-- Related items section-->
	<section class="py-5 bg-light">
	    <div class="container px-4 px-lg-5 mt-5">
	        <h2 class="fw-bolder mb-4">최근 등록된 상품 목록</h2>
	        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
	            <!-- 반복 부분 -->
             <c:choose>
             <c:when test="${empty shopList }">
             	<h1>준비된 상품이 없습니다</h1>
             </c:when>
             <c:when test="${not empty shopList }">
             <c:forEach var="list" items="${shopList }" begin="0" end="3">
             <div class="col mb-5">
                 <div class="card h-100">
                     <!-- Sale badge-->
                     <!-- <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div> -->
                     <!-- Product image-->
                     <!-- <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /> -->
                     <c:choose>
                     	<c:when test="${empty list.pro_image }">
                     		<img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                     	</c:when>
                     	<c:when test="${not empty list.pro_image }">
                     		<img class="card-img-top" src="/img/${list.pro_image }" alt="..." height="250"/>
                     	</c:when>
                     </c:choose>
                     
                     <!-- Product details-->
                     <div class="card-body p-4">
                         <div class="text-center">
                             <!-- Product name-->
                             <h5 class="fw-bolder">${list.pro_name }</h5>
                             <!-- Product reviews-->
                             <div class="d-flex justify-content-center small text-warning mb-2">
                                 <div class="bi-star-fill">추천수<span class="text-secondary">(${list.good })</span></div>
                             </div>
                             <!-- Product price-->
                             <!-- <span class="text-muted text-decoration-line-through">$20.00</span> -->
                             	￦${list.price }
                         </div>
                     </div>
                     <c:choose>
                     <c:when test="${list.stock eq 0 }">
                     	<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
	                         <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#!">품절</a></div>
	                     </div>
                     </c:when>
                     <c:when test="${list.stock ne 0 }">
	                     <!-- Product actions-->
	                     <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
	                         <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="shopItem?shopnum=${list.shopnum }">상품 보기</a></div>
	                     </div>
                     </c:when>
                     </c:choose>
                 </div>
             </div>
             </c:forEach>
             </c:when>
             </c:choose>
	        </div>
	    </div>
	    <p class="float-end"><a href="#">맨 위로</a></p>
	</section>

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
<script type="text/javascript">
	function stockCheck(itemstock){
		var ordercount = document.getElementById("inputQuantity").value;
		if (ordercount > itemstock){
			console.log(false);
			alert("선택하신 수량이 재고보다 많아 장바구니 등록에 실패하였습니다.");
			return false;
		}
		if (ordercount == 0) {
			alert("상품 수량을 1개 이상 입력해 주세요.");
			return false;
		}
		return true;
	}
</script>
</body>
</html>
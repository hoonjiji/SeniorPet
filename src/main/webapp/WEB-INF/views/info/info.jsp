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
<style type="text/css">
	#navigator a{
		text-decoration : none;
		color : #383434d9;
		border : 1px solid;
		border-color : #f1f1f1;
		padding:0 1vw;
		
	}
	#navigator a:hover{
		background-color: #f1f1f1;
	}
	#alarm{
		background-color: #198754;
		color: white;	
		border : 0;
		outline : 0;
	}
</style>
<script type="text/javascript">
	function pagingFormSubmit(currentPage){
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
						<a class="nav-link active" href="info">뉴스</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="shop/shopMain">쇼핑몰</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" href="map">편의 시설</a>
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
		<div class="container" style="min-height: 100vh; margin-top:4vh; margin-bottom:4vh;">
			<div class="d-flex my-2 justify-content-between align-items-center" style="min-height:15vh;
				margin-top:3vh; margin-bottom:3vh;">
				<div>
				<a class="btn btn-outline-secondary" href="info">전체</a>
				<a class="btn btn-outline-secondary" href="info?type=공지">공지사항</a>
				<a class="btn btn-outline-secondary" href="info?type=정보">정보</a>
				<a class="btn btn-outline-secondary" href="info?type=인기">인기글</a>
				</div>
				<div class="d-flex justify-content-end">
				<a class="btn btn-primary" href="writeinfo"><i class="bi bi-pencil-square"></i> 글 쓰기</a>
				</div>
			</div>
			<div class="container" style="min-height:80vh;">
				<div style="min-height:70vh;">
				<table class="table table-hover border">
					<thead>
						<tr>
							<th class="text-center">게시순서</th>
							<th class="text-center">유형</th>
							<th class="text-center">제목</th>
							<th class="text-center">작성자</th>
							<th class="text-center">작성날짜</th>
							<th class="text-center">추천수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="info" items="${list }" varStatus="status">
							<tr style="cursor: pointer;"
								onClick="location.href='./readinfo?infonum=${info.infonum}'">
								<td class="text-center">${status.count }</td>
								<td class="text-center">${info.type }</td>
								<td class="text-start">${info.title }</td>
								<td class="text-center">${info.id }</td>
								<td class="text-center">${info.inputdate }</td>
								<td class="text-center">${info.good }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</div>
				<div id="navigator" class="mt-auto d-flex justify-content-center">
				<a
					href="javascript:pagingFormSubmit(${navi.currentPage - navi.pagePerGroup})"><i class="bi bi-chevron-double-left"></i></a>
				<a 
					href="javascript:pagingFormSubmit(${navi.currentPage - 1})"><i class="bi bi-chevron-left"></i></a>
				
				<!-- 페이지 수 만큼 반복 -->
				<c:forEach var="counter" begin="${navi.startPageGroup }"
					end="${navi.endPageGroup }">
					
					<a 
					<c:choose>
						<c:when test="${counter == navi.currentPage }">
							style="font-weight: bold; background-color:#f1f1f1;"
						</c:when>
						<c:when test="${counter != navi.currentPage }">
							href="javascript:pagingFormSubmit(${counter})"
						</c:when>
					</c:choose>
					>&nbsp;${counter }&nbsp;</a>
				</c:forEach>
				<a 
					href="javascript:pagingFormSubmit(${navi.currentPage + 1})"><i class="bi bi-chevron-right"></i></a>
				<a 
					href="javascript:pagingFormSubmit(${navi.currentPage + navi.pagePerGroup})"><i class="bi bi-chevron-double-right"></i></a>
			</div>
			</div>
			<div >
			<form class="d-flex justify-content-center" action="info" method="get" id="pagingForm">
					<input type="hidden" name= "page" id="page">
					<input class="form-control me-2" style="width:60%" type="search" name="searchText" placeholder="제목을 입력하세요" value="${searchText}" aria-label="Search" autocomplete="off">
					<input type="hidden" name="type" value="${type }">
					<button class="btn btn-outline-success" type="button" onclick="pagingFormSubmit(1)"><i class="bi bi-search"></i> 검색</button>	
			</form>	
			</div>
		</div>
		<footer
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
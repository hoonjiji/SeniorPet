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
	
	function deleteinfo(infonum,id){
		if(confirm("정말로 삭제하시겠습니까?")){
			location.href = "deleteinfo?infonum="+infonum+"&id="+id;
		}
	}
	function infopreferCheck(id){
		var Msg = document.getElementById("Msg").value;
		var loginId = '<%=(String)session.getAttribute("loginId")%>';
		if(loginId == id){
			alert("본인이 추천할 수 없습니다.");
			return false;
		}
		if(Msg.length<1){
			alert("추천했습니다.");
			return true;
		}
		if(Msg =='미등록'){
			alert("로그인 해주십시오.");
			return false;
		}
		if(Msg == "이미"){
			alert("이미 추천했습니다.");
			return false;
		}
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
		<div class="container">
			<div>
			<div class="d-flex justify-content-between align-items-center" style="height:15vh; margin-top:3vh; margin-bottom:3vh;">
				<div>
					<a class="btn btn-primary" href="writeinfo"><i class="bi bi-pencil-square"></i> 글 쓰기</a>
					<a class="btn btn-primary" href="info"><i class="bi bi-card-list"></i> 목록으로</a>
				</div>
				<div>
					<c:if test="${info.id == loginId  || loginType =='admin'}">
						<a class="btn btn-info text-light" href="updateinfo?infonum=${info.infonum }">수정</a>
						<a class="btn btn-warning text-light" href="javascript: deleteinfo('${info.infonum }','${info.id }')">삭제</a>
					</c:if>
				</div>
				</div>
				<div class="container" style="min-height:80vh; margin-bottom:4vh;">
				<table class="d-grid table overflow-hidden">
						<tr class="row text-center">
							<th class="col-2">유형</th>
							<td class="col-10 ">${info.type }</td>
						</tr>
						<tr class="row text-center">
							<th class="col-2">제목</th>
							<td class="col-10 text-center">${info.title }</td>
						</tr>
						<tr class="row text-center">
							<th class="col-2">작성자</th>
							<td class="col-10 text-center">${info.id }</td>
						</tr>
						<tr class="row text-center">
							<th class="col-2">작성날짜</th>
							<td class="col-10 text-center">${info.inputdate }</td>
						</tr>
						<tr class="row text-center">
							<th class="col-2">추천수</th>
							<td class="col-10 text-center">${info.good }</td>
						</tr>
						<tr class="row px-3">
							<td class="col" colspan="2">${info.content }</td>
						</tr>
				</table>
				<div style="margin-top:5vh; margin-bottom:2vh;">
					<form class="d-grid" action="infoprefer" method="post" onsubmit="return infopreferCheck('${info.id}')" >
					<input type="hidden" id="Msg" value=${infoMsg }>
					<input type="hidden" name="infonum" value=${info.infonum }>
					<input class="col-8 mx-auto btn btn-outline-primary" type="submit" value="추천">
					</form>
				</div>
			</div>
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
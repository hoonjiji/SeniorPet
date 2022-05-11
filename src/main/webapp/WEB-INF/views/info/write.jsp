<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">
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
<!-- CKEditor -->
<script src="resources/ckeditor/ckeditor.js"></script>
<script>
		var ckeditor_config = {
			resize_enabled : true,
			enterMode : CKEDITOR.ENTER_BR,
			shiftEnterMod : CKEDITOR.ENTER_P,
			filebrowserUploadUrl : "ckUpload"
		};
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
		<div class="container" id="wrapper" style="min-height: 100vh; margin-top:4vh; margin-bottom:4vh;">
			<div>
			<form action="writeinfo" method="post" onsubmit="return FormCheck()" class="d-flex flex-column justify-content-around" style="min-height: 90vh;">
				<div class="d-flex flex-column justify-content-around" style="height:20vh;">
				<div class="row">
				<div class="col-1">제목</div>
				<input class="form-control" type="text" name="title" maxlength="30" style="width:90%;">
				</div>
				<div class="row">
				<div class="col-1">종류</div>
					<select class="form-select" name="type" style="width:90%;">
  						<option value="공지">공지사항</option>
  						<option value="정보">정보게시판</option>
					</select>
				</div>
				</div>
				<div class="row">
					<div class="col">
					<textarea id = "description" name ="content" rows="5" cols="80"></textarea>
			
					<script type="text/javascript">
						CKEDITOR.replace("description", ckeditor_config);
					</script>
					</div>
				</div>
				<div class="row justify-content-around" style="margin-top:4vh;">
					<button class="col-5 btn btn-outline-primary" type="submit"><i class="bi bi-pencil-square"></i> 작성하기</button>
					<a class="col-5 btn btn-outline-warning" href="info"><i class="bi bi-card-list"></i> 목록으로</a>
				</div>
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
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
	function FormCheck(){
		var title = $(":input[name='title']");
		if(title.val().length<1){
			alert("제목을 입력해주세요");
			title.focus();
			return false;
		}
		
		if(CKEDITOR.instances.description.getData()==''||CKEDITOR.instances.description.getData().length<1){
			alert("내용을 입력하세요");
			return false;
		}
		return true;
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
</body>
</html>
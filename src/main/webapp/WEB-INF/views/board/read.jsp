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
	function formCheck(loginid){
		if(loginid != ""){
		var content = $("textarea[name='content']").val();
		if(content.length<1){
			alert("내용을 입력해주세요");
			return false;
			}
			return true;
		}
		alert("로그인 해주세요");
		return false;
	}
	function deleteboard(boardnum,id){
		if(confirm("정말로 삭제하시겠습니까?")){
			location.href = "delete?boardnum="+boardnum+"&id="+id;
		}
	}
	function deleteCheck(replynum,boardnum,id){
		if(confirm("정말로 삭제하시겠습니까?")){
			location.href = "deletereply?replynum="+replynum+"&boardnum="+boardnum+"&id="+id;
		}
	}
	function updateForm(replynum,boardnum,id,content){
		var div = document.getElementById('div'+replynum);
		var str = '<form name="updateForm'+replynum + '"action="updatereply" method="post">';
		str+= '<input type="hidden" name="replynum" value="'+replynum+'">'; 
		str+= '<input type="hidden" name="boardnum" value="'+boardnum+'">'; 
		str+= '<input type="hidden" name="id" value="'+id+'">'; 
		str+='<textarea class="col-8 form-control" rows="3" cols="40" name="content" maxlength="150" style="resize:none;">'+content+'</textarea>'
		//폼 자체 전송(document.폼의name)
		str+='<div class="row justify-content-around my-2">'
		str+= '<a class="col-4 my-auto btn btn-outline-primary text-center" href="javascript:updateCheck(document.updateForm'+replynum+')">저장</a>';
		str+= '<a class="col-4 my-auto btn btn-outline-warning text-center" href="javascript:cancelupdate(document.getElementById(\'div'+replynum+'\'))">취소</a>';
		str+='</div>'
		str+= '</form>';
		div.innerHTML = str;
	}
	function cancelupdate(div){
		div.innerHTML = '';
	}
	function updateCheck(form){
		if(confirm('수정하시겠습니까?')){
			var name = form.name;
			var content = $("form[name='"+name+"'] :input[name='content']").val();
			if(content.length<1){
				alert("글을 입력해주세요");
				return false;
			}
			form.submit();
		}
	}
	function boardpreferCheck(id){
		var Msg = document.getElementById("Msg").value;
		var loginId = '<%=(String)session.getAttribute("loginId")%>';
		if(loginId == id){
			alert("본인이 추천할 수는 없습니다.");
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

	function replypreferCheck(id,replynum){
		var Msg = document.getElementById("replyMsg"+replynum).value;
		var loginId = '<%=(String)session.getAttribute("loginId")%>';
		if(loginId == id){
			alert("본인이 추천할 수는 없습니다.");
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
</head>
<body>
	<div class="container-fluid" style="padding: 0px;">
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
						<a class="nav-link active" href="board">게시판</a>
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
		<div class="container" style="min-hegith: 100vh; margin-top:4vh; margin-bottom:4vh;">
			<div>
				<div class="d-flex justify-content-between align-items-center" style="height:15vh; margin-top:3vh; margin-bottom:3vh; ">
					<div>
						<a class="btn btn-primary" href="write"><i class="bi bi-pencil-square"></i> 글 쓰기</a>
						<a class="btn btn-primary" href="board"><i class="bi bi-card-list"></i> 목록으로</a>
					</div>
					<div>
						<c:if test="${board.id == loginId  || loginType =='admin'}">
							<a class="btn btn-info text-light" href="update?boardnum=${board.boardnum }">수정</a>
							<a class="btn btn-warning text-light" href="javascript: deleteboard('${board.boardnum }','${board.id }')">삭제</a>
						</c:if>
					</div>
				</div>
				<div class="container" style="min-height:80vh; margin-bottom:4vh;">
				<table class="d-grid table overflow-hidden">
					<tr class="row text-center">
						<th class="col-2">유형</th>
						<td class="col-10">${board.type }</td>
					</tr>
					<tr class="row text-center">
						<th class="col-2">제목</th>
						<td class="col-10">${board.title }</td>
					</tr>
					<tr class="row text-center">
						<th class="col-2">작성자</th>
						<td class="col-10">${board.id }</td>
					</tr>
					<tr class="row text-center">
						<th class="col-2">작성날짜</th>
						<td class="col-10">${board.inputdate }</td>
					</tr>
					<tr class="row text-center">
						<th class="col-2">추천수</th>
						<td class="col-10">${board.good }</td>
					</tr>
					<tr class="row text-center">
						<th class="col-2">조회수</th>
						<td class="col-10">${board.read }</td>
					</tr>
					<tr class="row px-3"><!-- 이미지 크기 초과시 밑의 글 초반이 짤려서 x축패팅 간격을 줌 -->
						<td class="col" colspan="2">${board.content }</td>
					</tr>
				</table>
				<div style="margin-top:1%; margin-bottom:1%;">
				<form class="d-grid" action="boardprefer" method="post" onsubmit="return boardpreferCheck('${board.id}')" >
					<input type="hidden" id="Msg" value=${boardMsg }>
					<input type="hidden" name="boardnum" value=${board.boardnum }>
					<input class="col-8 mx-auto btn btn-primary" type="submit" value="추천">
				</form>
				</div>	
				<div style="margin-top:2%; margin-bottom:2%">
				<form class="d-flex justify-content-around" action="writereply" method = "post" onsubmit="return formCheck('${loginId}')">
					<span class="my-auto fs-4 text-center">${loginId }</span>
					<input type="hidden" name="id" value="${loginId }">
					<input type="hidden" name="boardnum" value="${board.boardnum }">
					<textarea class="form-control" rows="3" cols="40" name="content" maxlength="60" style="resize:none; width:80%"></textarea>
					<input class="btn btn-outline-primary" type="submit" value="작성하기">
				</form>
				</div>
				<div id="replylist">
					<c:if test="${replylist != null }">
						<div>
						<table class="d-grid table">
							<thead>
								<tr class="row">
									<td class="col-1 text-center">작성</td>
									<td class="col-5 text-center">내용</td>
									<td class="col-2 text-center">날짜</td>
									<td class="col-1 text-center">추천</td>
									<c:if test="${loginId == replylist[i].id || loginType == 'admin'}">
										<td class="col-1"></td>
										<td class="col-1"></td>
									</c:if>
									<td class="col"></td>
								</tr>
							</thead>
						<c:forEach var="i" begin="0" end="${replylist.size() -1}" >
							<tr class= "row">
								<td class="col-1 text-center">${replylist[i].id }</td>
								<td class="col-5">${replylist[i].content }</td>
								<td class="col-2 text-center">${replylist[i].inputdate }</td>
								<td class="col-1 text-center">${replylist[i].good }</td>
								<c:if test="${loginId == replylist[i].id || loginType == 'admin'}">
									<td class="col-1"><a class="my-auto btn btn-outline-primary text-center" href = "javascript:updateForm('${replylist[i].replynum }','${replylist[i].boardnum }','${replylist[i].id }','${replylist[i].content }')">수정</a></td>
									<td class="col-1"><a class="my-auto btn btn-outline-warning text-center"href = "javascript:deleteCheck('${replylist[i].replynum }','${replylist[i].boardnum }','${replylist[i].id }')">삭제</a></td>
								</c:if>
								<td class="col">
									<div class="d-flex justify-content-center">
										<form action = "replyprefer" method="post" onsubmit="return replypreferCheck('${replylist[i].id }','${replylist[i].replynum}')">
											<input type = "hidden" name = "replynum" value="${replylist[i].replynum }">
												<input type = "hidden" name = "boardnum" value="${replylist[i].boardnum }">
											<input type = "hidden" id= "replyMsg${replylist[i].replynum }" value="${Msglist[i] }">
											<input class="btn btn-outline-secondary"type = "submit" value="추천">
										</form>
									</div>	
								</td>
							</tr>
							<tr class="row">
								<c:if test="${loginId == replylist[i].id || loginType == 'admin'}">
									<td colspan="7"><div id="div${replylist[i].replynum}"></div></td>
								</c:if>
							</tr>
						</c:forEach>
						</table>
						</div>
						<div>
							<form action="read" method="get" id="pagingForm">
								<input type="hidden" name="page" id="page">
								<input type="hidden" name="boardnum" value="${board.boardnum }">
							</form>
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
					</c:if>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>주변 시설</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- アイコン -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- 地図 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=xzi1oq2ktw"></script>
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
						<a class="nav-link active" href="./map">Map</a>
					</div>
					<div class="nav-item">
						<a class="nav-link" id="menubar">MyPage</a>
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
                          		 Alarm
                            <span class="badge bg-light ms-1 text-dark rounded-pill">${alarmCount }</span>
                        </button>
						</c:if>
					</div>
				</div>
			</div>
		</nav>
		<div id="sidemenu" class="overflow-hidden bg-secondary bg-opacity-50 fw-bold"></div>
		<div class="container-fluid my-4">
			<div class="mx-auto py-4" style="width: 80%">
				<input type="search" name="searchText" class="form-control" placeholder="病院　検索"
					onkeypress="javascript:if(event.keyCode ==13){search(1)}" autocomplete="off"
				>
				
			</div>
			<div class="container">
			<div class="d-grid my-1">
				<div class="row">
					<button type="button" id="l1" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="강원도">Gangwon-do</button>
					<button type="button" id="l2" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="경기도">Gyeonggi-do</button>
					<button type="button" id="l3" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="경상남도">Gyeongsangnam-do</button>
					<button type="button" id="l4" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="경상북도">Gyeongsangbuk-do</button>
				</div>
			</div>
			<div class="d-grid my-1">
				<div class="row">
					<button type="button" id="l5" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="광주">Gwangju City</button>
					<button type="button" id="l6" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="대구">Daegu City</button>
					<button type="button" id="l7" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="대전">Daejeon City</button>
					<button type="button" id="l8" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="부산">Busan City</button>
				</div>
			</div>
			<div class="d-grid my-1">
				<div class="row">
					<button type="button" id="l9" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="서울">Seoul Capital City</button>
					<button type="button" id="l10" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="세종">Sejong City</button>
					<button type="button" id="l11" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="울산">Ulsan City</button>
					<button type="button" id="l12" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="인천">Incheon City</button>
				</div>
			</div>
			<div class="d-grid my-1">
				<div class="row">
					<button type="button" id="l13" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="전라남도">Jeollanam-do</button>
					<button type="button" id="l14" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="전라북도">Jeollabuk-do</button>
					<button type="button" id="l15" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="제주">Jeju-do</button>
					<button type="button" id="l16" class="col btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="충청남도">Chungcheongnam-do</button>
				</div>
			</div>
			<div class="d-grid my-1">
				<div class="row">
					<button type="button" id="l17" class="col-3 btn btn-outline-primary m-1"
						onclick="show(this.value,1)" value="충청북도">Chungcheongbuk-do</button>
				</div>
			</div>
			</div>
		</div>

		<div id="map" class="mx-auto" style="width: 75%; height: 20rem; margin:2rem;"></div>
		<div class="d-flex flex-column flex-nowrap" style="min-height: 25rem">
			<div id="wrapper" ></div>
			<div id="navi" class="d-flex justify-content-around align-items-end my-3"></div>
		</div>
		<div>
			<footer id="footer"
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
	</div>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	
	function search(page){
		var searchText =$(":input[name=searchText]").val();
		if(searchText.length<1){
			alert("入力してください。");
			return false;
		}
		$.ajax({
			url : "search",
			type : "get",
			data :{
			"searchText" : searchText,
			"page" : page
			},
			dataType:"json",
			success: function(data){
			var Msg = data.Msg;
			var names = [];
			var locate_x = [];
			var locate_y = [];
			if(Msg == 'no'){
				alert("検索結果無し");
				$("#wrapper").html("");
				$("#navi").html("");
				map(names,locate_x,locate_y);
				return;
			}
			var list = data.loc;
			var navi = data.navi
			var page ='';
			var tag ='<table class="table"><thead><tr><th class="text-center" scope="col">番号</th>';
			tag+='<th class="text-center" scope="col">名前</th>';
			tag+='<th class="text-center" scope="col">地名住所</th>';
			tag+='<th class="text-center" scope="col">道路名住所</th>';
			tag+='<th class="text-center" scope="col">電話番号</th>';
			tag+='</tr></thead><tbody>';
			for (var i = 0; i < list.length; i++) {
				tag += '<tr><td scope="row">' + (i + 1) + '</td>';
				tag += '<td class="text-center">' + list[i].name + '</td>';
				if (list[i].ad_locate == null) {
					tag += '<td></td>';
				} else {
					tag += '<td class="text-center">' + list[i].ad_locate + '</td>';
				}
				if (list[i].ad_street == null) {
					tag += '<td></td>';
				} else {
					tag += '<td class="text-center">' + list[i].ad_street + '</td>'
				}
				if (list[i].tel == null) {
					tag += '<td></td>';
				} else {
					tag += '<td class="text-center">' + list[i].tel + '</td></tr>';
				}
				names.push(list[i].name);
				locate_x.push(list[i].loc_x);
				locate_y.push(list[i].loc_y);
			}
			tag+='</tbody>';
			$("#wrapper").html(tag);
			page += "<div id = 'navigator'>";
			page += "<a href = 'javascript:search(&#39;"+(navi.currentPage - navi.pagePerGroup)+"&#39;)'>◁◁</a>";
			page +=	"<a href = 'javascript:search(&#39;"+(navi.currentPage - 1)+"&#39;)'>◀</a>";
			for(var num = navi.startPageGroup; num<=navi.endPageGroup; num++){
				if(num == navi.currentPage){
				    page +=	"<a href='#' style='font-weight: bold; background-color:#f1f1f1;'>"+num+"</a>";
                 } else {
                    page += "<a href='javascript:search(";
                    page += "&#39;"+num+"&#39;";
                    page += ")'>"+num+"</a>";
                 }
			}
			page += "<a href = 'javascript:search(&#39;"+(navi.currentPage +1)+"&#39;)'>▶</a>";
			page += "<a href = 'javascript:search(&#39;"+(navi.currentPage + navi.pagePerGroup)+"&#39;)'>▷▷</a>";
			page += "</div>"
			$("#navi").html(page);
			map(names,locate_x,locate_y);
			}
		});
	}
	function show(value,page) {
		var address = value;
		$.ajax({
			url : "location",
			type : "get",
			data : {
				"address" : address,
				"page" : page
			},
			dataType:"json",
			success : function(data) {
				var list = data.loc;
				var navi = data.navi
				var locate_x = new Array();
				var locate_y = new Array();
				var names = new Array();
				var page ='';
				var tag='<table class="table"><thead><tr><th class="text-center" scope="col">番号</th>';
				tag+='<th class="text-center" scope="col">名前</th>';
				tag+='<th class="text-center" scope="col">地名住所</th>';
				tag+='<th class="text-center" scope="col">道路名住所</th>';
				tag+='<th class="text-center" scope="col">電話番号</th>';
				tag+='</tr></thead><tbody>';
				for (var i = 0; i < list.length; i++) {
					tag += '<tr><td class="text-center" scope="row">' + (i + 1) + '</td>';
					tag += '<td class="text-center">' + list[i].name + '</td>';
					if (list[i].ad_locate == null) {
						tag += '<td></td>';
					} else {
						tag += '<td class="text-center">' + list[i].ad_locate + '</td>';
					}
					if (list[i].ad_street == null) {
						tag += '<td></td>';
					} else {
						tag += '<td class="text-center">' + list[i].ad_street + '</td>'
					}
					if (list[i].tel == null) {
						tag += '<td></td>';
					} else {
						tag += '<td class="text-center">' + list[i].tel + '</td></tr>';
					}
					names.push(list[i].name);
					locate_x.push(list[i].loc_x);
					locate_y.push(list[i].loc_y);
				}
				tag+='</tbody>';
				$("#wrapper").html(tag);
				page += "<div id='navigator'>"
				page += "<a href = 'javascript:show(&#39;"+value+"&#39;,&#39;"+(navi.currentPage - navi.pagePerGroup)+"&#39;)'>◁◁</a>";
				page +=	"<a href = 'javascript:show(&#39;"+value+"&#39;,&#39;"+(navi.currentPage - 1)+"&#39;)'>◀</a>";
				for(var num = navi.startPageGroup; num<=navi.endPageGroup; num++){
					if(num == navi.currentPage){
						page +=	"<a href='#' style='font-weight: bold; background-color:#f1f1f1;'>"+num+"</a>";
	                 } else {
	                    page += "<a href='javascript:show(";
	                    page += "&#39;"+value+"&#39;"+","+"&#39;"+num+"&#39;";
	                    page += ")'>"+num+"</a>";
	                 }
				}
				page += "<a href = 'javascript:show(&#39;"+value+"&#39;,&#39;"+(navi.currentPage +1)+"&#39;)'>▶</a>";
				page += "<a href = 'javascript:show(&#39;"+value+"&#39;,&#39;"+(navi.currentPage + navi.pagePerGroup)+"&#39;)'>▷▷</a>";
				page += "</div>";
				$("#navi").html(page);
				map(names,locate_x,locate_y);
			}
		});
	}

	function map(names,locate_x,locate_y){
		if(names.length <1 || locate_x.length<1 || locate_y.length<1){
			$("#map").hide();
			return;
		}
		$("#map").show();
		var min_x = Math.min.apply(null,locate_x);
		var min_y = Math.min.apply(null,locate_y);
		var max_x = Math.max.apply(null,locate_x);
		var max_y = Math.max.apply(null,locate_y);
		var map = new naver.maps.Map('map', {
		    bounds: naver.maps.LatLngBounds.bounds(new naver.maps.LatLng(min_x-0.01,min_y-0.01),
					new naver.maps.LatLng(max_x+0.03,max_y+0.03)
				    ),
			center : new naver.maps.LatLng((min_x+max_x)/2,(min_y+max_y)/2)
		});
		for(var i=0; i < names.length;i++){
			markerEvent(map,names[i],locate_x[i],locate_y[i]);
		}
	}
	function markerEvent(map,name,x,y){
		var marker = new naver.maps.Marker({
				map : map,
				position : new naver.maps.LatLng(x,y),
				title : name
			});
		var contentString ='<div class="iw_inner"><h5>'+name+'</h5></div>';
		var infowindow = new naver.maps.InfoWindow({
				content : contentString
			});
		naver.maps.Event.addListener(marker,"click",function(e){
			if(infowindow.getMap()){
				infowindow.close();
			}else{
				infowindow.open(map,marker);		
			}
			});
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
</html>
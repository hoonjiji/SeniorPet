<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>shop main</title>
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
<style>
	#alarm{
		background-color: #198754;
		color: white;	
		border : 0;
		outline : 0;
	}
	.bd-placeholder-img {
	  font-size: 1.125rem;
	  text-anchor: middle;
	  -webkit-user-select: none;
	  -moz-user-select: none;
	  user-select: none;
	}
	
	@media (min-width: 768px) {
	  .bd-placeholder-img-lg {
	    font-size: 3.5rem;
	  }
	}
	
	h1 {
		text-shadow:1px 1px 1px #000;
	}
</style>
<!-- Custom styles for this template -->
<link href="../resources/carousel.css" rel="stylesheet">
    
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
  <!-- 슬라이드 버튼 -->
  <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-indicators">
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    
    <div class="carousel-inner">
      <div class="carousel-item active">
        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/>
        <image href="/img/main01.jpg" width="100%" height="100%"/>
        </svg>
        <div class="container">
          <div class="carousel-caption text-start text-light">
            <h1>猫の手.ch 쇼핑몰에 어서오세요!</h1>
            <p style="text-shadow:1px 1px 1px #000;">저희 猫の手.ch 쇼핑몰에서는 시니어펫 집사분들을 환영합니다.</p>
            <p><a class="btn btn-lg btn-outline-primary" href="/pet/shop/shopList">상품목록</a></p>
         </div>
        </div>
      </div>
      
      <div class="carousel-item">
        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/>
        <image href="/img/main03.jpg" width="100%" height="100%"/>
        </svg>
        <div class="container">
          <div class="carousel-caption text-light">
            <h1>세심함이 필요한<br>시니어펫들을 위한 상품</h1>
            <p style="text-shadow:1px 1px 1px #000;">사람도 나이에 따라  건강 관리를 달리 하듯이,<br>시니어펫 또한 달라진 케어가 필요합니다. </p>
            <p><a class="btn btn-lg btn-outline-primary" href="/pet/shop/shopList">상품목록</a></p>
          </div>
        </div>
      </div>
      
      <div class="carousel-item">
        <svg class="bd-placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/>
        <image href="/img/main02.jpg" width="100%" height="100%"/>
        </svg>
        <div class="container">
          <div class="carousel-caption text-end">
            <h1>시니어펫을 위한<br>안성맞춤, 최선의 선택</h1>
            <p style="text-shadow:1px 1px 1px #000;">평생을 함께 한 나의 시니어펫에게<br>가장 필요한 상품을 찾아봅시다.</p>
            <p><a class="btn btn-lg btn-outline-primary" href="/pet/shop/shopList">상품목록</a></p>
          </div>
        </div>
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>


  <!-- Marketing messaging and featurettes
  ================================================== -->
  <!-- Wrap the rest of the page in another container to center all the content. -->

  <div class="container marketing">

    <!-- Three columns of text below the carousel -->
    <div class="row">
      <div class="col-lg-4">
        <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"/><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text>
        <image href="/img/food.jpg" height="140" width="140"/>
        </svg>
        <h2>식품 의약품</h2>
        <p>시니어펫을 위한 건강한 식품들과 당장 아플 때 꼭 필요한 동물약들을 미리 살펴보세요.</p>
        <p><a class="btn btn-secondary" href="/pet/shop/typeItems?pro_type=edible">자세히 &raquo;</a></p>
      </div><!-- /.col-lg-4 -->
      
      <div class="col-lg-4">
        <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"/><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text>
        <image href="/img/healing.png" height="140" width="140"/>
        </svg>
        <h2>보조기 및 악세사리</h2>
        <p>거동이 불편한 시니어펫을 위한 선택. 아이들의 활동성을 보장해주는 상품들이 준비되어 있습니다.</p>
        <p><a class="btn btn-secondary" href="/pet/shop/typeItems?pro_type=acce">자세히 &raquo;</a></p>
      </div><!-- /.col-lg-4 -->
      
      <div class="col-lg-4">
        <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 140x140" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"/><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text>
        <image href="/img/box_cat.jpg" height="140" width="140"/>
        </svg>
        <h2>가구 및 인테리어</h2>
        <p>시니어펫의 윤택하고 편리한 여생을 위해 꼭 필요한 상품들이 모여 있습니다.</p>
        <p><a class="btn btn-secondary" href="/pet/shop/typeItems?pro_type=interior">자세히 &raquo;</a></p>
      </div><!-- /.col-lg-4 -->
    </div><!-- /.row -->


    <!-- START THE FEATURETTES -->

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading">반려동물도 고령화 시대<span class="text-muted"><br>먹는 것 부터 달라져야 합니다.</span></h2><br><br>
        <p class="lead">
        	&nbsp;활동량도 떨어지고 잇몸도 약해지는 시기를 맞이한 시니어펫들에게 꼭 필요한 영양분을 섭취하는 것이 가장 중요합니다. 질병을 예방하는 첫 걸음은 먹는 것을 바꾸는 것으로 시작합니다.<br>
        	&nbsp;그리고 갑자기 아이들이 아픈데 병원에 가기에는 여의치 않을 때를 대비한 동물 전용 약품들도 집안에서 간편하게 구매해 보세요.<br><br>
        	&nbsp;저희 猫の手ch_Mall에서는 시니어 펫들을 위한 사료, 간식, 약품 등을 포함한 다양한 상품들을 소개합니다.
        </p>
      </div>
      <div class="col-md-5">
        <svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#eee"/><text x="50%" y="50%" fill="#aaa" dy=".3em">500x500</text>
        <image href="/img/sub01.jpg" height="500"/>
        </svg>
      </div>
    </div>
	<p class="float-end"><a href="#">맨 위로</a></p>
    <hr class="featurette-divider">
	
    <div class="row featurette">
      <div class="col-md-7 order-md-2">
        <h2 class="featurette-heading">활력이 많이 떨어지는 시기...<span class="text-muted" style="font-size: 46px;"><br>새로운 날개를 달아주세요!</span></h2><br><br>
        <p class="lead">
        	&nbsp;나이가 들면 좋아하던 산책도 힘겨워하는 시니어펫 아이들...<br>
        	&nbsp;포기하지 마세요! 시니어펫 아이들에게 새로운 활동성을 선물하세요. 우리 아이들의 건강한 생활을 지켜주세요.<br><br>
        	&nbsp;저희 猫の手ch_Mall에서는 거동이 불편한 시니어펫들의 건강한 삶을 도와줄 각종 보조기기들을 소개합니다.
        </p>
      </div>
      <div class="col-md-5 order-md-1">
        <svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#eee"/><text x="50%" y="50%" fill="#aaa" dy=".3em">500x500</text>
        <image href="/img/sub02.jpg" height="100%"/>
        </svg>
      </div>
    </div>
	<p class="float-end"><a href="#">맨 위로</a></p>
    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading">시니어펫의 행복한 노후<span class="text-muted"><br>猫の手ch.에서 응원합니다.</span></h2><br><br>
        <p class="lead">
        	&nbsp;나이를 먹고 힘겨워한다고, 나빠진다고 그대로 놔두면 건강은 더욱 악화합니다.<br>
        	&nbsp;앞으로는 달라져야 합니다. 사람이 나이가 들면 달라지듯이 반려동물도 마찬가지입니다. 불편함을 극복할 힘을 아이들에게 선물하세요.<br><br>
        	&nbsp;진정한 '반려'. 아름다운 '동행'.<br>
        	&nbsp;猫の手ch.가 함께 만들어 나가겠습니다.<br>
        </p>
      </div>
      <div class="col-md-5">
        <svg class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 500x500" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#eee"/><text x="50%" y="50%" fill="#aaa" dy=".3em">500x500</text>
        <image href="/img/sub03.png" width="100%" height="100%"/>
        </svg>
      </div>
    </div>
	<p class="float-end"><a href="#">맨 위로</a></p>
    <hr class="featurette-divider">
	
    <!-- /END THE FEATURETTES -->

  </div><!-- /.container -->


  <!-- FOOTER -->
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
<!--   <footer class="container">
    <p class="float-end"><a href="#">Back to top</a></p>
    <p>&copy; 2017–2021 Company, Inc. &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a></p>
  </footer> -->


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

      
  </body>
</html>

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
</head>
<body>
<div class="modal" tabindex="-1" id="modalSignin">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-5 shadow">
      <div class="modal-header p-5 pb-4 border-bottom-0">
        <!-- <h5 class="modal-title">Modal title</h5> -->
        <h2 class="fw-bold mb-0">LOGIN</h2>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body p-5 pt-0">
        <form action="login" method="post" onsubmit="return FormCheck()">
          <div class="form-floating mb-3">
            <input type="text" class="form-control rounded-4" id="floatingInput" name="id" placeholder="ID" autocomplete="off">
            <label for="floatingInput">ID</label>
          </div>
          <div class="form-floating mb-3">
            <input type="password" class="form-control rounded-4" id="floatingPassword" name="pw" placeholder="Password" autocomplete="off">
            <label for="floatingPassword">Password</label>
          </div>
          <button class="w-100 mb-2 btn btn-lg rounded-4 btn-primary" type="submit">LOGIN</button>
          <div id="errorMsg" class="text-danger text-center"></div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
<script type="text/javascript">
	function openModal() {
		$('#modalSignin').modal('toggle');
		$('#errorMsg').text('');
		}
	function FormCheck(){
		if($('#floatingInput').val().length<1){
			$('#errorMsg').text('* 아이디를 입력해주세요');
			return false;
		}
		if($('#floatingPassword').val().length<1){
			$('#errorMsg').text('* 비밀번호를 입력해주세요');
			return false;
		}
	}
</script>
</html>
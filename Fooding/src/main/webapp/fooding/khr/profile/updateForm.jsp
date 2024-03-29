<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 수정</title>
<link rel="icon" href="./fooding/images/fooding_log.png" type="image/x-icon">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		 $('#button1').click(function(){
		 	var phone = $('#phone').val();
		 	var member_id = $('#member_id').val();

		 	$.ajax({
		    	url: "./ProfileDuplicatePhone.pro",
		    	type: 'GET',
		    	contentType: 'text/html',
		        data: {
		        	"phone" : phone,
		        	"member_id" : member_id
		       		},
		        success: function(data){
		        	alert(data);
		        }
			});
		});
		 
		$('#button2').click(function(){
			var userEmail = document.getElementById("email").value;
			var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

			if (!emailPattern.test(userEmail)) {
				alert("올바른 이메일 형식이 아닙니다.");
				return;
			}
			 
			var email = $('#email').val();
		    var member_id = $('#member_id').val();
			
		    $.ajax({
		    	url: "./ProfileDuplicateEmail.pro",
		    	type: 'GET',
		    	contentType: 'text/html', // Content-Type 설정
		    	data: {
		    			"email" : email,
		    			"member_id" : member_id
		    		  },
		    	success: function(data){
		    	alert(data);
		    	}
			});
		}); 
	});
</script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href='https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css'>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lora:wght@500&display=swap" rel="stylesheet">
<link href="./fooding/khr/css/updateForm.css" rel="stylesheet">
</head>

<body>
<c:if test="${empty sessionScope.id }">
	<c:redirect url="./FtMainAction.man" />
</c:if>

<section class="p-3 mb-2 bg-light text-dark">
	<div class="div1">
		<br>
		<h1>Update My Info</h1>
		<br>
		<div id="updateInfo">
		<form action="./ProfileUpdatePro.pro" method="post" name="updateForm" onsubmit="return validPassword2();" class="row g-3">				
			<input type="hidden" name="member_id" value="${requestScope.dto.member_id }" id="member_id">
			<input type="hidden" name="pw" value="${requestScope.dto.pw }">
			<div class="col-md-6">
    			<label for="inputName" class="form-label">아이디<span class="span"> (수정 불가)</span></label>
    			<input type="text" class="form-control" id="inputId" name="id" value=${requestScope.dto.id } readonly>
  			</div>
 			<div class="col-md-6">
    			<label for="inputName" class="form-label">이름<span class="span"> (수정 불가)</span></label>
    			<input type="text" class="form-control" id="inputName" name="name" value=${requestScope.dto.name } readonly>
  			</div>
  			<div class="col-md-6">
    			<label for="inputPassword1" class="form-label">비밀번호<span class="span"> *</span></label>
    			<input type="password" class="form-control" id="pw2" name="pw2" minlength="8" maxlength="15" placeholder="비밀번호 변경 시 입력하세요">
  			</div>
  			<div class="col-md-6">
   				<label for="inputPassword2" class="form-label">비밀번호 확인<span class="span"> *</span></label>
    			<input type="password" class="form-control" id="pw3" name="pw3" minlength="8" maxlength="15" placeholder="한 번 더 입력하세요">
 			</div>
  			<div class="col-md-9">
    			<label for="inputPhone" class="form-label">휴대전화번호<span class="span"> *</span></label>
    			<input type="text" class="form-control" id="phone" name="phone" placeholder="숫자만 입력하세요 (자동으로 - 입력됩니다)" maxlength="13" value=${requestScope.dto.phone } oninput="formatPhoneNumber(this)" required>
  			</div>
  			<div class="col-md-3">
  				<br>
  				&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-success btn" style="display: inline-block; margin-top: 8px;" id="button1">중복확인</button>
  			</div>
  			<div class="col-md-9">
    			<label for="inputEmail" class="form-label">이메일<span class="span"> *</span></label>
    			<input type="email" class="form-control" name="email" id="email" value=${requestScope.dto.email } required>
  			</div>
  			<div class="col-md-3">
  				<br>
  				&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-success btn" style="display: inline-block; margin-top: 8px;" id="button2">중복확인</button>
  			</div>

  			<div class="col-auto mx-auto">
    			<button type="submit" class="btn btn-primary btn-sm">수정하기</button>
    			<button type="button" class="btn btn-secondary btn-sm" onclick="history.back();">돌아가기</button>
  			</div>
			<br>
			<br>
			<br>
			<h1>fooding.</h1>
			<br>
			</form>
  		</div>	
	</div>
</section>
<br>
<script>
function validPassword(){
	const pw2 = document.getElementById("pw2").value;
	const regexA = /[a-zA-Z]/;
	const regexN = /[0-9]/;
	const regexS = /[!@#$%^&*()_+\[\]{};:'",.<>?~\\ ]/;
		
	if(pw2 != ""){
		if(regexA.test(pw2) && regexN.test(pw2) && regexS.test(pw2)){
			if(pw2 == "${requestScope.dto.pw}"){
				alert("바꾸실 비밀번호가 현재 비밀번호와 동일합니다.");
			}
		}else{
			alert("비밀번호는 각각 1개 이상의 영문자, 숫자, 특수문자 (공백 포함)를 포함해야 합니다.");
		}
	}
}
	
function validPassword2(){
	const pw2 = document.getElementById("pw2").value;
	const pw3 = document.getElementById("pw3").value;
		
	const regexA = /[a-zA-Z]/;
	const regexN = /[0-9]/;
		
	const email = document.getElementById("email").value;
	const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
		
	const phone = document.getElementById("phone").value;
	const phoneRegex = /^010-\d{4}-\d{4}$/;
		
	var return1 = false;
	if(emailRegex.test(email)){
		return1 = true;
	}else{
		alert("올바른 이메일 형식이 아닙니다.");
		return1 = false;
	}
		
	var return2 = false;
	if(pw2 != ""){
		if(regexA.test(pw2) && regexN.test(pw2)){
			if(pw2 == pw3){
				if(pw2 == "${requestScope.dto.pw}"){
					alert("바꾸실 비밀번호가 현재 비밀번호와 동일합니다.");
					return2 = false;
				}else{
					return2 = true;
				}
			}else{
				if(pw3 == ""){
					alert("한 번 더 비밀번호 입력을 해주세요.");
					return2 = false;
				}else {
					alert("비밀번호가 일치하지 않습니다.");
					return2 = false;
				}
			}
		}else{
			alert("비밀번호는 각각 1개 이상의 영문자, 숫자를 포함해야 합니다.");
			return2 = false;
		}
	}else{
		if(pw2 == pw3){
			return2 = true;
		}else{
			alert("좌측 비밀번호 입력창에 먼저 입력해주세요.");
			return2 = false;
		}
	}
		
	var return3 = false;
	if(phoneRegex.test(phone)){
		return3 = true;
	}else{
		alert("올바른 전화번호 형식이 아닙니다.");
		return3 = false;
	}
		
	if(return1 == true && return2 == true && return3 == true){
		alert("회원 정보를 수정합니다.");
		return true;
	}else{
		return false;
	}
}
</script>

<script>
  function formatPhoneNumber(input) {
    var inputValue = input.value.replace(/\D/g, '');

    if (inputValue.length >= 3 && !inputValue.startsWith('010')) {
      alert("휴대전화번호는 010으로 시작해야 합니다.");
      input.value = '010';
      return;
    }

    var formattedPhoneNumber = inputValue.replace(/(\d{3})(\d{0,4})(\d{0,4})/, function(match, p1, p2, p3) {
    	var formatted = ['010'];
    	if (p2) formatted.push('-' + p2);
    	if (p3) formatted.push('-' + p3);
		return formatted.join('');
	});

	input.value = formattedPhoneNumber;
}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>	
</body>
</html>
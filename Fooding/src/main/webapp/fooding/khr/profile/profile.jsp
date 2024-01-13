<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="icon" href="./fooding/images/fooding_log.png" type="image/x-icon">
<link href="./fooding/khr/css/profile.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href='https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css'>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script>
  $(document).ready(function() {
    $(window).scroll(function() {
      var scrollTop = $(window).scrollTop();
      $("#moving-element").css("top", scrollTop + "px");
    });
  });
</script>

</head>
<body>
	
<jsp:include page="../inc/top.jsp" />
	
<c:if test="${empty sessionScope.id }">
	<c:redirect url="./FtMainAction.man" />
</c:if>

<div class="row" style="float: left; margin-top: 50px;" id="moving-element">
<div class="col-3" style="width: 250px">
<div class="list-group">
  <a href="./Profile.pro" class="list-group-item list-group-item-action active" aria-current="true">
    마이페이지
  </a>
  <a href="./ProfileMemberInfo.pro" class="list-group-item list-group-item-action">회원정보</a>
  <a href="./OrderDetails.pay" class="list-group-item list-group-item-action">주문내역</a>
  <a href="./ProfileReviewList.pro" class="list-group-item list-group-item-action">리뷰</a>
  <a href="./Support.sup" class="list-group-item list-group-item-action">고객센터</a>
</div>	
</div>
</div>

<section class="p-3 mb-2 bg-light text-dark">
	<div class="div1">
		<br>
		<h1>MY PAGE</h1>
		<br>
		<h2>My Info</h2>
		<br>
		<div id="memberinfo">
		<form class="row g-3">
		<div class="col-md-6">
    		<label for="inputId" class="form-label"><span>아이디</span></label>
    		<input type="text" class="form-control" id="id" value="${requestScope.dto.id }" name="id" readonly>
  		</div>
  		<div class="col-md-6">
   			<label for="inputName" class="form-label"><span>이름</span></label>
    		<input type="text" class="form-control" id="name" value="${requestScope.dto.name }" name="name" readonly>
 		</div>
  		<div class="col-12">
    		<label for="inputPhone" class="form-label"><span>전화번호</span></label>
    		<input type="text" class="form-control" id="inputPhone" name="phone" value=${requestScope.dto.phone } readonly>
  		</div>				
 		<div class="col-12">
    		<label for="inputEmail" class="form-label"><span>이메일</span></label>
    		<input type="email" class="form-control" id="inputEmail" name="email" value=${requestScope.dto.email } readonly>
  		</div>
  		<div class="col-12">
    		<label for="inputRegdate" class="form-label"><span>가입일</span></label>
    		<input type="text" class="form-control" id="inputRegdate" name="regdate" value=${requestScope.dto.regdate } readonly>
  		</div>		
		</form>
		</div>
		<c:if test="${requestScope.count2 > 0 }">
 			<div class="col-auto mx-auto">
 			<br>
    		<h2>foodtruck</h2>
		    <div class="row row-cols-lg-auto g-3 justify-content-center">
		    	<form action="./ProfileFoodtruckPurchaseList.pro" method="post">
    				<input type="hidden" name="member_id" value="${requestScope.member_id }">
    				<button type="submit" class="btn btn-primary btn-sm">푸드트럭 주문 내역</button>
    			</form>
    			<form action="./ProfileFoodtruckList.pro" method="post">
    				<input type="hidden" name="member_id" value="${requestScope.member_id }">
    				<button type="submit" class="btn btn-secondary btn-sm">경로 입력</button>
    			</form>
    			<form action="./ProfileProductAdd.pro" method="post">
    				<input type="hidden" name="member_id" value="${requestScope.member_id }">
    				<button type="submit" class="btn btn-primary btn-sm">상품 추가</button>
    			</form>
    			<form action="./ProfileProductList.pro" method="post">
    				<input type="hidden" name="member_id" value="${requestScope.member_id }">
    				<button type="subtmit" class="btn btn-secondary btn-sm">상품 목록</button>
  				</form>
  			</div>
  			</div>
    	</c:if>
	</div>
	<br>
	<hr>
	<br>
	<h2>Order History</h2>
		<br>
		<c:if test="${requestScope.list == null }">
		<br>
		<h4>주문 내역이 없습니다.</h4>
		</c:if>
		<c:if test="${requestScope.list != null }">
			<table border="1" class="table table-hover">
				<tr>
					<th>주문번호</th>
					<th>대표 상호명</th>
					<th>주문일</th>
					<th>금액</th>
					<th>상세내역</th>
				</tr>
				<c:forEach var="dto" items="${requestScope.list }">
					<tr>
						<td>${dto.purchaseid }</td>
						<td>${dto.foodtruck_name }</td>
						<td>${dto.orderdate }</td>
						<td>${dto.price }원</td>
						<td>
							<form
								action="./OrderDetails.pay?purchaseid=${dto.purchaseid}"
								method="post">
								<input type="hidden" value="${dto.purchaseid}" name="purchaseid">
								<input type="submit" class="btn btn-primary btn-sm" value="주문 확인">
							</form>
						</td>
					</tr>
				</c:forEach>
			</table>

			<nav aria-label="Page navigation example">
  				<ul class="pagination justify-content-center">
  				<c:if test="${requestScope.startPage > requestScope.pageBlock }">
  				  <li class="page-item"><a class="page-link" href="./Profile.pro?pageNum=${requestScope.startPage - requestScope.pageBlock }#list">이전</a></li>
				</c:if>
    			<c:forEach var="i" begin="${requestScope.startPage }" end="${requestScope.endPage }" step="1">
    			  <li class="page-item"><a class="page-link" href="./Profile.pro?pageNum=${i }#list">${i }</a></li>
				</c:forEach>
				<c:if test="${requestScope.endPage < requestScope.pageCount }">
    			  <li class="page-item"><a class="page-link" href="./Profile.pro?pageNum=${requestScope.startPage + requestScope.pageBlock }#list">다음</a></li>
				</c:if>		
  				</ul>
			</nav>
			</c:if>
	
			<br>		
			<hr>
			<br>
			<h2>Update & Delete</h2>
			<br>
			<div class="row row-cols-lg-auto g-3 justify-content-center">
 				<div class="col-md-6">
    				<input type="password" class="form-control" name="pw" id="pw" placeholder="현재 비밀번호를 입력하세요">
  				</div>
				<button type="button" class="btn btn-primary" onclick="password1();">정보 수정</button>&nbsp;
				<form action="./ProfileDelete.pro" method="post" onsubmit="return password2();">
				<input type="hidden" name="member_id" value="${dto.member_id }">
				<button type="submit" class="btn btn-secondary">회원 탈퇴</button>
				</form>
			</div>
			<br>
			<br>
			<h1>fooding.</h1>
	</section>
	<br>

	<script>
	function password1(){
		if(document.getElementById("pw").value == ""){
			alert("비밀번호를 입력해주세요.");
		}
		else if(document.getElementById("pw").value == "${requestScope.dto.pw }"){
			alert("회원 정보 수정 페이지로 이동합니다.");
			location.href="./ProfileUpdate.pro";
		}else{
			alert("비밀번호가 일치하지 않습니다.");
		}
	}

	function password2(){
		if(document.getElementById("pw").value == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		else if(document.getElementById("pw").value == "${requestScope.dto.pw }"){
			alert("회원 탈퇴 페이지로 이동합니다.");
			return true;
		}else{
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
	}
	
	function password3(){
		if(document.getElementById("pw").value == ""){
			alert("비밀번호를 입력해주세요.");
		}
		else if(document.getElementById("pw").value == "${requestScope.dto.pw }"){
			if(confirm("탈퇴하겠습니까?")){
				alert("회원을 탈퇴합니다. 이용해주셔서 감사합니다.");
				location.href="./ProfileDelete.pro";
			}else{
				alert("취소되었습니다.");
			}
		}else{
			alert("비밀번호가 일치하지 않습니다.");
		}
	}
	</script>
	
<jsp:include page="../inc/bottom.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>
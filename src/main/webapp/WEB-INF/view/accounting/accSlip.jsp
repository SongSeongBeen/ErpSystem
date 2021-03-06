<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<!--  CSS stylesheet link -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/accounting/accounting.css">

<title>공지사항</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
</head>

<body>
	<form id="myForm">
	<input type="hidden" id="currentPageAccSlip" value="1">
		<div id="mask"></div>
		<div id="wrap_area">
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			<div id="container">
				<ul style="background-color:white;">
					<li class="lnb">
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
					</li>
					<li class="contents">
						<h3 class="hidden">contents 영역</h3>
						<div class="content">
							<p class="Location">
								<a href="" class="btn_set home">메인으로</a>
								<a href="" class="btn_nav">회계</a> 
								<span class="btn_nav bold">회계전표 조회</span> 
								<a href="" class="btn_set refresh">새로고침</a>
							</p>


							<!-- 관리자 공지사항 리스트 조회  -->
							<div class="divfAccSlipList">
								<p class="conTitle">
									<span>회계전표 조회</span> 
									
								</p>
								<div class = "app_date_apply">
								<!-- 달력 조회 -->
									<strong>&emsp;수주일자&emsp;</strong>
									<input type="text" id="from_date" class="datepicker" placeholder="YYYY-MM-SS">&emsp; ~ &emsp;<input type="text" id="to_date" class="datepicker" placeholder="YYYY-MM-SS">
								</div>
								<div class = "app_select_apply">
			                        <ul>
										<li>
											&emsp;계정과목&emsp;<select id="g_cd"></select>
											&emsp;거래처명&emsp;<input type="search" id="acc_cb">
											<a class="btnType blue" href="javascript:fAccSlipList()" id="searchEnter" name="search">
									  		<span>조회</span></a><br/>
										</li>	
									</ul>
								</div>
								<table class="col">
									<thead>
										<tr>
											<th>번호</th>
											<th>전표번호</th>
											<th>수주일자</th>
											<th>계정코드</th>
											<th>계정과목</th>
											<th>담당자</th>
											<th>거래처명</th>
											<th>지출</th>
											<th>수입</th>
										</tr>
									</thead>
									<tbody id="accSlipList">
									</tbody>
								</table>
							</div>
								<div class="paging_area" id="accSlipPagination"></div>

							
							<!-- 관리자 공지사항 리스트 조회  -->
							<br> <br>
						</div>
				</ul>
			</div>
		</div>
	</form>
	<div id="layer1" class="layerPop layerType2" style="width: 650px; overflow: auto;"></div>
	<form id="myForm">
		<div id="layer2" class="layerPop layerType2" style="width: 900px; top: 111.5px; left: 220px; display: block;">
			<dl>
				<dt>
					<strong>회계전표</strong>
				</dt>
				<dd style="height: auto;">
					<h1 style="font-size: 50px; height: 40px; padding-top: 2%; width: 50%;">회계전표</h1>
					<table class="scrolltbody col" >
						<colgroup>
								<col width="80px">
								<col width="88.75px">
								<col width="123.88px">
								<col width="87.56px">
								<col width="87.56px">
								<col width="86.81px">
								<col width="97px">
								<col width="97px">
								<col width="88px">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">전표번호</th>
								<th scope="col">수주일자</th>
								<th scope="col">수주번호</th>
								<th scope="col">담당자</th>
								<th scope="col">거래처명</th>
								<th scope="col">계정과목</th>
								<th scope="col">지출</th>
								<th scope="col">수입</th>
								<th scope="col">비고</th> 
							</tr>
						</thead>
						<tbody  scope="col" id="accSlipListModal" class = "accSlipListModal">
						</tbody>
					</table>
					<table  class="col">
                        <colgroup>
								<col width="65%">
								<col width="12%">
								<col width="12%">
								<col width="92px">
						</colgroup>
					      <tr>
					           <td style="font-weight:bold; color:#333; background-color:rgb(220,225,230);">합계 </td>
					           <td><div id="inamtarea"></div></td>					           
					           <td><div id="outamtarea"></div></td>	
					           <td style="background-color:rgb(220,225,230);"></td>				
					      </tr>
					</table>
					<div class="btn_areaC mt20">
						<!-- <a href="javascript:fWrite();" class="btnType blue" id="submitBtn"><span id="">작성</span></a> -->
						 <!-- <a href="" class="btnType blue" id="closePop"><span id="">닫기</span></a> -->
						 <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
	</form>
</body>

<link rel="stylesheet" href="https//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

<script type="text/javascript">

	//그룹코드 페이징 설정
	var pageSizeAccSlip = 10; //네비게이션에 표시할 페이지 수
	var pageBlockSizeAccSlip = 10; //그리드에 출력할 목록 수

	//받아온 리스트데이터 호출
	$(document).ready(function() {
		
		selectComCombo("cli", "acc_cb", "all", ""); //  cli 거래처
		comcombo("ACCcd", "g_cd", "all", ""); // Group Code, Combo Name, Option("all" : 전체     "sel" : 선택 , Select Value )  

		fAccSlipList();
		
		$("#to_date").change(function() {
			if ($("#to_date").val() < $("#from_date").val()) {
				swal("최소기간 보다 작을수 없습니다.")
				$("#to_date").val('');
			}
		});
	}); 

	//리스트 데이터 받아오기
	function fAccSlipList(currentPage) {
		
		currentPage = currentPage || 1;
		var acc_cb = $('#acc_cb').val();
		var g_cd = $('#g_cd').val();
		var from_date = $("#from_date").val();
		var to_date = $("#to_date").val();

		var param = {
			currentPage : currentPage,
			pageSizeAccSlip : pageSizeAccSlip,
			acc_cb : acc_cb,
			g_cd : g_cd,
			from_date : from_date,
			to_date : to_date
		}

		var resultCallback = function(data) {
			fAccSlipResult(data, currentPage);
		};

		//Ajax실행 방식
		//callAjax("Controller Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		// json으로 보내서 오류가 났음 , -> text
		callAjax("/accounting/accSlipCallback.do", "post", "text", true, param,resultCallback);
	}

	//리스트 데이터 출력
	function fAccSlipResult(data, currentPage) {
		console.log("data 값" + data);
		$('#accSlipList').empty();
		$('#accSlipList').append(data);
		
		var accSlipCnt = $("#totalAccSlipCnt").val();
		console.log("accSlipCnt  :  " + accSlipCnt);
		
		//var paginationHtml = getPaginationHtml(currentPage, totalCntComnGrpCod, pageSizeComnGrpCod, pageBlockSizeComnGrpCod, 'fListComnGrpCod');
		var paginationHtml = getPaginationHtml(currentPage, accSlipCnt, pageSizeAccSlip, pageBlockSizeAccSlip, 'fAccSlipList');
		console.log("paginationHtml : " + paginationHtml);

		//swal(paginationHtml);
		$("#accSlipPagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPageAccSlip").val(currentPage);
	}
	
	function fPopModalAccSlip() {
		
		var acc_cb = $('#acc_cb').val();
		var g_cd = $('#g_cd').val();
		var from_date = $("#from_date").val();
		var to_date = $("#to_date").val();

		var param = {
			acc_cb : acc_cb,
			g_cd : g_cd,
			from_date : from_date,
			to_date : to_date
		}

		var resultCallback = function(data) {
			console.log("data 값" + data);
			fAccSlipModalResult(data);
		};

		//Ajax실행 방식
		//callAjax("Controller Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
		// json으로 보내서 오류가 났음 , -> text
		callAjax("/accounting/accSlipModal.do", "post", "text", true, param,resultCallback);
		
	}
	
	//리스트 데이터 출력
	function fAccSlipModalResult(data, currentPage) {
		

		gfModalPop('#layer2');

		$('#accSlipListModal').empty();
		$('#accSlipListModal').append(data);
		
		var inamt = $("#inamt").val();
		console.log("inamt  :  " + inamt);
		var outamt = $("#outamt").val();
		console.log("outamt  :  " + outamt);	
		
		$("#inamtarea").empty().append(inamt.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
		$("#outamtarea").empty().append(outamt.replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
		
}
	
	//달력
	$(document).ready(function () {
		(function($){
			$.fn.datepicker.dates['ko'] = {
				days: ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
				daysShort: ["월", "화", "수", "목", "금", "토", "일"],
				daysMin: ["월", "화", "수", "목", "금", "토", "일"],
				months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				today: "오늘",
				clear: "삭제",
				format: "yyyy-mm-dd",
				titleFormat: "yyyy년mm월",
				weekStart: 0
			};
		}(jQuery));

		// datepicker 사용 선언 
		$('#from_date').datepicker({	
			format : "yyyy-mm-dd",	
			language : 'ko',
			todayHighlight: true,
			toggleActive: true,
			daysOfWeekHighlighted : [6],
			minDate : 0,
			autoclose: true
		});
		
		$('#to_date').datepicker({	
			format : "yyyy-mm-dd",	
			language : 'ko',
			todayHighlight: true,
			toggleActive: true,
			daysOfWeekHighlighted : [6],
			autoclose: true
		});
		$('#dv_use_date').datepicker({	
			format : "yyyy-mm-dd",	
			language : 'ko',
			todayHighlight: true,
			toggleActive: true,
			daysOfWeekHighlighted : [6],
			autoclose: true
		});
	}); 
</script>

</html>
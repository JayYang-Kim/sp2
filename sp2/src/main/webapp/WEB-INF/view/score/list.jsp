<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="<%=cp%>/resource/css/common.css" media="all" />
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
		<style type="text/css">
			#container{width:1024px;margin:0 auto;}
		</style>
		<script type="text/javascript">
			function deleteScore(hak) {
				if(confirm("삭제하시겠습니까?")) {
					var url = "<%=cp%>/score/delete?hak=" + hak + "&page=${page}";
					location.href = url;
				}
			}
			
			function readScore(hak) {
				var url = "<%=cp%>/score/read?hak=" + hak + "&page=${page}";
				location.href = url;
			}
			
			/* $(function(){
				$("#chkAll").click(function(){
					$(this).closest("table").find(".chk").prop("checked", this.checked);
				});
			}); */
			
			$(function() {
				$("#chkAll").click(function(){
					if($(this).is(":checked")) {
						$("input[name=haks]").prop("checked", true);
					} else {
						$("input[name=haks]").prop("checked", false);
					}
				});
			});
			
			$(function(){
				$('#btnCheckDelete').click(function(){
					var cnt = $("input[name=haks]:checked").length;
					if(cnt == 0) {
						alert("삭제할 게시물을 먼저 선택해주세요.");
						return;
					} 
					if (confirm("선택된 게시물을 삭제 하시겠습니까?")) {
						var f = document.deleteScoreForm;
						f.submit();
					}
				});				
			});
		</script>
	</head>
	<body>
		<div id="container">
			<div class="mt20">
				<h3>학점</h3>
			</div>
			<div class="mt20">
				<form name="deleteScoreForm" action="<%=cp%>/score/deleteListScore" method="post">
					<table class="tb_basic tb_hover w100p">
						<caption>성적처리</caption>
						<%-- <colgroup>
							<col>
							<col>
							<col>
							<col>
							<col style="width:20%" span="3">
						</colgroup> --%>
						<thead>
							<tr>
								<th>
									<input type="checkbox" id="chkAll"/>
									<input type="hidden" name="page" value="${page}">
								</th>
								<th>학번</th>
								<th>이름</th>
								<th>생일</th>
								<th>국어</th>
								<th>영어</th>
								<th>수학</th>
								<th>총점</th>
								<th>평균</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${list}">
								<tr>
								<%-- <tr onclick="readScore('${dto.hak}')"> --%>
									<td>
										<input type="checkbox" class="chk" name="haks" value="${dto.hak}"/>
									</td>
									<td>${dto.hak}</td>
									<td>${dto.name}</td>
									<td>${dto.birth}</td>
									<td>${dto.kor}</td>
									<td>${dto.eng}</td>
									<td>${dto.mat}</td>
									<td>${dto.tot}</td>
									<td>${dto.ave}</td>
									<td>
										<a href="">수정</a> |
										<a href="javascript:deleteScore('${dto.hak}')">삭제</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</form>
				<div class="t_right mt20">
					<button type="button" class="btn btn-black" onclick="location.href='<%=cp%>/score/insert'">등록하기</button>
					<button id="btnCheckDelete" type="button" class="btn btn-white">삭제하기</button>
				</div>
				<div class="t_center">
					${paging}
				</div>
				<form action="<%=cp%>/score/list" method="post">
					<div class="t_center"> 
						<select name="searchKey">
							<option value="hak">학번</option>
							<option value="name">이름</option>
							<option value="birth">생일</option>
						</select>
						<input type="text" name="searchValue" placeholder="검색 내용을 입력해주세요."/>
						<button class="btn btn-white">검색</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
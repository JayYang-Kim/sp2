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
		<style type="text/css">
			#container{width:1024px;margin:0 auto;}
		</style>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
		<script type="text/javascript">
			function sendOk() {
				var f = document.scoreForm;
				
				f.action = "<%=cp%>/score/${mode}";
				f.submit();
			}
		</script>
	</head>
	<body>
		<div id="container">
			<div class="mt20">
				<h3>학점</h3>
			</div>
			<div class="mt20">
				<table class="tb_basic_row">
					<caption>성적처리</caption>
					<colgroup>
						<col style="width:30%">
						<col style="width:70%">
					</colgroup>
					<tr>
						<th>학번</th>
						<td>${dto.hak}</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>${dto.name}</td>
					</tr>
					<tr>
						<th>생일</th>
						<td>${dto.birth}</td>
					</tr>
					<tr>
						<th>국어</th>
						<td>${dto.kor}</td>
					</tr>
					<tr>
						<th>영어</th>
						<td>${dto.eng}</td>
					</tr>
					<tr>
						<th>수학</th>
						<td>${dto.mat}</td>
					</tr>
					<tr>
						<th>총점</th>
						<td>${dto.tot}</td>
					</tr>
					<tr>
						<th>평균</th>
						<td>${dto.ave}</td>
					</tr>
				</table>
				<div class="t_center mt20">
					<button type="button" class="btn btn-black" onclick="sendOk()">수정하기</button>
					<button type="button" class="btn btn-black" onclick="location.href='<%=cp%>/score/list'">등록취소</button>
				</div>
			</div>
		</div>
	</body>
</html>
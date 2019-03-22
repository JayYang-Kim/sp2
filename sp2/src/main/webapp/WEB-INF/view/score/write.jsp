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
				<form name="scoreForm" method="post">
					<table class="tb_basic_row">
						<caption>성적처리</caption>
						<colgroup>
							<col style="width:30%">
							<col style="width:70%">
						</colgroup>
						<tr>
							<th>학번</th>
							<td>
								<input type="text" name="hak"/>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<input type="text" name="name"/>
							</td>
						</tr>
						<tr>
							<th>생일</th>
							<td>
								<input type="text" name="birth"/>
							</td>
						</tr>
						<tr>
							<th>국어</th>
							<td>
								<input type="text" name="kor"/>
							</td>
						</tr>
						<tr>
							<th>영어</th>
							<td>
								<input type="text" name="eng"/>
							</td>
						</tr>
						<tr>
							<th>수학</th>
							<td>
								<input type="text" name="mat"/>
							</td>
						</tr>
					</table>
					<div class="t_center mt20">
						<button type="button" class="btn btn-black" onclick="sendOk()">등록하기</button>
						<button type="reset" class="btn btn-black">다시입력</button>
						<button type="button" class="btn btn-black" onclick="location.href='<%=cp%>/score/list'">등록취소</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
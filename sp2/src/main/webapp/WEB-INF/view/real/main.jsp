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
		<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript">
			$(function(){
				information();
			});
		
			$(function() {
				setInterval("information()", 10000); // 10초
			});
			
			function information() {
				var url = "<%=cp%>/real/info";
				
				$.get(url, {tmp : new Date().getTime()}, function(data){ // get방식은 주소가 변하지 않으면 서버에 전송하지 않기 때문에 시간을 가져와서 서버로 전송
					var num = data.num;
					var h = data.hour;
					var m = data.minute;
					var s = data.second;
					
					if(h == 0) {
						h = 12;
					}
					if(h < 10) {
						h = "0" + h;
					}
					if(m < 10) {
						m = "0" + m;
					}
					if(s < 10) {
						s = "0" + s;
					}
					
					$("#snum").html(num);
					$("#stime").html(h + " : " + m + " : " + s);
				}, "json");
			}
		</script>
	</head>
	<body>
		<h3>30초에 한 번씩 정보 확인</h3>
		<div>
			<p>번호 : <span id="snum">0</span></p>
			<p>시간 : <span id="stime">00:00:00</span></p>
		</div>
	</body>
</html>
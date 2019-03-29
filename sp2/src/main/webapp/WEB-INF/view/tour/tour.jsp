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

<style type="text/css">
* {
    margin:0; padding:0;
}
body {
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
    font-size: 14px;
}
a {
    cursor: pointer;
    color: #000000;
    text-decoration: none;
}
a:hover, a:active {
    color: #F28011;
    text-decoration: underline;
}

.title {
	font-weight: bold;
	font-size:13pt;
	margin-bottom:10px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
}

.btn {
    color:#333333;
    font-weight:500;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
    border:1px solid #cccccc;
    background-color:#fff;
    text-align:center;
    cursor:cursor;
    padding:3px 10px 5px;
    border-radius:4px;
}
.btn:active, .btn:focus, .btn:hover {
    background-color:#e6e6e6;
    border-color: #adadad;
    color: #333333;
}
.boxTF {
    border:1px solid #999999;
    padding:3px 5px 5px;
    border-radius:4px;
    background-color:#ffffff;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}
.selectField {
    border:1px solid #999999;
    padding:2px 5px 4px;
    border-radius:4px;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}

ul {
	list-style: none;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function cityList() {
	var snum = $("#sido").val();
	if(snum == "") {
		$("#city option").each(function(){ // #city(select) option 개수만큼 반복
			$("#city option:eq(0)").remove(); // 맨 처음 option을 삭제 $("#city option").first().remove(); 
		});
		
		$("#city").append("<option value=''>::도시선택::</option>");
		
		return;
	}
	
	var url = "<%=cp%>/tour/cityList";
	var query = "snum=" + snum;
	
	$.ajax({
		type : "get",
		url : url,
		data : query,
		dataType : "json",
		success : function(data) {
			// 기존 데이터 삭제
			$("#city option").each(function(){
				$("#city option:eq(0)").remove();
			});
			
			$("#city").append("<option value=''>::도시선택::</option>");
			
			for(var i = 0; data.listCity.length; i++) {
				var cnum = data.listCity[i].cnum;
				var snum = data.listCity[i].snum;
				var city = data.listCity[i].city;
				
				$("#city").append("<option value='"+cnum+"'>"+city+"</option>");
			}
		},
		error : function(jqXHR) {
			console.log(jqXHR.responseText);
		}
	});
}

function result() {
	var snum=$("#sido").val();
	var cnum=$("#city").val();
	var sido=$("#sido :selected").text();
	var city=$("#city :selected").text();

	if(! snum || ! cnum) {
		return;
	}
	
	var s=sido+":"+snum+", "+city+":"+cnum;
	alert(s);
}
</script>

</head>
<body>

    <div style="margin: 50px auto 10px; width:300px;">
	          <select id="sido" onchange="cityList();" class="selectField">
                   <option value="">::시도선택::</option>
                   <c:forEach var="dto" items="${list}">
                       <option value="${dto.snum}">${dto.sido}</option>
                   </c:forEach>
              </select>

              <select id="city" class="selectField">
                   <option value="">::도시선택::</option>
              </select>
              <button type="button" onclick="result();" class="btn">확인</button>
    </div>
    <div style="margin: 5px auto; width:300px;">
       <a href="<%=cp%>/tour/main" class="btn" style="text-decoration: none; display:inline-block; width: 80%;">돌아가기</a>
    </div>

</body>
</html>
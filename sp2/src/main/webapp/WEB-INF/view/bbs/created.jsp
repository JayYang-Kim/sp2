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
			#container .inner{width:1024px;margin:0 auto;}
			#container .inner .title{margin:20px 0;}
		</style>
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
		<script type="text/javascript">
			function sendOk() {
				var f = document.boardForm;
				
				/* 유효성 검사 영역 */
				var subject = $("input[name=subject]");
				var name = $("input[name=name]");
				var pwd = $("input[name=pwd]");
				var content = $("textarea[name=content]");
				
				if(!subject.val()) {
					subject.focus().css("outline-color", "red");
					subject.attr("placeholder", "제목을 입력해주세요.");
					return;
				} else if(!name.val()) {
					name.focus().css("outline-color", "red");
					name.attr("placeholder", "이름을 입력해주세요.");
					return;
				} else if(!pwd.val()) {
					pwd.focus().css("outline-color", "red");
					pwd.attr("placeholder", "비밀번호를 입력해주세요.");
					return;
				} else if(!content.val()) {
					content.focus().css("outline-color", "red");
					content.attr("placeholder", "내용을 입력해주세요.");
					return;
				}
				
				
				/* var returnNow = false;
				var s;
				
				$("form[name=boardForm] input, form[name=boardForm] textarea").each(function(){
					if(!$(this).val()) {
						$(this).focus().css("outline-color", "red");
						var text = $(this).closest("tr").find("th").text();
						$(this).attr("placeholder", text + "을(를) 입력해주세요.");
						returnNow = true;
						return false;
					}
				});
				
				if(returnNow) {
					return;
				} */
				
				f.action = "<%=cp%>/bbs/${mode}";
				f.submit();
			}
		</script>
	</head>
	<body>
		<div id="container">
			<div class="inner">
				<div>
					<div class="title">
						<h3>게시판 - 등록</h3>
					</div>
					<form name="boardForm" method="post">
						<table class="tb_basic_row">
							<colgroup>
								<col style="width:20%">
								<col style="width:30%">
								<col style="width:20%">
								<col style="width:30%">
							</colgroup>
							<tr>
								<th>제목</th>
								<td colspan="3">
									<input type="text" class="w100p" name="subject" value="${dto.subject}"/>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									<input type="text" name="name" value="${dto.name}"/>
								</td>
								<th>비밀번호</th>
								<td>
									<input type="text" name="pwd"/>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3">
									<textarea name="content">${dto.content}</textarea>
								</td>
							</tr>
						</table>
						<div class="t_right mt20">
							<c:if test="${mode == 'update'}">
								<input type="hidden" name="num" value="${dto.num}"/>
								<input type="hidden" name="page" value="${page}"/>
								<input type="hidden" name="rows" value="${rows}"/>
							</c:if>
							<button type="reset" class="btn btn-white f_left">다시입력</button>
							<button type="button" class="btn btn-black" onclick="sendOk()">${mode == 'created' ? "등록하기" : "수정하기"}</button>
							<button type="button" class="btn btn-white" onclick="location.href='<%=cp%>/bbs/list'">${mode == 'created' ? "등록취소" : "수정취소"}</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>
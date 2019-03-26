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
		</script>
	</head>
	<body>
		<div id="container">
			<div class="inner">
				<div>
					<div class="title">
						<h3>게시판 - 상세</h3>
					</div>
					<form>
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
									${dto.subject}
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>
									${dto.name}
								</td>
								<th>ip주소</th>
								<td>
									${dto.ipAddr}
								</td>
							</tr>
							<tr>
								<th>조회수</th>
								<td>
									${dto.hitCount}
								</td>
								<th>작성일</th>
								<td>
									${dto.created}
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3">
									<textarea name="content" readonly="readonly">${dto.content}</textarea>
								</td>
							</tr>
						</table>
						<div class="mt10 mb10 p10" style="border-top:1px solid #c4c4c4;border-bottom:1px solid #c4c4c4;">
							<div>
								<c:if test="${not empty preReadBoard}">
									<span>이전글 : </span>
									<a href="<%=cp%>/bbs/article?num=${preReadBoard.num}&${query}">${preReadBoard.subject}</a>
								</c:if>
							</div>
							<div>
								<c:if test="${not empty nextReadBoard}">
									<span>다음글 : </span>
									<a href="<%=cp%>/bbs/article?num=${nextReadBoard.num}&${query}">${nextReadBoard.subject}</a>
								</c:if>
							</div>
						</div>
						<div class="t_right mt20">
							<button type="button" class="btn btn-red f_left" onclick="location.href='<%=cp%>/bbs/delete?num=${dto.num}&page=${page}&rows=${rows}'">삭제하기</button>
							<button type="button" class="btn btn-black" onclick="location.href='<%=cp%>/bbs/update?num=${dto.num}&page=${page}&rows=${rows}'">수정하기</button>
							<button type="button" class="btn btn-white" onclick="location.href='<%=cp%>/bbs/list?${query}'">뒤로가기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>
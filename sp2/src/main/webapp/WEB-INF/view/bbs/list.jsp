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
			function rowsList() {
				var f = document.boardListForm;
			
				f.action = "<%=cp%>/bbs/list";
				f.submit();
			}
		</script>
	</head>
	<body>
		<div id="container">
			<div class="inner">
				<div>
					<div class="title">
						<h3>게시판</h3>
					</div>
					<form name="boardListForm" method="post">
						<div class="t_right mt20 mb20">
							<select name="rows" onchange="rowsList()">
								<option value="5" ${rows == 5 ? "selected='selected'" : ""}>5개씩 출력</option>
								<option value="10" ${rows == 10 ? "selected='selected'" : ""}>10개씩 출력</option>
								<option value="15" ${rows == 15 ? "selected='selected'" : ""}>15개씩 출력</option>
								<option value="20" ${rows == 20 ? "selected='selected'" : ""}>20개씩 출력</option>
							</select>
							<input type="hidden" name="searchKey" value="${searchKey}"/>
							<input type="hidden" name="searchValue" value="${searchValue}"/>
						</div>
						<div>
							<table class="tb_basic w100p" style="table-layout:fixed;">
								<caption>테이블</caption>
								<colgroup>
									<col style="width:50px">
									<col style="width:80px">
									<col>
									<col style="width:100px">
									<col style="width:150px">
									<col style="width:60px">
								</colgroup>
								<thead>
									<tr>
										<th>
											<input type="checkbox" name="chkAll"/>
										</th>
										<th>번호</th>
										<th>제목</th>
										<th>이름</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="dto" items="${list}">
										<tr onclick="location.href='${articleUrl}&num=${dto.num}'">
											<td>
												<input type="checkbox" name="chk" value="${dto.num}"/>
											</td>
											<td>${dto.listNum}</td>
											<td>${dto.subject}</td>
											<td>${dto.name}</td>
											<td>${dto.created}</td>
											<td>${dto.hitCount}</td>
										</tr>
									</c:forEach>
									<c:if test="${list eq null}">
										<tr>
											<td colspan="6">등록된 게시물이 없습니다.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>
					</form>
					<form action="<%=cp%>/bbs/list" method="post">
						<div class="mt20 mb20">
							<button type="button" class="btn btn-white" onclick="location.href='<%=cp%>/bbs/list'">새로고침</button>
							<select name="searchKey">
								<option value="all">제목 + 내용</option>
								<option value="subject">제목</option>
								<option value="content">내용</option>
								<option value="name">이름</option>
								<option value="created">등록일</option>
							</select>
							<input type="text" name="searchValue"/>
							<input type="hidden" name="rows" value="${rows}"/> <!-- 검색하고 나서 rows개수를 가지고 있어야 10개씩 나오기 때문에 현재 rows 개수를 넘겨야함 -->
							<button type="submit" class="btn btn-gray">검색</button>
							<button type="button" class="btn btn-black f_right" onclick="location.href='<%=cp%>/bbs/created'">등록하기</button>
						</div>
						<div class="clear t_center">
							${paging}
						</div>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>
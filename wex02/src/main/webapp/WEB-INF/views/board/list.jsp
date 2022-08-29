<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

     <div class="row">
         <div class="col-lg-12">
             <h1 class="page-header">Tables</h1>
         </div>
         <!-- /.col-lg-12 -->
     </div>
     <!-- /.row -->
     <div class="row">
         <div class="col-lg-12">
             <div class="panel panel-default">
                 <div class="panel-heading">
                    Board List Page
                    <button id='regBtn' type="button" class="btn btn-xs pull-right">Register New Board</button>
                 </div>
                 
                 
                 <!-- 검색 조건 처리 -->
                <div class='row'>
					<div class="col-lg-12">

						<form id='searchForm' action="/board/list" method='get'>
							<select name='type'>
								<option value=""
									<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
								<option value="T"
									<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
								<option value="C"
									<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
								<option value="W"
									<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
								<option value="TC"
									<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목
									or 내용</option>
								<option value="TW"
									<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목
									or 작성자</option>
								<option value="TWC"
									<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목
									or 내용 or 작성자</option>
							</select> <input type='text' name='keyword'
								value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input
								type='hidden' name='pageNum'
								value='<c:out value="${pageMaker.cri.pageNum}"/>' /> <input
								type='hidden' name='amount'
								value='<c:out value="${pageMaker.cri.amount}"/>' />
							<button class='btn btn-default'>Search</button>
						</form>
					</div>
				</div>
                 

                 <!-- /.panel-heading -->
                 <div class="panel-body">
                     <table width="100%" class="table table-striped table-bordered table-hover" >
                         <thead>
                        		<tr>
									<th>#번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>수정일</th>
								</tr>
                         </thead>
                        
						<c:forEach items="${list}" var="board">
							<tr>
								<td>${board.bno}</td>
								<td><a class ='move' href='<c:out value="${board.bno }"/>'>
								<c:out value="${board.title}" /></a></td>
								<td><c:out value="${board.writer}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>
							</tr>
						</c:forEach>
                       </table>
 				
 				
 				<!-- 페이징 처리 -->
 				<div class='pull-right'>
					<ul class="pagination">

			            <c:if test="${pageMaker.prev}">
			              <li class="paginate_button previous">
			              	<a href="${pageMaker.startPage-1 }">Previous</a>
			              </li>
			            </c:if>
			
			            <c:forEach var="num" begin="${pageMaker.startPage}"
			              end="${pageMaker.endPage}">
			            <li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""} ">
			              	<a href="${num }">${num}</a></li>
			            </c:forEach>
						<%-- c:if test는 항상 boolean 값을 반환하기에 여기서 계산하려 하지 말고
								불린형 값만 나오게 코드 짜는 게 좋다. --%>
			            <c:if test="${pageMaker.next}">
			              <li class="paginate_button next">
			              	<a href="${pageMaker.endPage+1 }">Next</a></li>
			            </c:if>
			            
					</ul>
				</div>
				<!--  end Pagination -->                      
			
				<form id='actionForm' action="/board/list" method='get'>
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='${pageMaker.cri.type}'>
					<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'>
				</form>                       
                       
			                       
					<!-- Modal  추가 -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">Modal title</h4>
								</div>
								<div class="modal-body">처리가 완료되었습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									<button type="button" class="btn btn-primary" data-dismiss="modal">Save changes</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal 끝-->
                       
                       
                       
                       
                       
                 <!-- /.panel-body -->
             </div>
             <!-- /.panel -->
         </div>
         <!-- /.col-lg-6 -->
     </div>
     <!-- /.row -->
     
<script type="text/javascript">
	$(document).ready(
		function() {
			//컨트롤러에서 bno 값을 result에 저장해뒀다. 
			//c:out을 쓰는 이유는 크로스 사이트 스크립팅 방지하기 위해서
			var result = '<c:out value="${result}"/>';

			checkModal(result);
			
			//★뒤로가기,앞으로가기 등 브라우저가 보관하고 있는 히스토리를 클리어 해야한다.
			history.replaceState({}, null, null);
			
			function checkModal(result) {

				if (result === '' || history.state) {
					return;
				}

				if (parseInt(result) > 0) {
					$(".modal-body").html(
							"게시글 " + parseInt(result)
									+ " 번이 등록되었습니다.");
				}

				$("#myModal").modal("show");
			}

			$("#regBtn").on("click", function() {
				//self.location = window.location
				self.location = "/board/register";

			});
			
			var actionForm = $("#actionForm");

			$(".paginate_button a").on(
					"click",
					function(e) {

						e.preventDefault();

						console.log('click');

						actionForm.find("input[name='pageNum']")
								.val($(this).attr("href"));
						actionForm.submit(); //submit해야 실제 url 이동이 가능하다.
			});

			
			$(".move").on("click",function(e){
				
				e.preventDefault();
				actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
				//actionForm.attr("action", "/board/get").submit();  아래 두문장 이렇게 적어도 된다. 체이닝! 	
				actionForm.attr("action", "/board/get");
				actionForm.submit(); 
			});
			
			
			var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function(e){
				
				if(!searchForm.find("option:selected").val()){
					alert("검색종류를 선택하세요");
					return false;
				}
				
				if(!searchForm.find("input[name='keyword']").val()){
					alert("키워드를 입력하세요");
					return false;
				}
				
				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				
				searchForm.submit();
	
			});
			
			
		});

</script>
 
 <%@include file="../includes/footer.jsp" %>

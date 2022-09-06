<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Register</h1>
	</div>
</div>

<div>
	<div class="col-lg-12">
		<div class="panel-heading">Board Register</div>
		<div class="panel-body">
			
			<!-- actiond을 안주면 브라우저의 url을 따라간다. -->
			<form role="form" action="/board/register" method="post">
				<div class="form-group">
					<label>Title</label>
					<!-- input 태그를 줄 떄 가장 중요한 속성인 name
							파라미터를 전달할 때 이름이 되기 때문에. -->
					<input class="form-control" name='title'>
				</div>
				
				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name='content'></textarea>
				</div>				
				
				<div class="form-group">
					<label>Writer</label>
					<input class="form-control" name='writer'>
				</div>	
				
				<button type="submit" class="btn btn-default">Submit Button</button>			
				
			</form>
		</div>
	</div>
</div>


<%@include file="../includes/footer.jsp" %>
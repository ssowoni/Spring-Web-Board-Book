<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">Board Read</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">Board Read Page</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

          <div class="form-group">
          <label>Bno</label> <input class="form-control" name='bno'
            value='<c:out value="${board.bno }"/>' readonly="readonly">
        </div>

        <div class="form-group">
          <label>Title</label> <input class="form-control" name='title'
            value='<c:out value="${board.title }"/>' readonly="readonly">
        </div>

        <div class="form-group">
          <label>Text area</label>
          <textarea class="form-control" rows="3" name='content'
            readonly="readonly"><c:out value="${board.content}" /></textarea>
        </div>

        <div class="form-group">
          <label>Writer</label> <input class="form-control" name='writer'
            value='<c:out value="${board.writer }"/>' readonly="readonly">
        </div>

		
<%-- 		<button data-oper='modify' class="btn btn-default"
				onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">Modify</button>
		
		<button data-oper='list' class="btn btn-info"
				onclick="location.href='/board/list'">List</button> --%>
				
		<button data-oper='modify' class="btn btn-default">Modify</button>
		<button data-oper='list' class="btn btn-info">List</button>
		<form id='operForm' action="/board/modify" method="get">
			<input type='hidden' id='bno' name='bno' value=${board.bno } />
			<input type='hidden' id='pageNum' name='pageNum' value=${cri.pageNum } />
			<input type='hidden' id='amount' name='amount' value=${cri.amount } />
			<input type='hidden' name='type' value='${cri.type}'>
			<input type='hidden' name='keyword' value='${cri.keyword}'>
		</form>

      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->

<!-- 댓글 목록 처리 -->

<div class='row'>

  <div class="col-lg-12">

    <!-- /.panel -->
      <!-- 새로운 댓글 추가 버튼 -->
<div class="panel panel-default">
<!--       <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
      </div> -->
      
      <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
        <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
      </div>      
      
      
      <!-- /.panel-heading -->
      <div class="panel-body">        
      	<!-- 댓글 목록 -->
        <ul class="chat">

        </ul>
        <!-- ./ end ul -->
      </div>
      <!-- /.panel .chat-panel -->
	<!-- 댓글 페이징 -->
	<div class="panel-footer"></div>


		</div>
  </div>
  <!-- ./ end row -->
</div>

<!-- Modal -->
   <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
     <div class="modal-dialog">
       <div class="modal-content">
         <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal"
             aria-hidden="true">&times;</button>
           <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
         </div>
         <div class="modal-body">
           <div class="form-group">
             <label>Reply</label> 
             <input class="form-control" name='reply' value='New Reply!!!!'>
           </div>      
           <div class="form-group">
             <label>Replyer</label> 
             <input class="form-control" name='replyer' value='replyer'>
           </div>
           <div class="form-group">
             <label>Reply Date</label> 
             <input class="form-control" name='replyDate' value='2018-01-01 13:13'>
           </div>
          </div>
		<div class="modal-footer">
        <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
        <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
        <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
        <!-- data-dismiss="modal" 적어주면 모달창 닫힌다. -->
        <button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>          
      </div>
          <!-- /.modal-content -->
    </div>
        <!-- /.modal-dialog -->
  </div>
      <!-- /.modal -->



<script type="text/javascript" src="/resources/js/reply.js"></script>

<script >


$(document).ready(function () {
	  
	//게시글 상세보기 페이지 댓글 목록 조회 출력
	  var bnoValue = '<c:out value="${board.bno}"/>';
	  var replyUL = $(".chat");
	  
    	showList(1);
	    
		function showList(page){
		
	    
	    replyService.getList({bno:bnoValue,page: page|| 1 }, function(replyCnt,list) {
	    	
	    	
	    console.log("replyCnt : " + replyCnt);
	    console.log("list:" + list);
	    console.log(list);
	    
		//사용자가 댓글을 추가하면 참이되는 조건식
	    if(page == -1){
	    	//pageNum을 Math.ceil을 이용해 무조건 올림
	    	//만약 댓글이 21개면 3페이지가 돼야 하기에
	    	pageNum = Math.ceil(replyCnt/10.0);
	    	showList(pageNum);
	    	return;
	    }
     
	     var str="";
	     
	     if(list == null || list.length == 0){
	    	replyUL.html("");
	       return;
	     }
	     
	     for (var i = 0, len = list.length || 0; i < len; i++) {
	       str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
	       str +="  <div><div class='header'><strong class='primary-font'>["
	    	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
	       str +="    <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>"
	       str +="    <p>"+list[i].reply+"</p></div></li>";
	     }
	     
	     replyUL.html(str);
	     showReplyPage(replyCnt);
	 
	   });//end function
	     
	 }//end showList
	 
	 
	 
	//댓글 페이지 하단 페이지 번호 출력
    var pageNum = 1;
    var replyPageFooter = $(".panel-footer");
    
    function showReplyPage(replyCnt){
      
      //페이지 마지막 번호는 페이지 숫자를 소숫점으로 나눈 다음 소숫점을 올려주고 10을 곱한다.
      //예를들어 3페이지인 경우 0.3을 소숫점으로 올리면 1 * 10 = 10이 되는 것.
      var endNum = Math.ceil(pageNum / 10.0) * 10;  
      var startNum = endNum - 9; 
      
      //startNum이 1이 아니면 prev는 true!
      var prev = startNum != 1;
      var next = false;
      
      //만약 endNum이 실제 댓글 수보다 크다면 endNum은 재정의!
      if(endNum * 10 >= replyCnt){
        endNum = Math.ceil(replyCnt/10.0);
      }
      
      if(endNum * 10 < replyCnt){
        next = true;
      }
      
      var str = "<ul class='pagination pull-right'>";
      
      //이전 페이지 이동
      if(prev){
        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
      }
      
      //1~n 페이징 처리
      for(var i = startNum ; i <= endNum; i++){
        
    	//현재 페이지와 같다면 색을 칠해 표시해주기
        var active = pageNum == i? "active":"";
        
        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
      }
      
      //다음 페이지 이동
      if(next){
        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
      }
      
      str += "</ul></div>";
      
      console.log(str);
      
      //str을 통해 html을 붙여주는 형식으로 작성
      //즉) <div>의 innerHTML으로 추가한다. 
      //이렇게 출력하려면 showList()의 마지막에 페이지 출력하도록 수정
      replyPageFooter.html(str);
    }
    
    //댓글 페이지 번호 클릭 시 해당 페이지로 이동
    replyPageFooter.on("click","li a", function(e){
       e.preventDefault();
       console.log("page click");
       
       var targetPageNum = $(this).attr("href");
       
       console.log("targetPageNum: " + targetPageNum);
       
       pageNum = targetPageNum;
       
       showList(pageNum);
     });     	 
	 
	 
	 
	 
	 //댓글 등록 모달창
	 var modal = $(".modal");
	 var modalInputReply = modal.find("input[name='reply']");
	 var modalInputReplyer = modal.find("input[name='replyer']");
	 var modalInputReplyDate = modal.find("input[name='replyDate']");
	 
	 var modalModBtn = $("#modalModBtn");
	 var modalRemoveBtn = $("#modalRemoveBtn");
	 var modalRegisterBtn = $("#modalRegisterBtn");
	 
	 $("#addReplyBtn").on("click",function(e){
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id !='modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		$(".modal").modal("show");
	 });
	 
	 
	//새로운 댓글 추가 처리
	 modalRegisterBtn.on("click",function(e){
		 
		 var reply={
				 reply : modalInputReply.val(),
				 replyer:modalInputReplyer.val(),
				 bno:bnoValue
		 };
		 replyService.add(reply,function(result){
			 alert(result);
			 
			 modal.find("input").val("");
			 modal.modal("hide");
			 
			 //showList(1);
			//새로운 댓글 추가시 -1 값 전달
			 showList(-1);
		 });
		 
		 
	 });
	
	//댓글 조회 클릭 이벤트 처리 
    $(".chat").on("click", "li", function(e){
      
      var rno = $(this).data("rno");
      
      replyService.get(rno, function(reply){
      
        modalInputReply.val(reply.reply);
        modalInputReplyer.val(reply.replyer);
        modalInputReplyDate.val(replyService.displayTime( reply.replyDate))
        .attr("readonly","readonly");
        modal.data("rno", reply.rno);
        
        modal.find("button[id !='modalCloseBtn']").hide();
        modalModBtn.show();
        modalRemoveBtn.show();
        
        $(".modal").modal("show");
        
        console.log(rno);
            
      });
    });
	
	//댓글 수정
	  modalModBtn.on("click", function(e){
	      
	      var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
	      
	      replyService.update(reply, function(result){
	            
	        alert(result);
	        modal.modal("hide");
	        //수정 후 현재 댓글이 포함된 페이지로 이동
	        showList(pageNum);
	        
	      });
	      
	    });
	
		//댓글 삭제 
	    modalRemoveBtn.on("click", function (e){
	    	  
	  	  var rno = modal.data("rno");
	  	  
	  	  replyService.remove(rno, function(result){
	  	        
	  	      alert(result);
	  	      modal.modal("hide");
	  	      showList(pageNum);
	  	      
	  	  });
	  	  
	  	})
	
	 
	 
	 
	 
	 
});



/*
//ajax test

console.log("========");
console.log("JS TEST");

var bnoValue = '<c:out value="${board.bno}"/>';

 replyService.add(
		{reply:"JS TEST", replyer:"tester", bno:bnoValue}
		,
		function(result){
			alert("RESULT : " +result);
		}
		); 
		
replyService.getList({bno:bnoValue, page:1}, function(list){
	for(var i=0, len=list.length||0; i<len; i++){
		console.log(list[i]);
	}
});	
	

replyService.remove(13, function(count) {

   console.log(count);

   if (count === "success") {
     alert("REMOVED");
   }
 }, function(err) {
   alert('ERROR...');
 }); 
 
 replyService.update({
	  rno : 12,
	  bno : bnoValue,
	  reply : "Modified Reply...."
	}, function(result) {

	  alert("수정 완료...");

	});  
	
	replyService.get(10, function(data){
		console.log(data);
	});

*/
</script>


<script type="text/javascript">
$(document).ready(function(){
	
	var operForm = $("#operForm"); //id가 operForm인 태그 값을 가져온다. 
	
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/board/modify").submit();
	});
	
	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#bno").remove();
		operForm.attr("action","/board/list");
		operForm.submit();
	});
	
});
</script>

<%@include file="../includes/footer.jsp"%>

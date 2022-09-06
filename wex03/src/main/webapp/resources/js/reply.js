console.log("Reply Module.....");

var replyService =(function(){
	
	function add(reply, callback, error) {
		console.log("add reply...............");
		
	
		$.ajax({
			type : 'post',
			url : '/replies/new',
			//data : HTTP 요청과 함께 서버로 보낼 데이터 
			//JSON.stringify(reply): JavaScript 값/객체를 JSON 문자열로 변환해주는 메서드이다. 
			//stringify를 그대로 해석하면 string(문자열) + ify(~화 하다) = 문자열화 하다, 문자열로 만들다 라는 뜻
			data : JSON.stringify(reply),
			//contentType: 서버에 데이터 보낼 때 전송할 데이터 타입
			contentType : "application/json; charset=utf-8",
			//요청 성공 시 동작할 콜백 함수 지정
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			//요청 실패 시 실행될 콜백 함수 지정
			//status : HTTP 상태 코드
			//error : 에러 메시지
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		})
	}

	//댓글 페이징과 숫자 목록을 가져오게 변경
	function getList(param, callback, error) {

		var bno = param.bno;
		var page = param.page || 1;
		//$.getJSON: 전달받은 주소로 GET 방식의 HTTP 요청을 전송하여, 응답으로 JSON 파일을 전송받음.
		//url은 '/replies/pages/게시물번호/페이지번호' 형태이다.
		$.getJSON("/replies/pages/" + bno + "/" + page,
			function(data) {
				if (callback) {
					//callback(data); //댓글 목록만 가져오는 경우
					callback(data.replyCnt,data.list);//댓글 숫자와 목록을 가져오는 경우
				}
			}).fail(function(xhr, status, err) {
			if (error) {
				error();
			}
		});
	}	
	
	function remove(rno, callback, error) {
		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			success : function(deleteResult, status, xhr) {
				if (callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	

	
	
	function update(reply, callback, error) {
	
			console.log("RNO: " + reply.rno);
	
			$.ajax({
				type : 'put',
				url : '/replies/' + reply.rno,
				data : JSON.stringify(reply),
				contentType : "application/json; charset=utf-8",
				success : function(result, status, xhr) {
					if (callback) {
						callback(result);
					}
				},
				error : function(xhr, status, er) {
					if (error) {
						error(er);
					}
				}
			});
		}	
		
	function get(rno, callback, error) {
	
			$.get("/replies/" + rno , function(result) {
	
				if (callback) {
					callback(result);
				}
	
			}).fail(function(xhr, status, err) {
				if (error) {
					error();
				}
			});
		}
	
	
	function displayTime(timeValue) {
	
			var today = new Date();
	
			var gap = today.getTime() - timeValue;
	
			var dateObj = new Date(timeValue);
			var str = "";
	
			if (gap < (1000 * 60 * 60 * 24)) {
	
				var hh = dateObj.getHours();
				var mi = dateObj.getMinutes();
				var ss = dateObj.getSeconds();
	
				return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
						':', (ss > 9 ? '' : '0') + ss ].join('');
	
			} else {
				var yy = dateObj.getFullYear();
				var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
				var dd = dateObj.getDate();
	
				return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
						(dd > 9 ? '' : '0') + dd ].join('');
			}
		};
	
	
	
	
	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};
	
})();


/*

$.ajax({
	url : "/sample/replies", //클라이언트가  요청을 보낼 서버의 URL 주소
	data : {name: "홍길동"}, //HTTP 요청과 함께 서버로 보낼 데이터
	type : "GET", //HTTP 요청 방식
	dataType : "json" //서버에 보내줄 데이터 타입
	
})
//HTTP 요청이 성공하면 요청한 데이터가 done() 메서드로 전달된다.
.done(function(json){
	$("<h1>").text(json.title).appendTo("body");
	$("<div class=\"content\">").html(json.html).appendTo("body");
})
//HTTP 요청이 실패하면 오류와 상태에 관한 정보가 fail() 메서드로 전달된다. 
.fail(function(xhr, status, errorThrown){
	$("#text").html("오류가 발생했습니다. <br>")
	.append("오류명 : " +errorThrown+"<br>")
	.append("상태 : " + status);
	
})
//HTTP 요청이 성공하거나 실패하는 것에 상관 없이 언제나 always() 메서드가 실행
.always(function(xhr,status){
	$("#text").html("요청이 완료되었습니다.");
});*/



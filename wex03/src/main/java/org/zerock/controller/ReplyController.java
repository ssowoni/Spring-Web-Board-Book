package org.zerock.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RestController
@RequestMapping("/replies")
@Log4j2
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;
	
	
	//1. 댓글 추가
	//@RequestBody는 요청(request) 내용(body)을 처리한다. 일반적인 파라미터 전달방식 사용 불가
	//@RequestBody를 적용해 json 데이터를 ReplyVo 타입으로 변환하도록 설정
	//consumes : 클라이언트가 서버에게 보내는 데이터 타입을 명시한다.
	//produces : 서버가 클라이언트에게 반환하는 데이터 타입을 명시한다.
	@PostMapping(value="/new", consumes = "application/json",
				produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		
		log.info("ReplyVO : " + vo);
		int insertCount = service.Register(vo);
		log.info("Reply Insert Count : " + insertCount);
		
		//만약 insetCount의 값이 1이면 성공, 아니면 에러!
		return insertCount == 1
				? new ResponseEntity<>("register success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	//2. 특정 게시물 댓글 목록 확인
	//ReplyPageDTO로 변경
	//@PathVariable : url 호출 시 전달된 매개변수 값 page를 int형 변수 page에 저장하겠다. 
	//매핑해줄 때 value에 있는 url의 {bno}값을 전달받아 아래 service.getList의 매개변수로 전달하겠다. 
	//ResponseEntity<ReplyPageDTO>를 반환하기 때문에 return에 반환형을 맞춰줘야한다. 
	@GetMapping(value="/pages/{bno}/{page}",
			produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") Long bno){
		
		Criteria cri = new Criteria(page,10); //page, amount
		log.info("get Reply List bno : " + bno);
		log.info("cri : " + cri);
		return new ResponseEntity<>(service.getListPage(cri, bno),HttpStatus.OK);
	}
	
	//3. 댓글 조회
	//@PathVariable :  url 호출 시 파라미터로 전달받은 value를 메서드의 파라미터로 받을 수 있게 해주는 어노테이션이다
	//즉) url 호출 시 전달된 매개변수 "rno" 값을 Long rno에 저장한다. 
	//produces = {MediaType.APPLICATION_JSON_VALUE}) 서버에서 클라이언트에 전송할 때 데이터 타입을 전달 안했더니 에러
	@GetMapping(value="/{rno}",
			produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
	
	log.info("get : " + rno);
	return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	
	}	
	
	//4. 댓글 삭제
	@DeleteMapping(value = "/{rno}")
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
		log.info("remove : " + rno);
		return service.remove(rno) == 1
				? new ResponseEntity<>("remove success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	//4. 댓글 수정
	//consumes : 클라이언트가 서버에게 보내는 데이터 형태 
	//produces : 서버가 클라이언트에게 보내는 데이터 형태 
	//@RequestBody : 클라이언트가 예를들어 웹페이지에서 보내는 json형태의 데이터를 ReplyVO로 형변환 하겠다. 
	//즉) 객체 형태로 사용이 가능하다. 
	//@PathVariable : url을 통해 전달된 매개변수 값을 지정한 형태의 값으로 저장해서 사용하겠다. 
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value="/{rno}"
					,consumes="application/json"
					,produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno){
				//url을 통해 입력받은 rno (댓글번호) 값을 vo에 저장한다.
				vo.setRno(rno);
				log.info("rno : " +rno);
				
				log.info("modify : " +vo);
				//해당하는 rno의 값의 내용들을 수정해준다.
				return service.modify(vo) == 1
				? new ResponseEntity<>("modify success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);						
	}
	
	
	//5.
	
	
	
	

}

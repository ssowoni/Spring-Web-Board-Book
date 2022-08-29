package org.zerock.controller;

import java.util.ArrayList;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleDTOList;
import org.zerock.domain.TodoDTO;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/sample/*")
@Log4j2
public class SampleController {
	
	@RequestMapping("")
	public void basic() {
		log.info("basic.....");
	}
	
	//get,post방식
	@RequestMapping(value = "/basic",  method= {RequestMethod.GET, RequestMethod.POST})
	public void basicGet() {
		log.info("basic get.....");
	}
	
	//get방식으로만
	@GetMapping("/basicOnlyGet")
	public void basicGet2() {
		log.info("basic get only get....");
	}
	
	//파라미터 값 받아서 출력 get방식이기에 url에 값 입력 가능
	@GetMapping("/ex01")
	public String ex01(SampleDTO dto) {
		log.info(""+dto);
		return "ex01";
	}
	
	//파라미터의 타입 선언, 파라미터로 사용된 변수의 이름과 전달되는 파라미터의 이름이 다른 경우 유용
	@GetMapping("/ex02")
	public String ex02(@RequestParam("name") String name, @RequestParam("age") int age) {
		log.info("name : " +name);
		log.info("age : " +age);
		return "ex02";
	}
	
	//동일한 이름의 파라미터가 여러 개 전달되는 경우
	@GetMapping("/ex02List")
	public String ex02List(@RequestParam("ids")ArrayList<String> ids) {
		log.info("ids : " +ids);
		return "ex02List";
	}
	
	//객체 리스트
	@GetMapping("/ex02Bean")
	public String ex02Bean(SampleDTOList list) {
		log.info("list dots: " + list);
		return "ex02Bean";
	}
	
	//binding 바인딩
	@GetMapping("/ex03")
	public String ex03(TodoDTO todo) {
		log.info("todo: " + todo);
		return "ex03";
	}
	
	//★ 모델어노테이션
	@GetMapping("/ex04")
	/*public String ex04(SampleDTO dto, int page) {
		log.info("dto: " + dto);
		log.info("page: " + page);
		
		return "/sample/ex04";
	}*/
	
	//모델에 담는 데이터는 -> 파라미터가 아니라 다른 곳(service, DB ,, )에서 발생한 데이터를 담는 용기
	//@ModelAttribute jsp에서 사용할 key값을 지정해준다 생각하면 되겠다. 
	// ex) @ModelAttribute("slist") SampleDTOList list 이렇게 파라미터로 지정되어 있다고 하면
	// SampleDTOList의 list라는 값들을 나는 slist라고 부를래 이런 의미 
	public String ex04(SampleDTO dto, @ModelAttribute("page") int page) {
		log.info("dto: " + dto);
		log.info("page: " + page);
		
		return "/sample/ex04";
	}
	
	//반환타입
	@GetMapping("/ex05")
	public void ex05() {
		log.info("/ex05........." );
	}
	
	//json
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("/ex06........." );
		SampleDTO dto =  new SampleDTO();
		dto.setAge(10);
		dto.setName("홍길동");
		
		return dto;
	}
	
	//ResponseEntity 타입
	@GetMapping("/ex07")
	public ResponseEntity<String> ex07(){
		log.info("/ex07........." );
		
		//{"name" : "홍길동"}
		String msg = "{\" name\" : \"홍길동\"}";
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/json;charset=UTF-8");
		
		return new ResponseEntity<>(msg, headers, HttpStatus.OK);
	}
	
	//파일 업로드
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("/exUpload........." );
	}
	
	//파일 업로드 - post방식
	@PostMapping("/exUploadPost")
	//files 파라미터 네임 exUpload.jsp에서 확인 가능
	public void exUploadPost(ArrayList<MultipartFile>files) {
		files.forEach(file -> {
			log.info("------------------" );
			log.info("name: " +file.getOriginalFilename() );
			log.info("size : " + file.getSize() );
		});
	}
	
}

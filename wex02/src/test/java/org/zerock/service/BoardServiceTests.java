package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class BoardServiceTests {
	
	@Setter(onMethod_ = @Autowired)
	public BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		
		BoardVO board = new BoardVO();
		board.setTitle("서비스 이용 새로 작성");
		board.setContent("서비스 이용 새로 작성 내용");
		board.setWriter("soso");
		service.register(board);
		
		log.info("생성된 게시물 번호 : " + board.getBno());
		
	}
	
//	@Test
//	public void testGetList() {
//		service.getList().forEach(board -> log.info(board));
//	}
	
	@Test
	public void testGetList() {
//		Criteria cri = new Criteria();
//		cri.setAmount(10);
//		cri.setPageNum(2);
//		service.getList(cri).forEach(board -> log.info(board));
		service.getList(new Criteria(2,10)).forEach(board -> log.info(board));
	}
	
	@Test
	public void testGet() {
		log.info(service.get(1L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board = service.get(1L);
		if(board == null){return;}
		
		board.setTitle("service 제목 수정");
		log.info("modify result " + service.modify(board));
		
	}
	
	@Test
	public void testDelete() {
		log.info("remove result ...." + service.remove(2L));
		
 	}

}

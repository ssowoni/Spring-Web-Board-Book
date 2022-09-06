package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j2
public class ReplayMapperTests {
	
	
	private Long[] bnoArr = {150L,149L,148L,147L,146L};
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}

	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
			//1%5=1 2%5=2 3%5=3 4%5=4 5%5=0
			//149, 148, 147, 146, 150 이렇게 bno 번호 지정
			vo.setBno(bnoArr[i%5]);
			vo.setReply("댓글테스트"+i);
			vo.setReplyer("replyer"+i);
			
			mapper.insert(vo);
			
		});
	}
	
	@Test
	public void testRead() {
		
		ReplyVO vo = mapper.read(5L);
		log.info(vo);
		
	}
	
	@Test
	public void testDelete() {
		
		Long targetRno = 1L;
		mapper.delete(targetRno);
		log.info("delete......"+ targetRno);
		
	}
	
	@Test
	public void testUpdate() {
		
//		ReplyVO vo = new ReplyVO();
//		vo.setRno(2L);
//		vo.setReply("변경된 댓글입니다.");
//		mapper.update(vo);
		
		Long targetRno = 10L;
		ReplyVO vo2 = mapper.read(targetRno);
		vo2.setReply("변경된 댓글입니다.22");
		int count = mapper.update(vo2);
		log.info("update count : " + count);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testList2() {
		Criteria criteria = new Criteria(1,10);
		List<ReplyVO> replies = mapper.getListWithPaging(criteria, 148L);
		replies.forEach(reply -> log.info(reply));
	}
}

package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class TimeMapperTests {

	@Setter(onMethod_ =@Autowired)
	private TimeMapper timeMapper;
	
	@Test
	public void testGetTime() {
		log.info("time...........");
		log.info(timeMapper.getClass().getName());
		log.info(timeMapper.getTime());
	}

}

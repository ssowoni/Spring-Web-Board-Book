package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class ReplyServiceImpl implements ReplyService{

	//아래처럼 setter를 이용하거나 위에 @AllArgsConstructor 어노테이션을 추가만 해도 된다.
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int Register(ReplyVO vo) {
		log.info("register..."+ vo);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		
		log.info("get..."+ rno);
		return mapper.read(rno);		
		
	}

	@Override
	public int remove(Long rno) {
		log.info("remove..."+ rno);
		return mapper.delete(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify..."+ vo);
		return mapper.update(vo);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		
		log.info("get Reply List of a Board "+bno );
		return mapper.getListWithPaging(cri,bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(
				mapper.getCountByBno(bno),
				mapper.getListWithPaging(cri, bno)
				);
	}

}

package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insert(ReplyVO vo); //댓글 추가
	
	public ReplyVO read(Long rno); //댓글 조회
	
	public int delete(Long rno); //댓글 삭제
	
	public int update(ReplyVO vo); //댓글 수정
	
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri, @Param("bno") Long bno);
	
	public int getCountByBno(Long bno);

}

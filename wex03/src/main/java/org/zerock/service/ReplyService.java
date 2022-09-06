package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;

public interface ReplyService {
	
	public int Register(ReplyVO vo); //댓글 추가
	
	public ReplyVO get(Long rno); //댓글 조회
	
	public int remove(Long rno); //댓글 삭제
	
	public int modify(ReplyVO vo); //댓글 수정
	
	public List<ReplyVO> getList(Criteria cri, Long bno); //게시글 번호에 해당하는 댓글 조회
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	


}

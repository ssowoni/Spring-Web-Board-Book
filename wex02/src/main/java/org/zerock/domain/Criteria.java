package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
//Criteria는 '검색의 기준'을 의미한다.
public class Criteria {
	
	private int pageNum; //페이지 번호
	private int amount; // 한 페이지당 게시글 개수
	
	private String type;
	private String keyword;
	
	
	
	public Criteria() {
		this(1,10);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//BoardMapper.xml에서 type 문자열을 쪼개기 위한 메서드
	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
}

package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0)) *10;
		this.startPage = this.endPage -9;
		
		//realEnd의 값을 아래 주석과 같이 처리해서 마지막페이지 -1 만큼만 조회됐다. 괄호 조심! 
		//(int)((Math.ceil(total*1.0)/cri.getAmount()));
		int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));
		
		//this.endPage = realEnd <= endPage? realEnd :endPage;	
			
		if(realEnd<this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage >1;
		this.next = this.endPage <realEnd;
	}
}

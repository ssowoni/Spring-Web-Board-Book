package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
//모든 속성 사용하는 생성자 SampleVO(Integer, String, String)
@AllArgsConstructor
//비어있는 생성자 SampleVO()
@NoArgsConstructor
public class SampleVO {
	
	private Integer mno;
	private String firstName;
	private String lastName;
	

}

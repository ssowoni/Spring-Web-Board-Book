package org.zerock.domain;

import lombok.Data;

@Data
//만약 롬북을 사용하지 않았다면 생성자와 get/set 메서드를 각각 만들어줘야 했다. 
public class SampleDTO {
	private String name;
	private int age;
}

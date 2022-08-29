package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.RequiredArgsConstructor;

@Component
@Data
@RequiredArgsConstructor
public class Restaurant {

	//Autowired : 이 객체를 주입해주시겠나요, 연결해주시겠나요
	//@Setter(onMethod_ = @Autowired)
	private final Chef chef;

}

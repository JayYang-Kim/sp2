package com.sp.real;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("real.realController")
public class RealController {
	@RequestMapping(value="/real/main")
	public String main() throws Exception {
		return "real/main";
	}
	
	// 숫자 추출할때 사용
	private AtomicLong count = new AtomicLong(0); // 0부터 생성
	
	@RequestMapping(value="/real/info")
	@ResponseBody
	public Map<String, Object> info() throws Exception {
		Calendar cal = Calendar.getInstance();
		
		int hour = cal.get(Calendar.HOUR);
		int minute = cal.get(Calendar.MINUTE);
		int second = cal.get(Calendar.SECOND);
		
		long num = 0;
		
		try {
			num = count.incrementAndGet();
		} catch (Exception e) {
			
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("hour", hour);
		model.put("minute", minute);
		model.put("second", second);
		model.put("num", num);
		
		return model;
	}
}

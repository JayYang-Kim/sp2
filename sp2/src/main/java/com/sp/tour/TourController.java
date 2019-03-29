package com.sp.tour;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("tour.tourController")
public class TourController {
	@Autowired
	private TourService service;

	@RequestMapping(value = "/tour/main")
	public String main() throws Exception {
		return "tour/main";
	}

	@RequestMapping(value = "/tour/tour")
	public String tour(Model model) throws Exception {
		List<Tour> list = service.listSido();
		
		model.addAttribute("list", list);
		return "tour/tour";
	}

	@RequestMapping(value = "/tour/manage")
	public String manage(Model model) throws Exception {
		List<Tour> list = service.listSido();

		model.addAttribute("list", list);
		return "tour/manage";
	}
	
	
	@RequestMapping(value = "/tour/cityList")
	@ResponseBody
	public Map<String, Object> cityList(@RequestParam int snum) throws Exception {
		List<Tour> list = service.listCity(snum);

		Map<String, Object> model = new HashMap<>();
		model.put("listCity", list);
		
		return model;
	}
	
	@RequestMapping(value = "/tour/insertSido")
	@ResponseBody
	public Map<String, Object> insertSido(Tour dto) throws Exception {
		String s = "true";
		
		int result = service.insertSido(dto);
		if(result == 0) {
			s = "false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", s);
		model.put("snum", result);
		
		return model;
	}
	
	@RequestMapping(value = "/tour/insertCity", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertCity(Tour dto) throws Exception {
		int result = service.insertCity(dto);
		
		String state = "false";
		
		if(result != 0) {
			state = "true";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("cnum", result);
		
		return model;
	}
	
	@RequestMapping(value = "/tour/deleteSido", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteSido(@RequestParam int snum) throws Exception {
		int result = service.deleteSido(snum);
		
		String state = "false";
		
		if(result != 0) {
			state = "true";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value = "/tour/deleteCity", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteCity(@RequestParam int cnum) throws Exception {
		int result = service.deleteCity(cnum);
		
		String state = "false";
		
		if(result != 0) {
			state = "true";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		
		return model;
	}
}

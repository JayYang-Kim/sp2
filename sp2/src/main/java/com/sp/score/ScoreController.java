package com.sp.score;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;

@Controller("score.scoreController")
public class ScoreController {
	
	@Autowired
	private ScoreService scoreService;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/score/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value="searchKey", defaultValue="hak") String searchKey,
			@RequestParam(value="searchValue", defaultValue="") String searchValue,
			HttpServletRequest req,
			Model model) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
		int rows = 10;
		int dataCount, total_page;
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		dataCount = scoreService.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Score> list = scoreService.listScore(map);
		
		String cp = req.getContextPath();
		String url = cp + "/score/list";
		
		if(searchValue.length() != 0) {
			url += "?searchKey=" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String paging = myUtil.paging(current_page, total_page, url);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		
		return "score/list";
	}
	
	@RequestMapping(value="/score/insert", method=RequestMethod.GET)
	public String insertForm(Model model) {
		model.addAttribute("mode", "insert");
		return "score/write";
	}
	
	@RequestMapping(value="/score/insert", method=RequestMethod.POST)
	public String insertSubmit(Score dto) {
		
		scoreService.insertScore(dto);
		
		return "redirect:/score/list";
	}
	
	@RequestMapping(value="/score/delete", method=RequestMethod.GET)
	public String deleteScore(@RequestParam String hak, @RequestParam String page) {
		
		scoreService.deleteScore(hak);
		
		return "redirect:/score/list?page=" + page;
	}
	
	@RequestMapping(value="/score/deleteListScore", method=RequestMethod.POST)
	public String deleteListScore(@RequestParam List<String> haks, @RequestParam(defaultValue="1") String page) {
		
		scoreService.deleteListScore(haks);
		
		return "redirect:/score/list?page=" + page;
	}
	
	@RequestMapping(value="/score/read", method=RequestMethod.GET)
	public String readScore(@RequestParam String hak, @RequestParam String page, Score score, Model model) {
		
		score = scoreService.readScore(hak);
		
		model.addAttribute("dto", score);
		
		return "score/read";
	}
}

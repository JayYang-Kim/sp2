package com.sp.bbs;

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

@Controller("bbs.boardController")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="bbs/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="subject") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			@RequestParam(defaultValue="10") int rows,
			HttpServletRequest req,
			Model model) throws Exception {
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}

		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		dataCount = boardService.dataCount(map);
		
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		
		map.put("start", start);
		map.put("end", end);
		
		List<Board> list = boardService.listBoard(map);
		
		int listNum, n = 0;
		
		for(Board dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}
		
		String query = "rows=" + rows;
		String listUrl, articleUrl;
		
		if(searchValue.length() != 0) {
			query += "&searchKey=" + searchKey + "&searchValue=" +
					URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String cp = req.getContextPath();
		listUrl = cp + "/bbs/list?" + query;
		articleUrl = cp + "/bbs/article?page=" + current_page + "&" + query;
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("rows", rows);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("searchKey", searchKey);
		model.addAttribute("searchValue", searchValue);
		
		return "bbs/list";
	}
	
	@RequestMapping(value="bbs/created", method=RequestMethod.GET)
	public String createdForm(Model model) {
		model.addAttribute("mode", "created");
		return "bbs/created";
	}
	
	@RequestMapping(value="bbs/created", method=RequestMethod.POST)
	public String createdSubmit(Board dto, HttpServletRequest req) {
		
		dto.setIpAddr(req.getRemoteAddr());
		
		boardService.insertBoard(dto);
		
		return "redirect:/bbs/list";
	}
	
	@RequestMapping(value="bbs/article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="subject") String searchKey,
			@RequestParam(defaultValue="") String searchValue,
			@RequestParam int rows,
			Model model) throws Exception {
		
		// 검색값 디코딩
		searchValue = URLDecoder.decode(searchValue, "UTF-8");
		
		// 이전글, 다음글, 리스트에서 사용할 파라미터
		String query = "page=" + page + "&rows=" + rows;
		if(searchValue.length() != 0) {
			query += "&searchKey" + searchKey + "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8");
		}
		
		// 조회 수 증가
		boardService.updateHitCount(num);
		
		// 게시글 가져오기
		Board dto = null;
		dto = boardService.readBoard(num);
		
		// 게시글이 없으면 리스트로 리다이렉트
		if(dto == null) {
			return "redirect:/bbs/list?"+query;
		}
		
		// 글내용 엔터등을 <br>로 변경
		MyUtil myUtil = new MyUtil();
		dto.setContent(myUtil.htmlSymbols(dto.getContent()));
		
		// 이전글 가져오기
		Map<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("searchKey", searchKey);
		map.put("searchValue", searchValue);
		
		Board preBoard = boardService.preReadBoard(map);
		
		// 다음글 가져오기
		Board nextBoard = boardService.nextReadBoard(map);
		
		// 포워딩할 jsp에 넘길 데이터 dto, 이전글, 다음글, query, 페이지 번호, rows
		model.addAttribute("dto", dto);
		model.addAttribute("preReadBoard", preBoard);
		model.addAttribute("nextReadBoard", nextBoard);
		model.addAttribute("query", query);
		model.addAttribute("page", page);
		model.addAttribute("rows", rows);
		
		return "bbs/article";
	}
	
	@RequestMapping(value="bbs/update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int num,
			@RequestParam String page,
			@RequestParam int rows,
			Model model) {
		
		Board dto = boardService.readBoard(num);
		
		if(dto == null) {
			return "redirect:/bbs/list?page=" + page + "&rows=" + rows;
		}
		
		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("rows", rows);
		
		return "bbs/created";
	}
	
	@RequestMapping(value="bbs/update", method = RequestMethod.POST)
	public String updateSubmit(Board dto,
			@RequestParam String page,
			@RequestParam int rows) {
		
		boardService.updateBaord(dto);
		
		return "redirect:/bbs/list?page=" + page + "&rows=" + rows;
	}
	
	@RequestMapping(value="bbs/delete", method = RequestMethod.GET)
	public String updateSubmit(@RequestParam int num,
			@RequestParam String page,
			@RequestParam int rows,
			HttpServletRequest req) {
		
		if(req.getMethod().equalsIgnoreCase("POST")) {
			return "redirect:/bbs/list?page=" + page + "&rows=" + rows;
		}
		
		boardService.deleteBoard(num);
		
		return "redirect:/bbs/list?page=" + page + "&rows=" + rows;
	}
}

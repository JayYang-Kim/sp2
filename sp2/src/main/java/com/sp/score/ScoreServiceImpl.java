package com.sp.score;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("score.scoreService")
public class ScoreServiceImpl implements ScoreService {
	
	@Autowired
	private ScoreDAO scoreDAO;
	
	@Override
	public int insertScore(Score dto) {
		return scoreDAO.insertScore(dto);
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		return scoreDAO.dataCount(map);
	}

	@Override
	public List<Score> listScore(Map<String, Object> map) {
		return scoreDAO.listScore(map);
	}

	@Override
	public Score readScore(String hak) {
		return scoreDAO.readScore(hak);
	}

	@Override
	public int updateScore(Score dto) {
		return scoreDAO.updateScore(dto);
	}

	@Override
	public int deleteScore(String hak) {
		return scoreDAO.deleteScore(hak);
	}
}

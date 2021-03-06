package com.sp.score;

import java.util.List;
import java.util.Map;

public interface ScoreDAO {
	public int insertScore(Score dto);
	public int dataCount(Map<String, Object> map);
	public <T> List<T> listScore(Map<String, Object> map);
	public Score readScore(String hak);
	public int updateScore(Score dto);
	public int deleteScore(String hak);
	public int deleteListScore(List<String> list);
}

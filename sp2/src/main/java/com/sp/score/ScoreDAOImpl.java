package com.sp.score;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("score.scoreDAO") // DAO 객체 생성시는 @Repository를 통해 객체를 생성
public class ScoreDAOImpl implements ScoreDAO {
	
	@Autowired
	private SqlSession sqlsession;
	
	@Override
	public int insertScore(Score dto) {
		int result = 0;
		
		try {
			result = sqlsession.insert("score.insertScore", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		// selectOne : 쿼리 결과가 한줄인 경우, 사용
		try {
			result = sqlsession.selectOne("score.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public <T> List<T> listScore(Map<String, Object> map) {
		List<T> list = null;
		
		try {
			list = sqlsession.selectList("score.listScore", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Score readScore(String hak) {
		Score dto = null;
		
		try {
			dto = sqlsession.selectOne("score.readScore", hak);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int updateScore(Score dto) {
		int result = 0;
		
		try {
			result = sqlsession.update("score.updateScore", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int deleteScore(String hak) {
		int result = 0;
		
		try {
			result = sqlsession.delete("score.deleteScore", hak);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int deleteListScore(List<String> list) {
		int result = 0;
		
		try {
			result = sqlsession.delete("score.deleteListScore", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}

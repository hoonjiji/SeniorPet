package com.senior.pet.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.senior.pet.vo.Board_prefer;
import com.senior.pet.vo.Info_prefer;
import com.senior.pet.vo.Reply_prefer;

@Repository
public class PreferDAO {

	@Autowired
	SqlSession sqlSession;
	
	public Board_prefer checkbp(Board_prefer bp) {
		PreferMapper mapper = sqlSession.getMapper(PreferMapper.class);
		return mapper.checkbp(bp);
	}
	
	public int insertbp(Board_prefer bp) {
		PreferMapper mapper = sqlSession.getMapper(PreferMapper.class);
		return mapper.insertbp(bp);
	}
	
	public Reply_prefer checkrp(Reply_prefer rp) {
		PreferMapper mapper = sqlSession.getMapper(PreferMapper.class);
		return mapper.checkrp(rp);
	}
	
	public int insertrp(Reply_prefer rp) {
		PreferMapper mapper = sqlSession.getMapper(PreferMapper.class);
		return mapper.insertrp(rp);
	}
	
	public Info_prefer checkip(Info_prefer ip) {
		PreferMapper mapper = sqlSession.getMapper(PreferMapper.class);
		return mapper.checkip(ip);
	}
	
	public int insertip(Info_prefer ip) {
		PreferMapper mapper  = sqlSession.getMapper(PreferMapper.class);
		return mapper.insertip(ip);
	}
}

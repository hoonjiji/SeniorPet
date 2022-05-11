package com.senior.pet.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.senior.pet.vo.Info;


@Repository
public class InfoDAO {

	@Autowired
	SqlSession sqlSession;
	
	public ArrayList<Info> getinfolist(HashMap<String, Object> map, int startRecord, int countPerPage){
		InfoMapper mapper = sqlSession.getMapper(InfoMapper.class);
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		return mapper.getinfolist(map, rb);
	}
	public ArrayList<Info> getinfo(){
		InfoMapper mapper = sqlSession.getMapper(InfoMapper.class);
		return mapper.getinfo();
	}
	
	public int countinfo(HashMap<String,Object> map) {
		InfoMapper mapper = sqlSession.getMapper(InfoMapper.class);
		return mapper.countinfo(map);
	}
	public int countinfo_prefer(String searchText) {
		InfoMapper mapper = sqlSession.getMapper(InfoMapper.class);
		return mapper.countinfo_prefer(searchText);
	}
	public int writeinfo(Info info) {
		InfoMapper mapper = sqlSession.getMapper(InfoMapper.class);
		return mapper.writeinfo(info);
	}
	
	public Info readinfo(int infonum) {
		InfoMapper mapper = sqlSession.getMapper(InfoMapper.class);
		return mapper.readinfo(infonum);
	}
	//게시글 수정
	public int updateinfo(Info info) {
		InfoMapper mapper = sqlSession.getMapper(InfoMapper.class);
		return mapper.updateinfo(info);
	}
	//게시글 삭제
	public int deleteinfo(int infonum) {
		InfoMapper mapper = sqlSession.getMapper(InfoMapper.class);
		return mapper.deleteinfo(infonum);
	}
	//추천수 증가(게시글)
		public int updategood(int infonum) {
			InfoMapper mapper = sqlSession.getMapper(InfoMapper.class);
			return mapper.updategood(infonum);
		}
}

package com.senior.pet.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.senior.pet.vo.locations;

@Repository
public class MapDAO {
	@Autowired
	SqlSession sqlSession;
	
	public ArrayList<locations> mapByAd(String address,int startRecord, int countPerPage){
		LocationsMapper mapper = sqlSession.getMapper(LocationsMapper.class);
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		return mapper.mapByAd(address,rb);
	}
	public ArrayList<locations> mapBySearch(String searchText, int startRecord, int countPerPage){
		LocationsMapper mapper = sqlSession.getMapper(LocationsMapper.class);
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		return mapper.mapBySearch(searchText, rb);
	}
	
	public int getTotalByAd(String address){
		LocationsMapper mapper = sqlSession.getMapper(LocationsMapper.class);
		
		return mapper.getTotalByAd(address);
	}
	public int getTotalBySearch(String searchText) {
		LocationsMapper mapper = sqlSession.getMapper(LocationsMapper.class);
		return mapper.getTotalBySearch(searchText);
	}
}

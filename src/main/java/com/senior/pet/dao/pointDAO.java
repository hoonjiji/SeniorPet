package com.senior.pet.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.senior.pet.vo.Point;

@Repository
public class pointDAO {

	@Autowired
	SqlSession sqlSession;
	
	public int insertpoint(Point point) {
		PointMapper mapper = sqlSession.getMapper(PointMapper.class);
		return mapper.insertpoint(point);
	}
	public ArrayList<Point> selectpointbyid(String id){
		PointMapper mapper = sqlSession.getMapper(PointMapper.class);
		return mapper.selectpointbyid(id);
	}
	public int selectpoint(Point point) {
		PointMapper mapper = sqlSession.getMapper(PointMapper.class);
		return mapper.selectpoint(point);
	}
	
	public int deletepoint(String limitday) {
		PointMapper mapper = sqlSession.getMapper(PointMapper.class);
		return mapper.deletepoint(limitday);
	}
	
	public int sumpoint(String id) {
		PointMapper mapper = sqlSession.getMapper(PointMapper.class);
		return mapper.sumpoint(id);
	}
	public int subpoint(String id) {
		PointMapper mapper = sqlSession.getMapper(PointMapper.class);
		return mapper.subpoint(id);
	}
}

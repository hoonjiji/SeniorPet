package com.senior.pet.dao;

import java.util.ArrayList;
import java.util.Date;

import com.senior.pet.vo.Point;

public interface PointMapper {
	public int insertpoint(Point point);
	
	public ArrayList<Point> selectpointbyid(String id);
	
	public int selectpoint(Point point);
	
	public int deletepoint(String limitday);
	
	public int sumpoint(String id);
	
	public int subpoint(String id);
}

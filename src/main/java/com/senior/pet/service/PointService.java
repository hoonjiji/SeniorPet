package com.senior.pet.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.senior.pet.dao.pointDAO;
import com.senior.pet.vo.Point;

@Service
public class PointService {
	@Autowired
	pointDAO dao;
	
	public HashMap<String, Object> selectpointbyid(String id){
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<Point> list = dao.selectpointbyid(id);
		if(list.size()<1) {
			map.put("Msg", "적립된 포인트가 없습니다.");
			return map;
		}
		map.put("list", list);
		return map;
	}
	
	public int sumpoint(String id) {
		int pluspoint = dao.sumpoint(id);
		
		int subpoint = dao.subpoint(id);
		
		return pluspoint-subpoint;
	}
}

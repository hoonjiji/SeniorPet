package com.senior.pet.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import com.senior.pet.vo.Info;


public interface InfoMapper {
	public ArrayList<Info> getinfolist(HashMap<String, Object> map, RowBounds rb);
	
	public ArrayList<Info> getinfo();
	//게시글 갯수
	public int countinfo(HashMap<String, Object> map);
	
	public int countinfo_prefer(String searchText);
	
	public int writeinfo(Info info);
	
	public Info readinfo(int infonum);
	
	public int updateinfo(Info info);
	
	public int deleteinfo(int infonum);
	//수 변동 관련
	public int updategood(int infonum);

}

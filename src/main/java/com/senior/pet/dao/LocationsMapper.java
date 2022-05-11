package com.senior.pet.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import com.senior.pet.vo.locations;

public interface LocationsMapper {
	
	public ArrayList<locations> mapByAd(String address, RowBounds rb);
	public ArrayList<locations> mapBySearch(String searchText, RowBounds rb);
	//페이징 처리용
	public int getTotalByAd(String address);
	public int getTotalBySearch(String searchText);
}

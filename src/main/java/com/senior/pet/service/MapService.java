package com.senior.pet.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.senior.pet.dao.MapDAO;
import com.senior.pet.vo.locations;

@Service
public class MapService {
	@Autowired
	MapDAO dao;
	
	public ArrayList<locations> mapByAd(String address, int startRecord, int countPerPage){
			
		return dao.mapByAd(address, startRecord, countPerPage);
	}
	public ArrayList<locations>mapBySearch(String searchText, int startRecord, int countPerPage){
		return dao.mapBySearch(searchText, startRecord, countPerPage);
	}
	
	public int getTotalByAd(String address) {
		
		return dao.getTotalByAd(address);
	}
	public int getTotalBySearch(String searchText) {
		return dao.getTotalBySearch(searchText);
	}
}

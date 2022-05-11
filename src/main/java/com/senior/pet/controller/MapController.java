package com.senior.pet.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.senior.pet.service.MapService;
import com.senior.pet.util.PageNavigator;
import com.senior.pet.vo.locations;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class MapController {
	@Autowired
	MapService service;
	
	final int countPerPage =5;
	final int pagePerGroup =5;
	@RequestMapping(value="map", method = RequestMethod.GET)
	public String map() {
			
		return "map/map";
	}
	@ResponseBody
	@RequestMapping(value="location", method = RequestMethod.GET)
	public Map<String, Object> address(@RequestParam(value="page", defaultValue="1")int page,String address) {
		int total = service.getTotalByAd(address);
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		ArrayList<locations> loc = service.mapByAd(address,navi.getStartRecord(),navi.getCountPerPage());
		log.debug("테스트:{}",total);
		Map<String,Object> list = new HashMap<String, Object>();
		list.put("loc", loc);
		list.put("navi", navi);
		return list;
	}
	@ResponseBody
	@RequestMapping(value="search", method = RequestMethod.GET)
	public Map<String, Object> search(@RequestParam(value="page", defaultValue="1")int page
			, String searchText) {
		int total = service.getTotalBySearch(searchText);
		Map<String,Object> list = new HashMap<String, Object>();
		if(total<1) {
			list.put("Msg", "no");
			return list;
		}
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		ArrayList<locations> loc = service.mapBySearch(searchText, navi.getStartRecord(), navi.getCountPerPage());
		
		list.put("loc", loc);
		list.put("navi",navi);
		return list;
	}
}

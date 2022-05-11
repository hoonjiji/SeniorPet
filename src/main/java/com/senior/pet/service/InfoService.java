package com.senior.pet.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.senior.pet.dao.InfoDAO;
import com.senior.pet.dao.PreferDAO;
import com.senior.pet.vo.Info;
import com.senior.pet.vo.Info_prefer;


@Service
public class InfoService {
	@Autowired
	InfoDAO infodao;
	@Autowired
	PreferDAO preferdao;
	
	public ArrayList<Info> getinfolist(String type, String searchText, int startRecord, int countPerPage){
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(type.equals("인기")) {
			map.put("type", null);
			map.put("searchText", searchText);
			map.put("good", "good");
			return infodao.getinfolist(map, startRecord, countPerPage);
		}
		map.put("type", type);
		map.put("searchText", searchText);
		
		return infodao.getinfolist(map,startRecord,countPerPage);
	}
	
	public String writeinfo(Info info) {
		if(infodao.writeinfo(info)<1) {
			return "redirect:writeinfo";
		}
		return "redirect:info";
	}
	public int countinfo(String type, String searchText) {
		if(type.equals("인기")) {
			return infodao.countinfo_prefer(searchText);
		}
		HashMap<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("searchText", searchText);
		return infodao.countinfo(map);
	}
	public HashMap<String, Object> readinfo(int infonum, HttpSession session) {
		String path = "";
		String id = (String)session.getAttribute("loginId");
		Info info = infodao.readinfo(infonum);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(info!=null) {
			path = "info/read";
			map.put("path", path);
			map.put("info", info);
			if(id!=null) {
				Info_prefer ip = new Info_prefer();
				ip.setId(id);
				ip.setInfonum(infonum);
				if(preferdao.checkip(ip)!=null) {
					map.put("infoMsg", "이미 추천했습니다.");
					return map;
				}
				map.put("infoMsg", "");
				return map;
			}
			map.put("infoMsg","미등록");
			return map;
		}
		path = "redirect:info";
		map.put("path", path);
		return map;
	}
	//게시글 수정
	public String updateinfo(Info info,HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		String logintype = (String)session.getAttribute("loginType");
		int result;
		if(!(id.equals(info.getId())||logintype.equals("admin"))) {
				return "redirect:info";
		}
		result = infodao.updateinfo(info);
		if(result<1) {
			return "redirect:info";
		}
		return "redirect:readinfo?infonum="+info.getInfonum();
	}
	//게시글 삭제
	
	public String deleteinfo(int infonum, String id, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		String loginType = (String)session.getAttribute("loginType");
		int result;
		if(loginId.equals(id) || loginType.equals("admin")) {
			result = infodao.deleteinfo(infonum);
			if(result<1) {
				return "redirect:readinfo?infonum="+infonum;
			}
			return "redirect:info";
		}
		return "redirect:readinfo?infonum="+infonum;
	}
}

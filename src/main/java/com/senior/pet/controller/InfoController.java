	package com.senior.pet.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.senior.pet.service.InfoService;
import com.senior.pet.util.PageNavigator;
import com.senior.pet.vo.Info;

import lombok.extern.slf4j.Slf4j;


@Controller
public class InfoController {

	@Autowired
	InfoService service;
	
	final int countPerPage =10;
	final int pagePerGroup =5;

	//게시판 읽기
	@RequestMapping(value="info", method = RequestMethod.GET)
	public String infolist(Model model, @RequestParam(value = "type", defaultValue="")String type
			, @RequestParam(value="page", defaultValue="1")int page
			, @RequestParam(value="searchText",defaultValue="")String searchText) {
		int total = service.countinfo(type, searchText);
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		ArrayList<Info> list = service.getinfolist(type,searchText,navi.getStartRecord(),navi.getCountPerPage());
		
		model.addAttribute("list", list);
		model.addAttribute("navi",navi);
		model.addAttribute("type", type);
		model.addAttribute("searchText", searchText);
		return "info/info";
	}
	//글 쓰기
	@RequestMapping(value="writeinfo", method = RequestMethod.GET)
	public String writeinfo(HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		String type = (String)session.getAttribute("loginType");
		if(id == null || !(type.equals("admin"))) {
			return "redirect:info";
		}
		return "info/write";
	}
	@RequestMapping(value="writeinfo", method = RequestMethod.POST)
	public String writeinfo(Info info,HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		info.setId(id);
		String path = service.writeinfo(info);
		return path;
	}
	@RequestMapping(value="readinfo", method =RequestMethod.GET)
	public String readinfo(int infonum, Model model, HttpSession session) {
		HashMap<String, Object> map = service.readinfo(infonum,session);
		String path = (String)map.get("path");	
		if(map.containsKey("info")) {
			Info info = (Info)map.get("info");
			
			model.addAttribute("info", info);
			if(map.containsKey("infoMsg")) {
				String infoMsg = (String)map.get("infoMsg");
				model.addAttribute("infoMsg", infoMsg);
			}
		}
		return path;
	}
	
	//게시글 수정
	@RequestMapping(value="updateinfo", method = RequestMethod.GET)
	public String updateinfo(int infonum,HttpSession session ,Model model) {
		String id = (String)session.getAttribute("loginId");
		HashMap<String, Object> map = service.readinfo(infonum,session);
		if(map.containsKey("info")) {
			Info info = (Info)map.get("info");
			if(info.getId().equals(id)) {
			model.addAttribute("info", info);
			return "info/update";
			}
		}
		return "redirect:info";
	}
	@RequestMapping(value="updateinfo", method = RequestMethod.POST)
	public String updateinfo(Info info,HttpSession session) {
		String path = service.updateinfo(info, session);
		return path;
	}
	
	//게시글 삭제
	@RequestMapping(value = "deleteinfo", method = RequestMethod.GET)
	public String deleteinfo(int infonum,String id, HttpSession session) {
		String path = service.deleteinfo(infonum, id, session);
		return path;
	}
}

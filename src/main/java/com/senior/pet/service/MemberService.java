package com.senior.pet.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.senior.pet.dao.MemberDAO;
import com.senior.pet.vo.Alarm;
import com.senior.pet.vo.Member;

@Service
public class MemberService {

	@Autowired
	MemberDAO dao;
	
	public String login(Member member, HttpServletRequest request) {
		Member result = dao.login(member);
		if(result == null) {
			return "redirect:/";
		}
		LocalDate date = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd");
		String now = formatter.format(date);
		request.getSession().setAttribute("now", now);
		String path = request.getHeader("Referer");
		request.getSession().setAttribute("loginId", result.getId());
		request.getSession().setAttribute("loginType", result.getUsertype());
		request.getSession().setAttribute("alarmCount", dao.countalarm(result.getId()));
		return "redirect:"+path;
	}
	
	public HashMap<String, Object> memberlist(HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		String id = (String)session.getAttribute("loginId");
		String type = (String)session.getAttribute("loginType");
		if(id != null && type.equals("admin")) {
			ArrayList<Member> memberlist = dao.memberlist();
			map.put("list", memberlist);
			map.put("path", "member/list");
			return map;
		}
		map.put("path", "redirect:/");
		return map;
	}
	
	public String deletemember(String id) {
		if(dao.deletemember(id)<1) {
			return "redirect:/";
		}
		return "redirect:memberlist";
	}
	
	//Alarm jsp
	public HashMap<String, Object> selectalarm(String id){
		HashMap<String, Object>	map = new HashMap<String, Object>();
		ArrayList<Alarm>list = dao.selectalarm(id);
		if(list.size()<1) {
			map.put("Msg", "알람이 없습니다.");
			return map;
		}
		map.put("list", list);
		return map; 
	}
}

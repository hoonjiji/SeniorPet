package com.senior.pet.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.senior.pet.service.MemberService;
import com.senior.pet.vo.Member;

@Controller
public class MemberController {

	@Autowired
	MemberService service;
	@RequestMapping(value="login", method = RequestMethod.POST)
	public String login(Member member, HttpServletRequest request) {
		return service.login(member, request);
	}
	@RequestMapping(value="logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		String referer = request.getHeader("Referer");
		request.getSession().removeAttribute("loginId");
		request.getSession().removeAttribute("loginType");
		request.getSession().removeAttribute("alarmCount");
		return "redirect:"+referer;
	}
	@RequestMapping(value= "memberlist", method = RequestMethod.GET)
	public String memberlist(HttpSession session,Model model) {
		HashMap<String,Object> map = service.memberlist(session);
		String path = (String)map.get("path");
		if(map.containsKey("list")) {
			model.addAttribute("list", map.get("list"));
			return path;
		}
		return path;
	}
	@RequestMapping(value="deletemember", method = RequestMethod.GET)
	public String deletemember(String id,HttpSession session) {
		String type = (String)session.getAttribute("loginType");
		if(type.equals("admin")) {
			return service.deletemember(id);
		}
		return "redirect:/";
	}
	@RequestMapping(value="alarm",method = RequestMethod.GET)
	public String MyAlarm(HttpSession session,Model model) {
		String id = (String)session.getAttribute("loginId");
		if(id!=null) {
			HashMap<String, Object> map = service.selectalarm(id);
			if(map.containsKey("list")) {
				model.addAttribute("list", map.get("list"));
			}
			if(map.containsKey("Msg")) {
				model.addAttribute("Msg", map.get("Msg"));
			}
			return "member/alarm";
		}
		return "redirect:/";
	}
}

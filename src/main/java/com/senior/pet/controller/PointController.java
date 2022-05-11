package com.senior.pet.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.senior.pet.service.PointService;

@Controller
public class PointController {
	
	@Autowired
	PointService service;
	
	@RequestMapping(value="mypoint", method = RequestMethod.GET)
	public String Mypoint(HttpSession session,Model model) {
		String id = (String)session.getAttribute("loginId");
		if(id == null) {
			return "redirect:/";
		}
		HashMap<String, Object> map = service.selectpointbyid(id);
		if(map.containsKey("Msg")) {
			model.addAttribute("Msg", map.get("Msg"));
		}
		if(map.containsKey("list")) {
			model.addAttribute("list", map.get("list"));
		}
		model.addAttribute("sum", service.sumpoint(id));
		return "point/Mypoint";
	}
}

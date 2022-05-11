package com.senior.pet.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.senior.pet.service.PreferService;

@Controller
public class PreferController {
	@Autowired
	PreferService service;
	
	@RequestMapping(value="boardprefer", method= RequestMethod.POST)
	public String boardprefer(int boardnum,HttpSession session) {
		String path = service.boardprefer(boardnum, session);		
		return path;
	}
	@RequestMapping(value="replyprefer", method = RequestMethod.POST)
	public String replyprefer(int replynum, int boardnum, HttpSession session) {
		String path = service.replyprefer(replynum, boardnum, session);
		return path;
	}
	@RequestMapping(value="infoprefer", method = RequestMethod.POST)
	public String infoprefer(int infonum, HttpSession session) {
		String path = service.infoprefer(infonum, session);
		return path;
	}
}

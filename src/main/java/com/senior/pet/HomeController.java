package com.senior.pet;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.senior.pet.dao.BoardDAO;
import com.senior.pet.dao.InfoDAO;

/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {
	
	@Autowired
	BoardDAO boarddao;
	@Autowired
	InfoDAO infodao;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		model.addAttribute("boardlist", boarddao.getboard());
		model.addAttribute("infolist", infodao.getinfo());
		return "home";
	}
}

package com.senior.pet.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.senior.pet.dao.BoardDAO;
import com.senior.pet.dao.InfoDAO;
import com.senior.pet.dao.PreferDAO;
import com.senior.pet.dao.pointDAO;
import com.senior.pet.vo.Board_prefer;
import com.senior.pet.vo.Info_prefer;
import com.senior.pet.vo.Point;
import com.senior.pet.vo.Reply_prefer;

@Service
public class PreferService {
	@Autowired
	PreferDAO preferdao;
	@Autowired
	BoardDAO boarddao;
	@Autowired
	InfoDAO infodao;
	@Autowired
	pointDAO pointdao;
	
	public String boardprefer(int boardnum ,HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		String path = "redirect:read?boardnum="+boardnum;
		String inputdate = (String)session.getAttribute("now");
		if(id!=null) {
		Board_prefer bp = new Board_prefer();
		bp.setId(id);
		bp.setBoardnum(boardnum);
		
		if(preferdao.checkbp(bp)!=null) {	
			return path;
		}
		int result = preferdao.insertbp(bp);
		if(result>0) {
			boarddao.updategood(boardnum);
			//포인트 적립과정
			String gettype = "추천";
			Point point = new Point();
			point.setId(id);
			point.setGettype(gettype);
			point.setInputdate(inputdate);
			if(pointdao.selectpoint(point)<1) {
				point.setGetpoint(5);
				point.setInputtype("적립");
				pointdao.insertpoint(point);
			}
		}
		}
		return path;
	}
	
	public String replyprefer(int replynum, int boardnum, HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		String path = "redirect:read?boardnum="+boardnum;
		String inputdate = (String)session.getAttribute("now");
		if(id !=null) {
		Reply_prefer rp = new Reply_prefer();
		rp.setId(id);
		rp.setReplynum(replynum);
		if(preferdao.checkrp(rp)!=null) {
			return path;
		}
		int result = preferdao.insertrp(rp);
		if(result>0) {
		boarddao.updatereplygood(replynum);
		//포인트 적립과정
		String gettype = "추천";
		Point point = new Point();
		point.setId(id);
		point.setGettype(gettype);
		point.setInputdate(inputdate);
		if(pointdao.selectpoint(point)<1) {
			point.setGetpoint(5);
			point.setInputtype("적립");
			pointdao.insertpoint(point);
		}
		}
		}
		return path;
	}
	
	public String infoprefer(int infonum, HttpSession session) {
		String id = (String) session.getAttribute("loginId");
		String path = "redirect:readinfo?infonum="+infonum;
		String inputdate = (String)session.getAttribute("now");
		if(id !=null) {
		Info_prefer ip = new Info_prefer();
		ip.setId(id);
		ip.setInfonum(infonum);
		if(preferdao.checkip(ip)!=null) {
			return path;
		}
		int result = preferdao.insertip(ip);
		if(result>0) {
			infodao.updategood(infonum);
			String gettype = "추천";
			Point point = new Point();
			point.setId(id);
			point.setGettype(gettype);
			point.setInputdate(inputdate);
			if(pointdao.selectpoint(point)<1) {
				point.setGetpoint(5);
				point.setInputtype("적립");
				pointdao.insertpoint(point);
			}
		}
		}
		return path;
	}
}

	package com.senior.pet.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.senior.pet.dao.BoardDAO;
import com.senior.pet.dao.MemberDAO;
import com.senior.pet.dao.PreferDAO;
import com.senior.pet.dao.pointDAO;
import com.senior.pet.vo.Alarm;
import com.senior.pet.vo.Board;
import com.senior.pet.vo.Board_prefer;
import com.senior.pet.vo.Point;
import com.senior.pet.vo.Reply;
import com.senior.pet.vo.Reply_prefer;

@Service
public class BoardService {
	@Autowired
	BoardDAO dao;
	@Autowired
	MemberDAO memberdao;
	@Autowired 
	PreferDAO preferdao;
	@Autowired
	pointDAO pointdao;
	public HashMap<String,Object> getlist(String id, String type, String searchText, int startRecord, int countPerPage, HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<String>typelist = new ArrayList<String>(Arrays.asList("","자유","질문","꿀팁","상품후기","인기"));
		if(typelist.contains(type)) {
		if(type.equals("인기")) {
			map.put("id", "");
			map.put("type", "");
			map.put("searchText", searchText);
			map.put("good", "good");
			ArrayList<Board> list = dao.getlist(map, startRecord, countPerPage);
			if(list != null){
			map.put("list",list);
			}
			return map;
		}
		String loginId = (String)session.getAttribute("loginId");
		if(id.equals(loginId)) {
		map.put("id", id);
		map.put("type", type);
		map.put("searchText", searchText);
		map.put("list", dao.getlist(map, startRecord, countPerPage));
		return map;
		}
		if(id.equals("")){
			map.put("id", id);
			map.put("type", type);
			map.put("searchText", searchText);
			map.put("list", dao.getlist(map, startRecord, countPerPage));
			return map;
		}}
		map.put("type", "no");
		return map;
	}
	
	public String writeboard(Board board, HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		board.setId(id);
		if(dao.writeboard(board)<1) {
			return "redirect:write";
		}
		//포인트 적립 과정
		String gettype = "글쓰기";
		String inputdate = (String)session.getAttribute("now");
		Point point = new Point();
		point.setId(id);
		point.setGettype(gettype);
		point.setInputdate(inputdate);
		if(pointdao.selectpoint(point)<1) {
			point.setGetpoint(15);
			point.setInputtype("적립");
			pointdao.insertpoint(point);
		}
		return "redirect:board";
	}
	public int countboard(String id,String type, String searchText) {
		if(type.equals("인기")) {
			return dao.countboard_prefer(searchText);
		}
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("type", type);
		map.put("searchText", searchText);
		return dao.countboard(map);
	}
	public HashMap<String, Object> readboard(int boardnum, HttpSession session) {
		String path = "";
		String id = (String)session.getAttribute("loginId");
		Board board = dao.readboard(boardnum);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(board!=null) {
			path = "board/read";
			//조회수 1증가 시키기
			dao.updateread(boardnum);
			//이후 다시 board 검색
			board = dao.readboard(boardnum);
			map.put("path", path);
			map.put("board", board);
			if(id !=null) {
				//알람 확인 (수정)
				if(id.equals(board.getId())) {
					Alarm alarm = new Alarm();
					alarm.setBoardnum(boardnum);
					alarm.setId(id);
					memberdao.updatealarm(alarm);
					session.setAttribute("alarmCount", memberdao.countalarm(id));
				}
			Board_prefer bp = new Board_prefer();
			bp.setId(id);
			bp.setBoardnum(boardnum);
			if(preferdao.checkbp(bp) != null) {
				map.put("boardMsg", "이미");
				}else {
				map.put("boardMsg", "");
				}
			}else {
			map.put("boardMsg", "미등록");
			}
			return map;
		}
		path = "redirect:board";
		map.put("path", path);
		return map;
	}
	//게시글 수정
	public String updateboard(Board board,HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		int result;
		if(!(id.equals(board.getId()))) {
				return "redirect:board";
		}
		result = dao.updateboard(board);
		if(result<1) {
			return "redirect:board";
		}
		return "redirect:read?boardnum="+board.getBoardnum();
	}
	//게시글 삭제
	
	public String deleteboard(int boardnum, String id, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		String loginType = (String)session.getAttribute("loginType");
		int result;
		if(loginId.equals(id) || loginType.equals("admin")) {
			result = dao.deleteboard(boardnum);
			if(result<1) {
				return "redirect:read?boardnum="+boardnum;
			}
			return "redirect:board";
		}
		return "redirect:read?boardnum="+boardnum;
	}
	//댓글 읽기
	public HashMap<String, Object> replylist(int boardnum,HttpSession session ,int startRecord, int countPerPage){
		//댓글 읽기
		String id = (String) session.getAttribute("loginId");
		HashMap<String, Object> map = new HashMap<String, Object>();
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		ArrayList<Reply>replylist = dao.replylist(boardnum,rb);
		if(replylist.size() >0) {
		ArrayList<String> Msglist = new ArrayList<String>();
		if(id!=null) {
		for(Reply reply: replylist) {
			Reply_prefer rp = new Reply_prefer();
			rp.setId(id);
			rp.setReplynum(reply.getReplynum());
			if(preferdao.checkrp(rp)!= null) {
				Msglist.add("이미");
			}else {
				Msglist.add("");
			}
		}
		}else {
			for(int i = 0; i<replylist.size();i++) {
				Msglist.add("미등록");
			}
		}
		map.put("Msglist", Msglist);
		map.put("replylist", replylist);
		return map;
		}
		return map;
	}
	
	//댓글 쓰기
	public String writereply(Reply reply, HttpSession session) {
		if(!(reply.getId().equals(""))) {
		dao.writereply(reply);
		Board board = dao.readboard(reply.getBoardnum());
		String boardid = board.getId();
		String id = (String) session.getAttribute("loginId");
		if(!(boardid.equals(id))) {
			Alarm alarm = new Alarm();
			alarm.setBoardnum(reply.getBoardnum());
			alarm.setId(boardid);
			alarm.setContent("<div>"+reply.getId()+" 님이"+board.getTitle()+"에 댓글을 다셨습니다.</div>"+"<div>내용 : "+reply.getContent()+"</div>");
			memberdao.insertalarm(alarm);
		}
		//포인트 적립시키기 과정
		String inputdate  = (String)session.getAttribute("now");	
		String gettype = "댓글";
		Point point = new Point();
		point.setId(id);
		point.setGettype(gettype);
		point.setInputdate(inputdate);
		int result = pointdao.selectpoint(point);
		if(result <1) {
			point.setGetpoint(10);
			point.setInputtype("적립");
			pointdao.insertpoint(point);
		}
		return "redirect:read?boardnum="+reply.getBoardnum();
		}
		return "redirect:board";
	}
	//댓글 갯수 세기
	public int countreply(int boardnum) {
		int result = dao.countreply(boardnum);
		return result;
	}
	//댓글 삭제
	public String deletereply(int replynum, int boardnum, String id, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		String type = (String)session.getAttribute("loginType");
		String path = "";
		if(loginId.equals(id)||type.equals("admin")) {
			dao.deletereply(replynum);
		}
		path = "redirect:read?boardnum="+boardnum;
		return path;
	}
	
	//댓글 수정
	public String updatereply(Reply reply, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		String type = (String)session.getAttribute("loginType");
		if(loginId.equals(reply.getId())|| type.equals("admin")) {
			dao.updatereply(reply);
		}
		return "redirect:read?boardnum="+reply.getBoardnum();
	}
}

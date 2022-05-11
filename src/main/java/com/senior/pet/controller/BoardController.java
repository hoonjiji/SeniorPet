package com.senior.pet.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.senior.pet.service.BoardService;
import com.senior.pet.util.PageNavigator;
import com.senior.pet.vo.Board;
import com.senior.pet.vo.Reply;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class BoardController {
	
	@Autowired
	BoardService service;
	//게시판 읽기
	@RequestMapping(value="board", method = RequestMethod.GET)
	public String boardlist(Model model, @RequestParam(value = "type", defaultValue="")String type
			, @RequestParam(value="page", defaultValue="1")int page
			, @RequestParam(value="searchText",defaultValue="")String searchText
			, @RequestParam(value="id",defaultValue="")String id
			, HttpSession session
			) {
		int countPerPage =10;
		int pagePerGroup =5;
		int total = service.countboard(id,type, searchText);
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		HashMap<String, Object> map= service.getlist(id,type,searchText,navi.getStartRecord(),navi.getCountPerPage(),session);
		if(map.containsKey("list")) {
		model.addAttribute("list", map.get("list"));
		model.addAttribute("navi",navi);
		}
		if(map.get("type").equals("no")) {
			return "redirect:board";
		}
		if(id.equals("")||id.equals(session.getAttribute("loginId"))) {
			model.addAttribute("id", id);
			model.addAttribute("type", type);
			model.addAttribute("searchText", searchText);
			return "board/board";
		}
		if(!(id.equals(session.getAttribute("loginId")))){
			id = "";
			return "redirect:board";
		}
		return "board/board";
	}
	//글 쓰기
	@RequestMapping(value="write", method = RequestMethod.GET)
	public String write(HttpSession session) {
		String id = (String)session.getAttribute("loginId");
		if(id != null) {
		return "board/write";
		}
		return "redirect:board";
	}
	@RequestMapping(value="write", method = RequestMethod.POST)
	public String write(Board board,HttpSession session) {
		String path = service.writeboard(board, session);
		return path;
	}
	
	//CKEditor 이미지 올리기
	@Resource(name="uploadPath")
	private String uploadPath;
	@RequestMapping(value = "ckUpload", method = RequestMethod.POST)
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload) throws Exception {
		//랜덤 문자 생성(파일명 중복방지)
		UUID uid = UUID.randomUUID();
		
		OutputStream out = null;
		PrintWriter pw = null;
		//인코딩
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String fileName = upload.getOriginalFilename();
		byte[] bytes = upload.getBytes();
		
		String ckUploadPath = uploadPath +File.separator+uid+"_"+fileName;
		
		out = new FileOutputStream(new File(ckUploadPath));
		out.write(bytes);
		out.flush();
		
		pw = response.getWriter();
		
		String fileUrl = "/img/"+uid+"_"+fileName;
		pw.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
		pw.flush();
		return;
	}
	
	//게시글 읽기
	@RequestMapping(value="read", method =RequestMethod.GET)
	public String readboard(int boardnum,@RequestParam(value="page", defaultValue ="1")int page ,Model model, HttpSession session) {
		
		int countPerPage =5;
		int pagePerGroup =5;
		
		HashMap<String, Object> map = service.readboard(boardnum,session);
		String path = (String)map.get("path");	
		if(map.containsKey("board")) {
			Board board = (Board)map.get("board");
			
			model.addAttribute("board", board);
			//댓글 리스트 가져오기 ( boardnum 기준)
			
			if(map.containsKey("boardMsg")) {
				String boardMsg = (String)map.get("boardMsg");
				model.addAttribute("boardMsg", boardMsg);
			}
			
			int total = service.countreply(boardnum);
			PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
			model.addAttribute("navi", navi);
			HashMap<String, Object> rmap = service.replylist(boardnum, session, navi.getStartRecord(), navi.getCountPerPage());
			if(rmap.containsKey("replylist")) {
				ArrayList<Reply> replylist = (ArrayList<Reply>) rmap.get("replylist");
				model.addAttribute("replylist", replylist);
			}
			if(rmap.containsKey("Msglist")) {
				ArrayList<String> Msglist = (ArrayList<String>)rmap.get("Msglist");
				model.addAttribute("Msglist", Msglist);
			}
		}
		return path;
	}
	
	//게시글 수정(관리자는 불가)
	@RequestMapping(value="update", method = RequestMethod.GET)
	public String updateboard(int boardnum,HttpSession session ,Model model) {
		String id = (String)session.getAttribute("loginId");
		HashMap<String, Object> map = service.readboard(boardnum,session);
		if(map.containsKey("board")) {
			Board board = (Board)map.get("board");
			if(board.getId().equals(id)) {
			model.addAttribute("board", board);
			return "board/update";
			}
		}
		return "redirect:board";
	}
	@RequestMapping(value="update", method = RequestMethod.POST)
	public String updateboard(Board board,HttpSession session) {
		log.debug("test:{}",board);
		String path = service.updateboard(board, session);
		return path;
	}
	
	//게시글 삭제
	@RequestMapping(value = "delete", method = RequestMethod.GET)
	public String deleteboard(int boardnum,String id, HttpSession session) {
		String path = service.deleteboard(boardnum, id, session);
		return path;
	}
	
	//댓글 쓰기
	@RequestMapping(value="writereply", method = RequestMethod.POST)
	public String writereply(Reply reply,HttpSession session) {
		String path = service.writereply(reply,session);
		return path;
	}
	
	//댓글 삭제
	
	@RequestMapping(value="deletereply", method = RequestMethod.GET)
	public String deletereply(int replynum, int boardnum, String id,HttpSession session) {
		String path = service.deletereply(replynum, boardnum, id, session);
		return path;
	}
	@RequestMapping(value="updatereply", method = RequestMethod.POST)
	public String updatereply(Reply reply, HttpSession session) {
		log.debug("Reply:{}",reply);
		String path = service.updatereply(reply, session);
		return path;
	}
}

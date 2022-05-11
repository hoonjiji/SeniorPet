package com.senior.pet.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import com.senior.pet.vo.Board;
import com.senior.pet.vo.Reply;

public interface BoardMapper {
	
	public ArrayList<Board> getlist(HashMap<String, Object> map, RowBounds rb);
	
	public ArrayList<Board> getboard();
	//게시글 갯수
	public int countboard(HashMap<String, Object> map);
	
	public int countboard_prefer(String searchText);
	
	public int writeboard(Board board);
	
	public Board readboard(int boardnum);
	
	public int updateboard(Board board);
	
	public int deleteboard(int boardnum);
	//수 변동 관련
	public int updateread(int boardnum);
	
	public int updategood(int boardnum);
	
	public int updatereplygood(int replynum);
	//댓글
	public ArrayList<Reply> replylist(int boardnum,RowBounds rb);
	
	public int countreply(int boardnum);
	
	public int writereply(Reply reply);
	
	public int deletereply(int replynum);
	
	public int updatereply(Reply reply);
}

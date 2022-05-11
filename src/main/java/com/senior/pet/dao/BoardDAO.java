package com.senior.pet.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.senior.pet.vo.Board;
import com.senior.pet.vo.Reply;

@Repository
public class BoardDAO {

	@Autowired
	SqlSession sqlSession;
	
	public ArrayList<Board> getlist(HashMap<String, Object> map, int startRecord, int countPerPage){
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		return mapper.getlist(map, rb);
	}
	public ArrayList<Board> getboard(){
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.getboard();
	}
	
	public int countboard(HashMap<String,Object> map) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.countboard(map);
	}
	public int countboard_prefer(String searchText) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.countboard_prefer(searchText);
	}
	public int writeboard(Board board) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.writeboard(board);
	}
	
	public Board readboard(int boardnum) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.readboard(boardnum);
	}
	//게시글 수정
	public int updateboard(Board board) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.updateboard(board);
	}
	//게시글 삭제
	public int deleteboard(int boardnum) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.deleteboard(boardnum);
	}
	//조회수 증가
	public int updateread(int boardnum) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.updateread(boardnum);
	}
	//추천수 증가(게시글)
	public int updategood(int boardnum) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.updategood(boardnum);
	}
	//추천수 증가(댓글)
	public int updatereplygood(int replynum) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.updatereplygood(replynum);
	}
	//댓글 읽기
	public ArrayList<Reply> replylist(int boardnum,RowBounds rb){
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.replylist(boardnum,rb);
	}
	//댓글 갯수
	public int countreply(int boardnum) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.countreply(boardnum);
	}
	//댓글 쓰기
	public int writereply(Reply reply) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.writereply(reply);
	}
	
	//댓글 삭제
	public int deletereply(int replynum) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.deletereply(replynum);
	}
	//댓글 수정
	public int updatereply(Reply reply) {
		BoardMapper mapper = sqlSession.getMapper(BoardMapper.class);
		return mapper.updatereply(reply);
	}
}

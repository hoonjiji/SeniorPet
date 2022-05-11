package com.senior.pet.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.senior.pet.vo.Alarm;
import com.senior.pet.vo.Member;

@Repository
public class MemberDAO {

	@Autowired
	SqlSession sqlSession;
	
	public Member login(Member member) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.login(member);
	}
	
	public ArrayList<Member> memberlist(){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.memberlist();
	}
	
	public int deletemember(String id) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.deletemember(id);
	}
	
	//Alarm
	public ArrayList<Alarm> selectalarm(String id){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.selectalarm(id);
	}
	public int countalarm(String id){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.countalarm(id);
	}
	public int insertalarm(Alarm alarm){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.insertalarm(alarm);
	}
	public int updatealarm(Alarm alarm){
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.updatealarm(alarm);
	}
}

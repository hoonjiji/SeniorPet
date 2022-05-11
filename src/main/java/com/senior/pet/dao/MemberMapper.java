package com.senior.pet.dao;

import java.util.ArrayList;

import com.senior.pet.vo.Alarm;
import com.senior.pet.vo.Member;

public interface MemberMapper {
	
	public Member login(Member member);
	
	public ArrayList<Member> memberlist();
	
	public int deletemember(String id);
	//Alarm 
	public ArrayList<Alarm> selectalarm(String id);
	
	public int countalarm(String id);
	
	public int insertalarm(Alarm alarm);
	
	public int updatealarm(Alarm alarm);
}

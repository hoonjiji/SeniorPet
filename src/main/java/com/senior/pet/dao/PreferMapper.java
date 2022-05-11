package com.senior.pet.dao;

import com.senior.pet.vo.Board_prefer;
import com.senior.pet.vo.Info_prefer;
import com.senior.pet.vo.Reply_prefer;

public interface PreferMapper {
	public Board_prefer checkbp(Board_prefer bp);
	
	public int insertbp(Board_prefer bp);
	
	public Reply_prefer checkrp(Reply_prefer rp);
	
	public int insertrp(Reply_prefer rp);
	
	public Info_prefer checkip(Info_prefer ip);
	
	public int insertip(Info_prefer ip);
}

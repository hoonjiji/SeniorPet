package com.senior.pet.vo;

import lombok.Data;

@Data
public class Alarm {
	private int alarmnum;
	private String id;
	private int boardnum;
	private String content;
	private String confirm; //확인유무: Y/N
	private String inputdate;
}

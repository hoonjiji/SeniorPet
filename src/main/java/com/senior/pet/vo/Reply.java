package com.senior.pet.vo;

import lombok.Data;

@Data
public class Reply {
	private int replynum;
    private String id;
    private int boardnum;
    private String content;
    private int good;
    private String inputdate;
}

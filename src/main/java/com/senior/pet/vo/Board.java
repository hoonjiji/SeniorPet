package com.senior.pet.vo;

import lombok.Data;

@Data
public class Board {
	private int boardnum;
    private String id;
    private String title;
    private String content;
    private String inputdate;
    private int good;
    private int read;
    private String type;
}

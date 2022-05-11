package com.senior.pet.vo;

import lombok.Data;

@Data
public class Orders {
	private int ordernum;
    private String id;
    private int ordercount;
    private int orderprice;
    private int pro_id;
    private String pro_name;
    private String orderdate;
    private String orderstatus;
}

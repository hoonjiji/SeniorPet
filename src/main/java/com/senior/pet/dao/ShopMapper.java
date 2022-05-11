package com.senior.pet.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import com.senior.pet.vo.Basket;
import com.senior.pet.vo.Orders;
import com.senior.pet.vo.Shopping;


public interface ShopMapper {
	// 검색 후의 총 글 갯수
	public int getTotal(String searchText);
	// 검색 후의 현재 페이지 목록
	public ArrayList<Shopping> shopList(String searchText, RowBounds rb);
	// 상품 타입에 따른 검색 후의 총 글 갯수
	public int getTotalByType(HashMap<String, Object> TT);
	// 상품 타입에 따른 검색 후의 현재 페이지 목록
	public ArrayList<Shopping> shopListByType(HashMap<String, Object> TT, RowBounds rb);
	// 단순 전체 상품 목록 조회
	public ArrayList<Shopping> justShopList();
	// 상품 번호로 상품 검색
	public Shopping getItem(int shopnum);
	// 상품 저장
	public int insertItem(Shopping item);
	// 상품 수정
	public int updateItem(Shopping item);
	// 글 번호로 해당 상품 삭제
	public int deleteItem(int shopnum);
	// 상품 주문 시 상품 재고량 수정
	public int updateStock(Shopping item);
	// 고객 찜 목록 등록
	public int insertBasket(Basket myItem);
	// 내 찜 목록 조회
	public ArrayList<Basket> selectMyBasket(String id);
	// 장바구니 번호를 사용하여 찜 상품 조회
	public Basket myBasketItem(Basket basket);
	// 장바구니 번호를 받아서 장바구니 목록 삭제
	public int deleteBasekt(Basket basket);
	// 관리자를 위한 전체 주문 목록 조회
	public ArrayList<Orders> selectOrderList();
	// 사용자를 위한 내 주문 목록 조회
	public ArrayList<Orders> selectMyOrders(String id);
	// 주문번호를 사용하여 주문 조회
	public Orders selectOrder(int ordernum);
	// 들어온 주문 저장
	public int insertOrder(Orders order);
	// 주문 삭제
	public int deleteOrder(int ordernum);
	// 주문 상태 변경
	public int updateStatus(Orders order);
}

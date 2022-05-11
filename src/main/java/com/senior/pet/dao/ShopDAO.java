package com.senior.pet.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.senior.pet.dao.ShopMapper;
import com.senior.pet.vo.Basket;
import com.senior.pet.vo.Orders;
import com.senior.pet.vo.Shopping;

@Repository
public class ShopDAO {
	@Autowired
	SqlSession sqlSession;
	
	public int getTotal(String searchText){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int total = mapper.getTotal(searchText);
		return total;
	}
	public ArrayList<Shopping> shopList(String searchText, int startRecord, int countPerPage){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		
		ArrayList<Shopping> shoplist = mapper.shopList(searchText, rb);
		
		return shoplist;
	}
	public int getTotalByType(HashMap<String, Object> TT){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int total = mapper.getTotalByType(TT);
		return total;
	}
	public ArrayList<Shopping> shopListByType(HashMap<String, Object> TT, int startRecord, int countPerPage){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		
		ArrayList<Shopping> shoplist = mapper.shopListByType(TT, rb);
		
		return shoplist;
	}
	public ArrayList<Shopping> justShopList(){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		ArrayList<Shopping> shopList = mapper.justShopList();
		return shopList;
	}
	
	@Transactional//(rollbackFor=NullPointerException.class)
	public Shopping getItem(int shopnum){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		Shopping getItem = mapper.getItem(shopnum);
		return getItem;
	}
	
	public int insertItem(Shopping item){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int result = mapper.insertItem(item);
		return result;
	}
	
	public int updateItem(Shopping item){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int result = mapper.updateItem(item);
		return result;
	}
	
	public int updateStock(Shopping item){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int result = mapper.updateStock(item);
		return result;
	}
	
	public int deleteItem(int shopnum){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int result = mapper.deleteItem(shopnum);
		
		return result;
	}
	
	public int insertBasket(Basket myItem){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int result = mapper.insertBasket(myItem);
		return result;
	}
	
	public ArrayList<Basket> selectMyBasket(String id){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		ArrayList<Basket> myBasket = mapper.selectMyBasket(id);
		return myBasket;
	}
	
	public Basket myBasketItem(Basket basket){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		Basket basketItem = mapper.myBasketItem(basket);
		return basketItem;
	}
	
	public int deleteBasekt(Basket basket){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int result = mapper.deleteBasekt(basket);
		return result;
	}
	
	public ArrayList<Orders> selectOrderList(){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		ArrayList<Orders> orderList = mapper.selectOrderList();
		return orderList;
	}
	
	public ArrayList<Orders> selectMyOrders(String id){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		ArrayList<Orders> myOrders = mapper.selectMyOrders(id);
		return myOrders;
	}
	
	public Orders selectOrder(int ordernum){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		Orders selectOrder = mapper.selectOrder(ordernum);
		return selectOrder;
	}
	
	public int insertOrder(Orders order){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int result = mapper.insertOrder(order);
		return result;
	}
	
	public int deleteOrder(int ordernum){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int result = mapper.deleteOrder(ordernum);
		return result;
	}
	
	public int updateStatus(Orders order){
		ShopMapper mapper = sqlSession.getMapper(ShopMapper.class);
		int result = mapper.updateStatus(order);
		return result;
	}
}

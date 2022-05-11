package com.senior.pet.controller;

import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.senior.pet.dao.ShopDAO;
import com.senior.pet.util.PageNavigator;
import com.senior.pet.vo.Basket;
import com.senior.pet.vo.Orders;
import com.senior.pet.vo.Shopping;
import com.senior.pet.util.FileService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("shop")
@Slf4j
public class ShoppingController {
	@Autowired
	ShopDAO dao;
	
	// 게시판 관련 상수값들
	final int countPerPage = 8;			// 페이지 당 글 수
	final int pagePerGroup = 5;			// 페이지 이동 그룹 당 표시할 페이지 수
	final String uploadPath = "C:/DEV/image"; // 파일 업로드 경로
	
	@RequestMapping(value="shopMain", method=RequestMethod.GET)
	public String shopMain(Model model){
		
		return "shop/shopMain";
	}
	
	@RequestMapping(value="shopList", method=RequestMethod.GET)
	public String shopList(@RequestParam(value="page", defaultValue = "1") int page
						, @RequestParam(value="searchText", defaultValue = "") String searchText
						, @RequestParam(value="myBasketTotal", defaultValue = "0") int myBasketTotal
						, HttpSession session, Model model){
		String loginId = (String)session.getAttribute("loginId");
		myBasketTotal = 0;
		ArrayList<Basket> myBasket = dao.selectMyBasket(loginId);	// Id를 입력하여 고객 한 명의 모든 주문 목록을 조회
		for (Basket myBasketList : myBasket){
			myBasketTotal += 1;
		}
		// 페이지 계산을 위한 게시물 갯수 조회
		int total = dao.getTotal(searchText);
		log.debug("total:{}", total);
		
		// 페이징 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		ArrayList<Shopping> shopList = dao.shopList(searchText, navi.getStartRecord(), navi.getCountPerPage());
		
		model.addAttribute("shopList", shopList);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("myBasketTotal", myBasketTotal);
		
		return "shop/shopList";
	}
	
	@RequestMapping(value="typeItems", method=RequestMethod.GET)
	public String typeItems(@RequestParam(value="page", defaultValue = "1") int page
						, @RequestParam(value="searchText", defaultValue = "") String searchText
						, @RequestParam(value="myBasketTotal", defaultValue = "0") int myBasketTotal
						, String pro_type, HttpSession session, Model model){
		log.debug("pro_type:{}", pro_type);
		String loginId = (String)session.getAttribute("loginId");
		myBasketTotal = 0;
		ArrayList<Basket> myBasket = dao.selectMyBasket(loginId);	// Id를 입력하여 고객 한 명의 모든 주문 목록을 조회
		for (Basket myBasketList : myBasket){
			myBasketTotal += 1;
		}
		// 페이지 계산을 위한 게시물 갯수 조회
		//int total = dao.getTotal(searchText);
		HashMap<String, Object> TT = new HashMap<>();
		TT.put("pro_type", pro_type);
		TT.put("searchText", searchText);
		int total = dao.getTotalByType(TT);
		log.debug("totalByType:{}", total);
		log.debug("TT:{}", TT);
		
		// 페이징 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		//ArrayList<Shopping> shopList = dao.shopList(searchText, navi.getStartRecord(), navi.getCountPerPage());
		ArrayList<Shopping> shopList = dao.shopListByType(TT, navi.getStartRecord(), navi.getCountPerPage());
		
		// 검색어를 포함한 전체 shopList 중에서 jsp에서 입력받은 속성 타입과 일치하는 리스트만을 검색
		/*ArrayList<Shopping> typeItems = null;
		for (Shopping item : shopList) {
			if (item.getPro_type().equals(pro_type)) {
				typeItems.add(item);
			}
		}*/
		
		model.addAttribute("shopList", shopList);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("myBasketTotal", myBasketTotal);
		
		return "shop/shopList";
	}
	
	@RequestMapping(value="shopItem", method=RequestMethod.GET)
	public String shopItem(@RequestParam(value="page", defaultValue = "1") int page
						, @RequestParam(value="searchText", defaultValue = "") String searchText
						, @RequestParam(value="myBasketTotal", defaultValue = "0") int myBasketTotal
						, int shopnum, HttpSession session, Model model){
		Shopping item = dao.getItem(shopnum);
		if (item == null) {
			return "redirect:shopMain";
		}
		String loginId = (String)session.getAttribute("loginId");
		myBasketTotal = 0;
		ArrayList<Basket> myBasket = dao.selectMyBasket(loginId);	// Id를 입력하여 고객 한 명의 모든 주문 목록을 조회
		for (Basket myBasketList : myBasket){
			myBasketTotal += 1;
		}
		// 페이지 계산을 위한 게시물 갯수 조회
		int total = dao.getTotal(searchText);
		
		// 페이징 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		ArrayList<Shopping> shopList = dao.shopList(searchText, navi.getStartRecord(), navi.getCountPerPage());
		
		// 하지만 shopItem.jsp에서 페이징 처리는 사용하지 않음(단호)
		model.addAttribute("shopList", shopList);
		model.addAttribute("item", item);
		model.addAttribute("myBasketTotal", myBasketTotal);
		
		return "shop/shopItem";
	}
	
	@RequestMapping(value="insertBasket", method=RequestMethod.POST)
	public String insertbasket(@RequestParam(value="page", defaultValue = "1") int page
							, @RequestParam(value="searchText", defaultValue = "") String searchText
							, HttpSession session, Model model, int ordercount, int shopnum){
		
		Shopping item = dao.getItem(shopnum);
		
		// 주문량이 남은 수량보다 많은 시 돌려보냄
		if (ordercount > item.getStock()) {
			model.addAttribute("shopnum", shopnum);
			return "redirect:shopItem";
		}
		
		// Basket 객체에 주문 정보 저장
		Basket basket = new Basket();
		String loginId = (String)session.getAttribute("loginId");
		int orderprice = ordercount * item.getPrice();	// 총 가격 계산
		/*int nowStock = item.getStock() - ordercount;*/	// 현재 스톡에서 주문량을 뺄셈
		/*item.setStock(nowStock);*/	// Shopping 객체에 업데이트할 현재 남은 수량 내용
		
		basket.setId(loginId);
		basket.setOrdercount(ordercount);
		basket.setOrderprice(orderprice);
		basket.setPro_id(shopnum);
		basket.setPro_name(item.getPro_name());
		
		/*dao.updateStock(item);*/	// Shopping 객체에 주문 후 stock 업데이트
		int myBasketTotal = 0;		// 동일 Id의 개인이 주문한 주문 목록의 갯수
		int result = dao.insertBasket(basket);	// Basket 객체에 새로운 주문을 저장
		if (result > 0) {
			ArrayList<Basket> myBasket = dao.selectMyBasket(loginId);	// Id를 입력하여 고객 한 명의 모든 주문 목록을 조회
			for (Basket myBasketList : myBasket){
				myBasketTotal += 1;
			}
		}
		
		// 페이지 계산을 위한 게시물 갯수 조회
		int total = dao.getTotal(searchText);
		
		// 페이징 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		ArrayList<Shopping> shopList = dao.shopList(searchText, navi.getStartRecord(), navi.getCountPerPage());
		
		model.addAttribute("shopList", shopList);
		model.addAttribute("searchText", searchText);
		model.addAttribute("navi", navi);
		model.addAttribute("myBasketTotal", myBasketTotal);
		
		return "shop/shopList";
	}
	
	@RequestMapping(value="myBasket", method=RequestMethod.GET)
	public String myBasket(HttpSession session, Model model){
		String loginId = (String)session.getAttribute("loginId");
		// 장바구니 페이지에서 볼 자신이 찜한 모든 상품 목록
		ArrayList<Basket> myBasket = dao.selectMyBasket(loginId);
		
		model.addAttribute("myBasketList", myBasket);
		
		return "shop/myBasket";
	}
	
	@RequestMapping(value="basketDelete", method=RequestMethod.GET)
	public String basketDelete(HttpSession session, Model model, int basketnum){
		String loginId = (String)session.getAttribute("loginId");
		Basket basket = new Basket();
		basket.setBasketnum(basketnum);
		basket.setId(loginId);
		int result = dao.deleteBasekt(basket);
		if (result == 0) {
			model.addAttribute("errorMsg", "삭제 실패");
		}

		return "redirect:myBasket";
	}
	
	@RequestMapping(value="order", method=RequestMethod.POST)
	public String orderItem(HttpSession session, Model model){
		// 주문이 들어올 시 해당 로그인한 사람의 장바구니 목록을 조회하여 Orders객체에 저장
		String loginId = (String)session.getAttribute("loginId");
		ArrayList<Basket> myBasket = dao.selectMyBasket(loginId);
		// 주문목록 중 재고보다 많이 주문한 경우 주문실패
		for (Basket myItem : myBasket) {
			// 상품 아이디로 상품정보 조회
			Shopping item = dao.getItem(myItem.getPro_id());
			if (myItem.getOrdercount() > item.getStock()) {
				model.addAttribute("error", myItem.getPro_name() + "의 재고가 부족합니다. 죄송합니다.");
				return "redirect:myBasket";
			}
			// item 하나를 Order 객체에 담기
			Orders order = new Orders();
			order.setId(loginId);
			order.setOrdercount(myItem.getOrdercount());
			order.setOrderprice(myItem.getOrderprice());
			order.setPro_id(myItem.getPro_id());
			order.setPro_name(myItem.getPro_name());
			// 주문
			dao.insertOrder(order);
			// 장바구니에서 삭제
			dao.deleteBasekt(myItem);
			// 주문량만큼 Shopping에서 삭제
			Shopping itemStock = new Shopping();
			itemStock.setShopnum(item.getShopnum());
			itemStock.setStock(item.getStock() - order.getOrdercount());
			dao.updateStock(itemStock);
		}
		ArrayList<Orders> myOrder = dao.selectMyOrders(loginId);
		ArrayList<Orders> Orders = dao.selectOrderList();
		ArrayList<Shopping> shopList = dao.justShopList();
		model.addAttribute("myOrderList", myOrder);
		model.addAttribute("orderList", Orders);
		model.addAttribute("shopList", shopList);
		
		return "redirect:myPage";
	}
	
	@RequestMapping(value="myPage", method=RequestMethod.GET)
	public String itemList(HttpSession session, Model model){
		String loginId = (String)session.getAttribute("loginId");
		// 관리자 페이지에서 볼 모든 주문된 상품 목록
		ArrayList<Orders> orderList = dao.selectOrderList();
		// 관리자 페이지에서 볼 모든 등록된 상품 목록
		ArrayList<Shopping> shopList = dao.justShopList();
		// 사용자 페이지에서 볼 자신이 주문한 모든 상품 목록
		ArrayList<Orders> myOrderList = dao.selectMyOrders(loginId);
		
		model.addAttribute("myOrderList", myOrderList);
		model.addAttribute("orderList", orderList);
		model.addAttribute("shopList", shopList);
		
		return "shop/myPage";
	}
	
	@RequestMapping(value="itemStorage", method=RequestMethod.GET)
	public String itemStorage(){
		return "shop/itemStorage";
	}
	
	@RequestMapping(value="storage", method=RequestMethod.POST)
	public String storage(Shopping item, MultipartFile upload, HttpSession session, Model model){
		// 첨부파일이 있는 경우 지정된 경로에 파일을 저장
		String savefile = FileService.saveFile(upload, uploadPath);
		// 저장된 파일명을 Shopping 객체에 저장
		item.setPro_image(savefile);
		//shop 객체를 DB에 전달하여 insert
		dao.insertItem(item);
		
		String loginId = (String)session.getAttribute("loginId");
		ArrayList<Orders> orderList = dao.selectOrderList();
		ArrayList<Shopping> shopList = dao.justShopList();
		ArrayList<Orders> myOrderList = dao.selectMyOrders(loginId);
		
		model.addAttribute("myOrderList", myOrderList);
		model.addAttribute("orderList", orderList);
		model.addAttribute("shopList", shopList);
		
		return "shop/myPage";
	}
	
	@RequestMapping(value="itemUpdate", method=RequestMethod.GET)
	public String itemUpdate(Model model, int shopnum){
		Shopping item = dao.getItem(shopnum);
		model.addAttribute("item", item);
		return "shop/itemUpdate";
	}
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(Shopping item, MultipartFile upload, HttpSession session, Model model){
		log.debug("item:{}", item);
		log.debug("upload:{}", upload);
		String loginId = (String)session.getAttribute("loginId");
		Shopping oldItem = dao.getItem(item.getShopnum());
		// if (upload.equals(oldItem.getPro_image()))
		if (upload.isEmpty()){
			item.setPro_image(oldItem.getPro_image());
		}
		// 수정 시 새로운 첨부파일이 있을 때, 기존에 첨부파일이 있으면 기존 파일을 삭제하고 다시 업로드한다
		if (!upload.isEmpty()) {
			// 기존 글에서 첨부된 파일의 실제 저장된 이름을 가져온다
			String savedfile = oldItem.getPro_image();
			// 기존에 파일이 있으면 삭제한다.
			if (savedfile != null) {
				FileService.deleteFile(uploadPath + "/" + savedfile);
			}
			// 새로운 파일 업로드
			savedfile = FileService.saveFile(upload, uploadPath);
			// 수정 정보에 새로 저장된 파일명과 원래 파일명을 저장
			item.setPro_image(savedfile);
		}
		int result = dao.updateItem(item);
		if (result == 0) {
			return "redirect:/itemUpdate?shopnum="+item.getShopnum();
		}
		/*String savefile = FileService.saveFile(upload, uploadPath);
		item.setPro_image(savefile);
		int result = dao.updateItem(item);
		if (result == 0) {
			return "redirect:/itemUpdate?shopnum="+item.getShopnum();
		}
		
		String loginId = (String)session.getAttribute("loginId");*/
		ArrayList<Orders> orderList = dao.selectOrderList();
		ArrayList<Shopping> shopList = dao.justShopList();
		ArrayList<Orders> myOrderList = dao.selectMyOrders(loginId);
		
		model.addAttribute("myOrderList", myOrderList);
		model.addAttribute("orderList", orderList);
		model.addAttribute("shopList", shopList);
		
		return "shop/myPage";
	}
	
	@RequestMapping(value="deleteItem", method=RequestMethod.GET)
	public String delete(HttpSession session, Model model, int shopnum){
		// 첨부된 파일이 있으면 삭제
		String savedfile = dao.getItem(shopnum).getPro_image();
		int result = dao.deleteItem(shopnum);
		if (result != 0 && savedfile != null) {
			FileService.deleteFile(uploadPath + "/" + savedfile);
		}
		
		String loginId = (String)session.getAttribute("loginId");
		ArrayList<Orders> orderList = dao.selectOrderList();
		ArrayList<Shopping> shopList = dao.justShopList();
		ArrayList<Orders> myOrderList = dao.selectMyOrders(loginId);
		
		model.addAttribute("myOrderList", myOrderList);
		model.addAttribute("orderList", orderList);
		model.addAttribute("shopList", shopList);
		
		return "shop/myPage";
	}
	
	@RequestMapping(value="deleteOrder", method=RequestMethod.GET)
	public String deleteOrder(HttpSession session, Model model, int ordernum){
		log.debug("ordernum:{}", ordernum);
		Orders order = dao.selectOrder(ordernum);
		int shopnum = order.getPro_id();
		Shopping item = dao.getItem(shopnum);
		int result = dao.deleteOrder(ordernum);
		// 주문 취소 시, 취소된 상품의 주문 수 만큼을 Shopping 객체의 stock 변수에 추가
		if (result > 0){
			item.setStock(item.getStock() + order.getOrdercount());
			// 변경된 상품 정보를 갱신
			dao.updateItem(item);
		} else {
			model.addAttribute("errorMsg", "상품 취소를 실패하였습니다.");
		}
		
		String loginId = (String)session.getAttribute("loginId");
		ArrayList<Orders> orderList = dao.selectOrderList();
		ArrayList<Shopping> shopList = dao.justShopList();
		ArrayList<Orders> myOrderList = dao.selectMyOrders(loginId);
		
		model.addAttribute("myOrderList", myOrderList);
		model.addAttribute("orderList", orderList);
		model.addAttribute("shopList", shopList);
		
		return "shop/myPage";
	}
	
	@ResponseBody
	@RequestMapping(value="updateStatus", method=RequestMethod.POST, produces="apllication/text; charset=UTF-8")
	public Orders updateStatus(Orders order){
		log.debug("order:{}", order);
		Orders changedOrder = new Orders();
		if (order != null) {
			int result = dao.updateStatus(order);
			if (result > 0){
				changedOrder = dao.selectOrder(order.getOrdernum());
				log.debug("changedOrder:{}", changedOrder);
				return changedOrder;
			}
		}
		
		return changedOrder;
	}
	
	@RequestMapping(value="download", method=RequestMethod.GET)
	public String fileDownload(int shopnum, Model model, HttpServletResponse response){
		Shopping shop = dao.getItem(shopnum);
		log.debug("board:{}", shop);
		
		// 저장된 파일 경로
		String fullPath = uploadPath + "/" + shop.getPro_image();
		log.debug("getSavefile:{}", shop.getPro_image());
		
		// 서버의 파일을 읽을 입력스트림과 클라이언트에게 전달할 출력스트림
		FileInputStream filein = null;
		ServletOutputStream fileout = null;
		try {
			filein = new FileInputStream(fullPath);
			fileout = response.getOutputStream();
			
			// 스프링의 파일 관련 유틸
			FileCopyUtils.copy(filein, fileout);
			
			filein.close();
			fileout.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
}

package com.senior.pet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter{
	// 컨트롤러 실행 전 인터셉트
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		log.debug("LoginInterceptor 실행");
		
		// 세션에서 로그인 정보 읽기
		HttpSession session = request.getSession();
		log.debug("session:{}", session.getAttribute("loginId"));
		String loginId = (String)session.getAttribute("loginId");
		String loginName = (String)session.getAttribute("loginName");
		
		// 로그인 하지 않은 경우 로그인 페이지로 이동
		if (loginId == null) {
			// 절대경로 구하기
			log.debug("ContextPath:{}", request.getContextPath());
			
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		
		// 로그인 된 경우 컨트롤러로 이동
		return super.preHandle(request, response, handler);
	}
	
}

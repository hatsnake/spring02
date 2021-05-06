package com.hatsnake.spring02.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hatsnake.spring02.domain.CartDTO;
import com.hatsnake.spring02.service.CartService;

@Controller
@RequestMapping("/shop/cart")
public class CartController {
	
	@Inject
	private CartService cartService;
	
	//장바구니 추가
	@RequestMapping("/insert")
	public String insert(@ModelAttribute CartDTO dto, Principal principal) {
		
		String userId = null;
		
		if(principal != null) {	
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			userId = user.getUsername();		
		}

		dto.setUserId(userId);
		//장바구니에 기존 상품이 있는지 검사
		int count = cartService.countCart(dto.getProductId(), userId);

		//(count == 0) ? cartService.updateCart(dto) : cartService.insert(dto);
		if(count == 0) {
			//없으면 insert
			cartService.insert(dto);
		} else {
			//있으면 update
			cartService.updateCart(dto);
		}
		
		return "redirect:/shop/cart/list";
	}
	
	//장바구니 목록
	@RequestMapping("/list")
	public ModelAndView list(Principal principal, ModelAndView mav) {

		String userId = null;
		
		if(principal != null) {
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			userId = user.getUsername();	
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<CartDTO> list = cartService.listCart(userId);
		int sumMoney = cartService.sumMoney(userId);
		//장바구니 배송료(10만원 이상 => 무료, 미만 => 2500원)
		int fee = sumMoney >= 100000 ? 0 : 2500;
		map.put("list", list);
		map.put("count", list.size());
		map.put("sumMoney", sumMoney);
		map.put("fee", fee);
		map.put("allSum", sumMoney+fee);
		mav.setViewName("shop/cartList");
		mav.addObject("map", map);
		
		return mav;
	}
	
	//장바구니 수정
	@RequestMapping("/update")
	public String update(@RequestParam int[] amount, @RequestParam int[] productId, Principal principal) {
		
		String userId = null;
		
		if(principal != null) {
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			userId = user.getUsername();	
		}
		
		for(int i=0; i<productId.length; i++) {
			CartDTO dto = new CartDTO();
			dto.setUserId(userId);
			dto.setAmount(amount[i]);
			dto.setProductId(productId[i]);
			cartService.modifyCart(dto);
		}
		
		return "redirect:/shop/cart/list";
	}
	
	//장바구니 삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam int cartId) {
		cartService.delete(cartId);
		return "redirect:/shop/cart/list";
	}
}

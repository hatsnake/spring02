package com.hatsnake.spring02.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hatsnake.spring02.service.ProductService;

@Controller
@RequestMapping("/shop/product")
public class ProductController {
	@Inject
	private ProductService productService;
	
	//상품 전체 목록
	@RequestMapping("/list")
	public ModelAndView list(ModelAndView mav) {
		mav.setViewName("shop/productList");
		mav.addObject("list", productService.listProduct());
		return mav;
	}
	
	//상품 상세보기
	@RequestMapping("/detail/{productId}")
	public ModelAndView detail(@PathVariable("productId") int productId, ModelAndView mav) {
		mav.setViewName("shop/productDetail");
		mav.addObject("dto", productService.detailProduct(productId));
		return mav;
	}
}

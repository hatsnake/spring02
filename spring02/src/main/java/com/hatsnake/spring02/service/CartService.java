package com.hatsnake.spring02.service;

import java.util.List;

import com.hatsnake.spring02.domain.CartDTO;

public interface CartService {
	public List<CartDTO> listCart(String userId);
	public void insert(CartDTO dto);
	public void modifyCart(CartDTO dto);
	public void delete(int cartId);
	public int sumMoney(String userId);
	public int countCart(int productId, String userId);
	public void updateCart(CartDTO dto);
}

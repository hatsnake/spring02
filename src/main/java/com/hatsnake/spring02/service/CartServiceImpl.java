package com.hatsnake.spring02.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.hatsnake.spring02.dao.CartDAO;
import com.hatsnake.spring02.domain.CartDTO;

@Service
public class CartServiceImpl implements CartService {

	@Inject
	private CartDAO cartDao;
	
	@Override
	public List<CartDTO> listCart(String userId) {
		return cartDao.listCart(userId);
	}

	@Override
	public void insert(CartDTO dto) {
		cartDao.insert(dto);
	}

	@Override
	public void modifyCart(CartDTO dto) {
		cartDao.modifyCart(dto);
	}

	@Override
	public void delete(int cartId) {
		cartDao.delete(cartId);
	}

	@Override
	public int sumMoney(String userId) {
		return cartDao.sumMoney(userId);
	}

	@Override
	public int countCart(int productId, String userId) {
		return cartDao.countCart(productId, userId);
	}

	@Override
	public void updateCart(CartDTO dto) {
		cartDao.updateCart(dto);
	}

}

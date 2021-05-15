package com.hatsnake.spring02.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hatsnake.spring02.domain.CartDTO;

@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	private SqlSession sqlSession;
	
	//장바구니 목록
	@Override
	public List<CartDTO> listCart(String userId) {
		return sqlSession.selectList("cart.listCart", userId);
	}

	//장바구니 추가
	@Override
	public void insert(CartDTO dto) {
		sqlSession.insert("cart.insertCart", dto);
	}

	//장바구니 수정
	@Override
	public void modifyCart(CartDTO dto) {
		sqlSession.update("cart.modifyCart", dto);
	}

	//장바구니 삭제
	@Override
	public void delete(int cartId) {
		sqlSession.delete("cart.deleteCart", cartId);
	}

	//장바구니 금액 합계
	@Override
	public int sumMoney(String userId) {
		sqlSession.selectOne("cart.sumMoney", userId);
		return sqlSession.selectOne("cart.sumMoney", userId);
	}

	//장바구니 동일한 상품 레코드 확인
	@Override
	public int countCart(int productId, String userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productId", productId);
		map.put("userId", userId);
		return sqlSession.selectOne("cart.countCart", map);
	}

	//장바구니 상품수량 변경
	@Override
	public void updateCart(CartDTO dto) {
		sqlSession.update("cart.updateCart", dto);
	}

}

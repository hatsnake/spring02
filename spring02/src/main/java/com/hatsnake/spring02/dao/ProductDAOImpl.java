package com.hatsnake.spring02.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hatsnake.spring02.domain.ProductDTO;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Inject
	private SqlSession sqlSession;
	
	//상품목록
	@Override
	public List<ProductDTO> listProduct() {
		return sqlSession.selectList("product.listProduct");
	}
	
	//상품상세
	@Override
	public ProductDTO detailProduct(int productId) {
		return sqlSession.selectOne("product.detailProduct", productId);
	}

	//상품수정
	@Override
	public void updateProduct(ProductDTO dto) {
	
	}

	//상품삭제
	@Override
	public void deleteProduct(int productId) {

	}

}

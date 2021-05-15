package com.hatsnake.spring02.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.hatsnake.spring02.dao.ProductDAO;
import com.hatsnake.spring02.domain.ProductDTO;

@Service
public class ProductServiceImpl implements ProductService {

	@Inject
	ProductDAO productDao;
	
	//상품목록
	@Override
	public List<ProductDTO> listProduct() {
		return productDao.listProduct();
	}

	//상품상세
	@Override
	public ProductDTO detailProduct(int productId) {
		return productDao.detailProduct(productId);
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

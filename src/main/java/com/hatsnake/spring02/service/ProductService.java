package com.hatsnake.spring02.service;

import java.util.List;

import com.hatsnake.spring02.domain.ProductDTO;

public interface ProductService {
	public List<ProductDTO> listProduct();
	public ProductDTO detailProduct(int productId);
	public void updateProduct(ProductDTO dto);
	public void deleteProduct(int productId);
}

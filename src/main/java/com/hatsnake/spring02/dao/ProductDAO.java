package com.hatsnake.spring02.dao;

import java.util.List;

import com.hatsnake.spring02.domain.ProductDTO;

public interface ProductDAO {
	public List<ProductDTO> listProduct();
	public ProductDTO detailProduct(int productId);
	public void updateProduct(ProductDTO dto);
	public void deleteProduct(int productId);
}

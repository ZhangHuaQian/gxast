package com.cen.product.service.impl;

import com.cen.product.dao.productMapper;
import com.cen.product.entity.Product;
import com.cen.product.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

	@Autowired
	productMapper productMapper;

	@Override
	public int deleteByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return productMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Product record) {
		// TODO Auto-generated method stub
		return productMapper.insert(record);
	}

	@Override
	public int insertSelective(Product record) {
		// TODO Auto-generated method stub
		return productMapper.insertSelective(record);
	}

	@Override
	public int selectListCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return productMapper.selectListCount(map);
	}

	@Override
	public List<Product> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return productMapper.selectList(map);
	}

	@Override
	public Product selectByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return productMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Product record) {
		// TODO Auto-generated method stub
		return productMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Product record) {
		// TODO Auto-generated method stub
		return productMapper.updateByPrimaryKey(record);
	}

}

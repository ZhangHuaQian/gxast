package com.cen.product.service;


import java.util.List;
import java.util.Map;

import com.cen.product.entity.Product;

public interface ProductService {
	
	int deleteByPrimaryKey(String id);

    int insert(Product record);

    int insertSelective(Product record);
    
    int selectListCount(Map<String, Object> map);
    
  	List<Product> selectList(Map<String, Object> map);
  	
    Product selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Product record);

    int updateByPrimaryKey(Product record);

}

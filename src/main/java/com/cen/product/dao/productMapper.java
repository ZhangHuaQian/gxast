package com.cen.product.dao;

import java.util.List;
import java.util.Map;

import com.cen.product.entity.Product;

public interface productMapper {
    int deleteByPrimaryKey(String id);

    int insert(Product record);

    int insertSelective(Product record);

    Product selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Product record);

    int updateByPrimaryKey(Product record);

	List<Product> selectList(Map<String, Object> map);

	int selectListCount(Map<String, Object> map);

}
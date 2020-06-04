package com.cen.shopcar.dao;

import java.util.List;
import java.util.Map;

import com.cen.shopcar.entity.shopcar;

public interface shopcarMapper {
    int deleteByPrimaryKey(String id);

    int insert(shopcar record);

    int insertSelective(shopcar record);

    shopcar selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(shopcar record);

    int updateByPrimaryKey(shopcar record);

	List<shopcar> selectList(Map<String, Object> map);

	int deleteBat(Map<String, Object> map);

    /**
     * 删除购物车中选中的商品
     * @param carIdArr
     * @return
     */
    int deleteCheckedProduct(String[] carIdArr);
}
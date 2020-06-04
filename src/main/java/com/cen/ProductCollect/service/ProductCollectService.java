package com.cen.ProductCollect.service;

import java.util.List;
import java.util.Map;

import com.cen.ProductCollect.entity.ProductCollect;

/**
* @author cframework
* @version V1.0 2020-01-08
*/
public interface ProductCollectService<ProductCollect> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(ProductCollect record);

    int insertSelective(ProductCollect record);

    ProductCollect selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(ProductCollect record);

    //int updateByPrimaryKey(ProductCollect record);

    List<ProductCollect> selectList(Map<String, Object> paramMap);

    List<ProductCollect> selectListByUid(String uId);

    ProductCollect selectByUidAndPid(String uId,String pId);

}
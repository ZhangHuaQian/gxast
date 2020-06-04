package com.cen.sys.ItemWay.service;

import java.util.List;
import java.util.Map;

import com.cen.sys.ItemWay.entity.ItemWay;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
public interface ItemWayService<ItemWay> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(ItemWay record);

    int insertSelective(ItemWay record);

    ItemWay selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(ItemWay record);

    //int updateByPrimaryKey(ItemWay record);

    List<ItemWay> selectList(Map<String, Object> paramMap);

}
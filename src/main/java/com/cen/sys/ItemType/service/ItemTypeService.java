package com.cen.sys.ItemType.service;

import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
public interface ItemTypeService<ItemType> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(ItemType record);

    int insertSelective(ItemType record);

    ItemType selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(ItemType record);

    //int updateByPrimaryKey(ItemType record);

    List<ItemType> selectList(Map<String, Object> paramMap);

}
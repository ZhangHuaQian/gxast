package com.cen.sys.ItemBank.service;

import com.cen.sys.ItemBank.entity.ItemBank;

import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
public interface ItemBankService<ItemBank> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(ItemBank record);

    int insertSelective(ItemBank record);

    ItemBank selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(ItemBank record);

    //int updateByPrimaryKey(ItemBank record);

    List<ItemBank> selectList(Map<String, Object> paramMap);

    List<ItemBank> selectAll(Map<String,Object> param);

}
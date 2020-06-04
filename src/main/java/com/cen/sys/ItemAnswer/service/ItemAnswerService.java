package com.cen.sys.ItemAnswer.service;

import com.cen.sys.ItemAnswer.entity.ItemAnswer;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
public interface ItemAnswerService<ItemAnswer> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(ItemAnswer record);

    int insertSelective(ItemAnswer record);

    ItemAnswer selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(ItemAnswer record);

    //int updateByPrimaryKey(ItemAnswer record);

    List<ItemAnswer> selectList(Map<String, Object> paramMap);

    List<ItemAnswer> selectByUid(Integer uId);

    //批量插入
    int insertList (List<com.cen.sys.ItemAnswer.entity.ItemAnswer>list);

}
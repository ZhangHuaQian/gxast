package com.cen.sys.ItemUser.service;

import java.util.List;
import java.util.Map;

import com.cen.sys.ItemUser.entity.ItemUser;

/**
* @author cframework
* @version V1.0 2019-11-13
*/
public interface ItemUserService<ItemUser> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(ItemUser record);

    int insertSelective(ItemUser record);

    ItemUser selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(ItemUser record);

    //int updateByPrimaryKey(ItemUser record);

    List<ItemUser> selectList(Map<String, Object> paramMap);

    /**
     * 通过学生姓名，指导老师姓名及电话查询学生信息
     * @param param
     * @return
     */
    ItemUser selectByUnameAndTnameAndTtel(Map<String, Object> param);

}
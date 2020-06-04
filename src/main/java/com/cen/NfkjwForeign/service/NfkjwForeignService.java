package com.cen.NfkjwForeign.service;

import java.util.List;
import java.util.Map;

import com.cen.NfkjwForeign.entity.NfkjwForeign;

/**
* @author cframework
* @version V1.0 2020-05-15
*/
public interface NfkjwForeignService<NfkjwForeign> {

    int deleteByPrimaryKey(int id);

    int deleteLogicByIds(String ids);

    //int insert(NfkjwForeign record);

    int insertSelective(NfkjwForeign record);

    NfkjwForeign selectByPrimaryKey(int id);

    int updateByPrimaryKeySelective(NfkjwForeign record);

    //int updateByPrimaryKey(NfkjwForeign record);

    List<NfkjwForeign> selectList(Map<String, Object> paramMap);

    /**
     * 查询最后一条插入的资讯id
     * @return
     */
    NfkjwForeign selectLastInsertId();
}
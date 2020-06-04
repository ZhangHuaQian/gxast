package com.cen.jtyy.service;

import com.cen.jtyy.entity.Jtyy;

import java.util.List;
import java.util.Map;



/**
* @author cframework
* @version V1.0 2019-04-03
*/
public interface JtyyService {

    int deleteByPrimaryKey(int id);

    int insertSelective(Jtyy record);

    Jtyy selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Jtyy record);

    List<Jtyy> selectList(Map<String, Object> paramMap);
    int selectListCount(Map<String, Object> pmap);
    int batchInsert();
}
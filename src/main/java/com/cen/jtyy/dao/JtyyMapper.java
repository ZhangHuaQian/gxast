package com.cen.jtyy.dao;


import com.cen.jtyy.entity.Jtyy;

import java.util.List;
import java.util.Map;

public interface JtyyMapper  {
    int deleteByPrimaryKey(int id);

    int insertSelective(Jtyy record);

    Jtyy selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Jtyy record);

    List<Jtyy> selectList(Map<String, Object> paramMap);
    int selectListCount(Map<String, Object> pmap);
}
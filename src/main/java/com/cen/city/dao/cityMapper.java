package com.cen.city.dao;

import java.util.List;
import java.util.Map;

import com.cen.city.entity.city;

public interface cityMapper {
    int deleteByPrimaryKey(String id);

    int insert(city record);

    int insertSelective(city record);

    city selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(city record);

    int updateByPrimaryKey(city record);
    
    List<city> selectList(Map<String, Object> pmap);
    
    city selectByVid(String vid);
}
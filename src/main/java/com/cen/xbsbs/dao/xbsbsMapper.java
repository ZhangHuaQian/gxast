package com.cen.xbsbs.dao;

import java.util.List;
import java.util.Map;

import com.cen.xbsbs.entity.xbsbs;

public interface xbsbsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(xbsbs record);

    int insertSelective(xbsbs record);

    xbsbs selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(xbsbs record);

    int updateByPrimaryKey(xbsbs record);
    
    List<xbsbs> selectList(Map<String, Object> pmap);
}
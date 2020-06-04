package com.cen.sensitive.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cen.sensitive.entity.sensitive;

public interface sensitiveDao {
    int deleteByPrimaryKey(Integer id);

    int insert(sensitive record);

    int insertSelective(sensitive record);

    sensitive selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(sensitive record);

    int updateByPrimaryKey(sensitive record);
    
    List<String> selectAll();
    
    int selectByWords(@Param("words") String words);
    
    List<sensitive> selectList(Map<String, Object> pmap);

    int selectListCount(Map<String, Object> pmap);
}
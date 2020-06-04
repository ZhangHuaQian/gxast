package com.cen.collection.service;

import java.util.List;
import java.util.Map;

import com.cen.collection.entity.collection;

public interface CollectionService {
	int deleteByPrimaryKey(Integer id);

    int insert(collection record);

    int insertSelective(collection record);

    collection selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(collection record);

    int updateByPrimaryKey(collection record);
    
    collection selectByUidPid(Map<String, Object> map);
    
    List<collection>  selectList(Map<String, Object> map);
}

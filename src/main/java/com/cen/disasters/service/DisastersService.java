package com.cen.disasters.service;

import java.util.List;
import java.util.Map;

import com.cen.disasters.entity.Disasters;

public interface DisastersService {

	int deleteByPrimaryKey(Integer id);

    int insert(Disasters record);

    int insertSelective(Disasters record);

    Disasters selectByPrimaryKey(Integer id);

	List<Disasters> selectList(Map<String, Object> map);
	
	List<Disasters> selectAll(Map<String, Object> map);
	
	List<Disasters> findByName(Map<String, Object> map);

	int selectListCount(Map<String, Object> map);
    
    int updateByPrimaryKeySelective(Disasters record);

    int updateByPrimaryKey(Disasters record);
	
}

package com.cen.city.service;

import java.util.List;
import java.util.Map;

import com.cen.city.entity.city;

public interface cityService {
	 int deleteByPrimaryKey(String id);

	    int insert(city record);

	    int insertSelective(city record);

	    city selectByPrimaryKey(String id);

	    int updateByPrimaryKeySelective(city record);

	    int updateByPrimaryKey(city record);

		List<city> selectList(Map<String, Object> pmap);

		city selectByVid(String vid);
}

package com.cen.xbsbs.service;

import java.util.List;
import java.util.Map;

import com.cen.xbsbs.entity.xbsbs;

public interface xbsbsService {
	int deleteByPrimaryKey(Integer id);

	int insert(xbsbs record);

	int insertSelective(xbsbs record);

	xbsbs selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(xbsbs record);

	int updateByPrimaryKey(xbsbs record);

	List<xbsbs> selectList(Map<String, Object> pmap);
}

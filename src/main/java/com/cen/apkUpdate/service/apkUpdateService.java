package com.cen.apkUpdate.service;

import java.util.List;

import com.cen.apkUpdate.entity.ApkUpdate;

public interface apkUpdateService {
	int deleteByPrimaryKey(Integer id);

	int insert(ApkUpdate record);

	int insertSelective(ApkUpdate record);

	ApkUpdate selectByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(ApkUpdate record);

	int updateByPrimaryKey(ApkUpdate record);
	
    List<ApkUpdate> selectAll();

}

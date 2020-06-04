package com.cen.apkUpdate.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.apkUpdate.dao.ApkUpdateDao;
import com.cen.apkUpdate.entity.ApkUpdate;
import com.cen.apkUpdate.service.apkUpdateService;
@Service
@Transactional
public class apkUpdateServiceImpl implements apkUpdateService{
	
	@Autowired
	ApkUpdateDao ApkUpdateDao;
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return ApkUpdateDao.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(ApkUpdate record) {
		// TODO Auto-generated method stub
		return ApkUpdateDao.insert(record);
	}

	@Override
	public int insertSelective(ApkUpdate record) {
		// TODO Auto-generated method stub
		return ApkUpdateDao.insertSelective(record);
	}

	@Override
	public ApkUpdate selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return ApkUpdateDao.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(ApkUpdate record) {
		// TODO Auto-generated method stub
		return ApkUpdateDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(ApkUpdate record) {
		// TODO Auto-generated method stub
		return ApkUpdateDao.updateByPrimaryKey(record);
	}

	@Override
	public List<ApkUpdate> selectAll() {
		// TODO Auto-generated method stub
		return ApkUpdateDao.selectAll();
	}

}

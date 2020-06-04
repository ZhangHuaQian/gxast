package com.cen.operateLog.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.operateLog.dao.OperatelogDao;
import com.cen.operateLog.entity.Operatelog;
import com.cen.operateLog.service.OperatelogService;

@Service
@Transactional
public class OperateServicelogImpl implements OperatelogService{

	@Autowired
	OperatelogDao operatelogDao;
	

	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return operatelogDao.deleteByPrimaryKey(id);
	}


	public int insert(Operatelog record) {
		// TODO Auto-generated method stub
		return operatelogDao.insert(record);
	}


	public int insertSelective(Operatelog record) {
		// TODO Auto-generated method stub
		return operatelogDao.insertSelective(record);
	}


	public Operatelog selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return operatelogDao.selectByPrimaryKey(id);
	}


	public int updateByPrimaryKeySelective(Operatelog record) {
		// TODO Auto-generated method stub
		return operatelogDao.updateByPrimaryKeySelective(record);
	}


	public int updateByPrimaryKey(Operatelog record) {
		// TODO Auto-generated method stub
		return operatelogDao.updateByPrimaryKey(record);
	}


	public List<Operatelog> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return operatelogDao.selectList(map);
	}


	public int selectListCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return operatelogDao.selectListCount(map);
	}

	
	
}

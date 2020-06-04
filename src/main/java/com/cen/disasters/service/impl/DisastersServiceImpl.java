package com.cen.disasters.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.disasters.dao.DisastersDao;
import com.cen.disasters.entity.Disasters;
import com.cen.disasters.service.DisastersService;

@Service
@Transactional
public class DisastersServiceImpl implements DisastersService {

	@Autowired
	DisastersDao disastersDao;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return disastersDao.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Disasters record) {
		// TODO Auto-generated method stub
		return disastersDao.insert(record);
	}

	@Override
	public int insertSelective(Disasters record) {
		// TODO Auto-generated method stub
		return disastersDao.insertSelective(record);
	}

	@Override
	public Disasters selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return disastersDao.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Disasters record) {
		// TODO Auto-generated method stub
		return disastersDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Disasters record) {
		// TODO Auto-generated method stub
		return disastersDao.updateByPrimaryKey(record);
	}

	@Override
	public List<Disasters> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return disastersDao.selectList(map);
	}

	@Override
	public int selectListCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return disastersDao.selectListCount(map);
	}

	@Override
	public List<Disasters> selectAll(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return disastersDao.selectAll(map);
	}

	@Override
	public List<Disasters> findByName(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return disastersDao.findByName(map);
	}

}

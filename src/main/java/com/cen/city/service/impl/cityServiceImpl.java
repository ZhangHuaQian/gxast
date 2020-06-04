package com.cen.city.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.city.dao.cityMapper;
import com.cen.city.entity.city;
import com.cen.city.service.cityService;

@Service
@Transactional
public class cityServiceImpl implements cityService{
	
	@Autowired
	cityMapper cityMapper;
	
	@Override
	public int deleteByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return cityMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(city record) {
		// TODO Auto-generated method stub
		return cityMapper.insert(record);
	}

	@Override
	public int insertSelective(city record) {
		// TODO Auto-generated method stub
		return cityMapper.insertSelective(record);
	}

	@Override
	public city selectByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return cityMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(city record) {
		// TODO Auto-generated method stub
		return cityMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(city record) {
		// TODO Auto-generated method stub
		return cityMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<city> selectList(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return cityMapper.selectList(pmap);
	}

	@Override
	public city selectByVid(String vid) {
		// TODO Auto-generated method stub
		return cityMapper.selectByVid(vid);
	}

}

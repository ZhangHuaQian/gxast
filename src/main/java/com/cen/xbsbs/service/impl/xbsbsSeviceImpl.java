package com.cen.xbsbs.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.xbsbs.dao.xbsbsMapper;
import com.cen.xbsbs.entity.xbsbs;
import com.cen.xbsbs.service.xbsbsService;
@Service
@Transactional
public class xbsbsSeviceImpl implements xbsbsService{
	@Autowired
	xbsbsMapper xbsbMapper;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return xbsbMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(xbsbs record) {
		// TODO Auto-generated method stub
		return xbsbMapper.insert(record);
	}

	@Override
	public int insertSelective(xbsbs record) {
		// TODO Auto-generated method stub
		return xbsbMapper.insertSelective(record);
	}

	@Override
	public xbsbs selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return xbsbMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(xbsbs record) {
		// TODO Auto-generated method stub
		return xbsbMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(xbsbs record) {
		// TODO Auto-generated method stub
		return xbsbMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<xbsbs> selectList(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return xbsbMapper.selectList(pmap);
	}

}

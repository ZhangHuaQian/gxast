package com.cen.collection.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.collection.dao.collectionMapper;
import com.cen.collection.entity.collection;
import com.cen.collection.service.CollectionService;


@Service
@Transactional
public class CollectionServiceImpl implements CollectionService{

	@Autowired
	collectionMapper collectionMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return collectionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(collection record) {
		// TODO Auto-generated method stub
		return collectionMapper.insert(record);
	}

	@Override
	public int insertSelective(collection record) {
		// TODO Auto-generated method stub
		return collectionMapper.insertSelective(record);
	}

	@Override
	public collection selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return collectionMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(collection record) {
		// TODO Auto-generated method stub
		return collectionMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(collection record) {
		// TODO Auto-generated method stub
		return collectionMapper.updateByPrimaryKey(record);
	}

	@Override
	public collection selectByUidPid(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return collectionMapper.selectByUidPid(map);
	}

	@Override
	public List<collection> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return collectionMapper.selectList(map);
	}

}

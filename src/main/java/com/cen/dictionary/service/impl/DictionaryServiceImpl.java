package com.cen.dictionary.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.dictionary.dao.DictionaryDao;
import com.cen.dictionary.entity.Dictionary;
import com.cen.dictionary.service.DictionaryService;

@Service
@Transactional
public class DictionaryServiceImpl implements DictionaryService {

	@Autowired
	DictionaryDao DictionaryDao;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return DictionaryDao.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Dictionary record) {
		// TODO Auto-generated method stub
		return DictionaryDao.insert(record);
	}

	@Override
	public List<Dictionary> selectType() {
		return DictionaryDao.selectType();
	}

	@Override
	public int insertSelective(Dictionary record) {
		// TODO Auto-generated method stub
		return DictionaryDao.insertSelective(record);
	}

	@Override
	public Dictionary selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return DictionaryDao.selectByPrimaryKey(id);
	}

	@Override
	public Dictionary selectByValue(String value) {
		return DictionaryDao.selectByValue(value);
	}

	@Override
	public int updateByPrimaryKeySelective(Dictionary record) {
		// TODO Auto-generated method stub
		return DictionaryDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Dictionary record) {
		// TODO Auto-generated method stub
		return DictionaryDao.updateByPrimaryKey(record);
	}

	@Override
	public List<Dictionary> selectByType() {
		return DictionaryDao.selectByType();
	}

	@Override
	public Dictionary selectByName(String record) {
		// TODO Auto-generated method stub
		return DictionaryDao.selectByName(record);
	}

	@Override
	public List<Dictionary> selectAll() {
		// TODO Auto-generated method stub
		return DictionaryDao.selectAll();
	}

	@Override
	public List<Dictionary> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return DictionaryDao.selectList(map);
	}

	@Override
	public int selectListCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return DictionaryDao.selectListCount(map);
	}
	
	

}

package com.cen.code.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.code.dao.codeMapper;
import com.cen.code.entity.code;
import com.cen.code.service.CodeService;

@Service
@Transactional
public class CodeServiceImpl implements CodeService{
	
	@Autowired
	codeMapper codeMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return codeMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(code record) {
		// TODO Auto-generated method stub
		return codeMapper.insert(record);
	}

	@Override
	public int insertSelective(code record) {
		// TODO Auto-generated method stub
		return codeMapper.insertSelective(record);
	}

	@Override
	public code selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return codeMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(code record) {
		// TODO Auto-generated method stub
		return codeMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(code record) {
		// TODO Auto-generated method stub
		return codeMapper.updateByPrimaryKey(record);
	}

	@Override
	public code selectByCode(String code) {
		// TODO Auto-generated method stub
		return codeMapper.selectByCode(code);
	}

	@Override
	public code selectByPassword(String password) {
		// TODO Auto-generated method stub
		return codeMapper.selectByPassword(password);
	}

}

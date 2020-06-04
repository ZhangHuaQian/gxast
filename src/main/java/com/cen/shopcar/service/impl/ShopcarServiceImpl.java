package com.cen.shopcar.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.shopcar.dao.shopcarMapper;
import com.cen.shopcar.entity.shopcar;
import com.cen.shopcar.service.ShopcarService;

@Service
@Transactional
public class ShopcarServiceImpl implements ShopcarService{

	@Autowired
	shopcarMapper shopcarMapper;

	@Override
	public int deleteByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return shopcarMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(shopcar record) {
		// TODO Auto-generated method stub
		return shopcarMapper.insert(record);
	}

	@Override
	public int insertSelective(shopcar record) {
		// TODO Auto-generated method stub
		return shopcarMapper.insertSelective(record);
	}

	@Override
	public shopcar selectByPrimaryKey(String id) {
		// TODO Auto-generated method stub
		return shopcarMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(shopcar record) {
		// TODO Auto-generated method stub
		return shopcarMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(shopcar record) {
		// TODO Auto-generated method stub
		return shopcarMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<shopcar> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return shopcarMapper.selectList(map);
	}

	@Override
	public int deleteBat(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return shopcarMapper.deleteBat(map);
	}

	@Override
	public int deleteCheckedProduct(String[] carIdArr) {
		return shopcarMapper.deleteCheckedProduct(carIdArr);
	}
}

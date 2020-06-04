package com.cen.news_axhd.service.impl;

import com.cen.news_axhd.dao.NewsAxhdMapper;
import com.cen.news_axhd.entity.NewsAxhd;
import com.cen.news_axhd.service.NewsAxhdService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class NewsAxhdServiceImpl implements NewsAxhdService {

	@Autowired
	NewsAxhdMapper newsAxhdMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return newsAxhdMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(NewsAxhd record) {
		// TODO Auto-generated method stub
		return newsAxhdMapper.insert(record);
	}

	@Override
	public int insertSelective(NewsAxhd record) {
		// TODO Auto-generated method stub
		return newsAxhdMapper.insertSelective(record);
	}

	@Override
	public NewsAxhd selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return newsAxhdMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(NewsAxhd record) {
		// TODO Auto-generated method stub
		return newsAxhdMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(NewsAxhd record) {
		// TODO Auto-generated method stub
		return newsAxhdMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<NewsAxhd> selectList(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return newsAxhdMapper.selectList(pmap);
	}

	@Override
	public int selectListCount(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return newsAxhdMapper.selectListCount(pmap);
	}

	@Override
	public List<NewsAxhd> selectNews(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return newsAxhdMapper.selectNews(pmap);
	}
	
}

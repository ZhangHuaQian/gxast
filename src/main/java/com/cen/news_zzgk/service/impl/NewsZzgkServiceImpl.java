package com.cen.news_zzgk.service.impl;


import com.cen.news_zzgk.dao.NewsZzgkMapper;
import com.cen.news_zzgk.entity.NewsZzgk;
import com.cen.news_zzgk.service.NewsZzgkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class NewsZzgkServiceImpl implements NewsZzgkService {

	@Autowired
	NewsZzgkMapper newsZzgkMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return newsZzgkMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(NewsZzgk record) {
		// TODO Auto-generated method stub
		return newsZzgkMapper.insert(record);
	}

	@Override
	public int insertSelective(NewsZzgk record) {
		// TODO Auto-generated method stub
		return newsZzgkMapper.insertSelective(record);
	}

	@Override
	public NewsZzgk selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return newsZzgkMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(NewsZzgk record) {
		// TODO Auto-generated method stub
		return newsZzgkMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(NewsZzgk record) {
		// TODO Auto-generated method stub
		return newsZzgkMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<NewsZzgk> selectList(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return newsZzgkMapper.selectList(pmap);
	}

	@Override
	public int selectListCount(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return newsZzgkMapper.selectListCount(pmap);
	}

	@Override
	public List<NewsZzgk> selectNews(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return newsZzgkMapper.selectNews(pmap);
	}
	
}

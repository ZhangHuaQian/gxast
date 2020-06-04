package com.cen.news.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.news.dao.NewsDao;
import com.cen.news.entity.News;
import com.cen.news.service.NewsService;

@Service
@Transactional
public class NewsServiceImpl implements NewsService{
	@Autowired
	NewsDao NewsDao;
	
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return NewsDao.deleteByPrimaryKey(id);
	}

	public int insert(News record) {
		// TODO Auto-generated method stub
		return NewsDao.insert(record);
	}

	public int insertSelective(News record) {
		// TODO Auto-generated method stub
		return NewsDao.insertSelective(record);
	}

	public News selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return NewsDao.selectByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(News record) {
		// TODO Auto-generated method stub
		return NewsDao.updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(News record) {
		// TODO Auto-generated method stub
		return NewsDao.updateByPrimaryKey(record);
	}

	public List<News> selectList(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return NewsDao.selectList(pmap);
	}

	public int selectListCount(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return NewsDao.selectListCount(pmap);
	}

	@Override
	public List<News> selectNews(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return NewsDao.selectNews(pmap);
	}

	@Override
	public int addPageview(News record) {
		return NewsDao.addPageview(record);
	}

	@Override
	public List<News> selectNewsNum(Map<String, Object> map) {
		return NewsDao.selectNewsNum(map);
	}

	@Override
	public List<Map> selectNewsByType(Map<String, Object> map) {
		return NewsDao.selectNewsByType(map);
	}

	@Override
	public List<News> selectByUid(Map<String, Object> param) {
		return NewsDao.selectByUid(param);
	}

	@Override
	public int selectCountByUid(Map<String, Object> param) {
		return NewsDao.selectCountByUid(param);
	}
}

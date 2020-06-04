package com.cen.praise.service.impl;

import com.cen.praise.dao.PraiseDao;
import com.cen.praise.entity.Praise;
import com.cen.praise.service.PraiseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class PraiseServiceImpl implements PraiseService {
	@Autowired
	private  PraiseDao praiseDao;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		return praiseDao.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Praise record) {
		return praiseDao.insert(record);
	}

	@Override
	public int insertSelective(Praise record) {
		return praiseDao.insertSelective(record);
	}

	@Override
	public Praise selectByPrimaryKey(Integer id) {
		return praiseDao.selectByPrimaryKey(id);
	}

	@Override
	public List<Praise> selectList(Map<String, Object> map) {
		return praiseDao.selectList(map);
	}

	@Override
	public int selectListCount(Map<String, Object> map) {
		return praiseDao.selectListCount(map);
	}

	@Override
	public int updateByPrimaryKeySelective(Praise record) {
		return praiseDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Praise record) {
		return praiseDao.updateByPrimaryKey(record);
	}

	@Override
	public List<Praise> findByUidAndNewsId(Map<String, Object> paramMap) {
		return praiseDao.findByUidAndNewsId(paramMap);
	}

	@Override
	public List<Praise> findByAid(int newsid) {
		return praiseDao.findByAid(newsid);
	}

	@Override
	public List<Praise> findByIpByAid(String ip, int newsid) {
		return praiseDao.findByIpByAid(ip,newsid);
	}

	@Override
	public List<Map> countNews(Map<String, Object> map) {
		return praiseDao.countNews(map);
	}
}

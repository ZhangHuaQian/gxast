package com.cen.iproll.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.iproll.dao.iprollDao;
import com.cen.iproll.entity.IpRoll;
import com.cen.iproll.service.iprollService;

@Service
@Transactional
public class iprollServiceImpl implements iprollService {

	@Autowired
	iprollDao iprollDao;
	
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return iprollDao.deleteByPrimaryKey(id);
	}

	public int insert(IpRoll record) {
		// TODO Auto-generated method stub
		return iprollDao.insert(record);
	}

	public int insertSelective(IpRoll record) {
		// TODO Auto-generated method stub
		return iprollDao.insertSelective(record);
	}

	public IpRoll selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return iprollDao.selectByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(IpRoll record) {
		// TODO Auto-generated method stub
		return iprollDao.updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(IpRoll record) {
		// TODO Auto-generated method stub
		return iprollDao.updateByPrimaryKey(record);
	}

	public List<IpRoll> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return iprollDao.selectList(map);
	}

	public int selectListCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return iprollDao.selectListCount(map);
	}

	public IpRoll selectByIp(String ip) {
		// TODO Auto-generated method stub
		return iprollDao.selectByIp(ip);
	}

}

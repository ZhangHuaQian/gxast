package com.cen.upms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.upms.dao.UserRoleDao;
import com.cen.upms.entity.UserRole;
import com.cen.upms.service.UserRoleService;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
@Service
@Transactional
public class UserRoleServiceImpl implements UserRoleService{
	@Autowired
	private UserRoleDao userRoleDao;
	
	@Override
	public int insertSelective(UserRole userRole) {
		return userRoleDao.insertSelective(userRole);
	}

	@Override
	public UserRole selectByPrimaryKey(Integer id) {
		return userRoleDao.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(UserRole userRole) {
		return userRoleDao.updateByPrimaryKeySelective(userRole);
	}

	@Override
	public int updateByUidSelective(UserRole userRole) {
		return userRoleDao.updateByUidSelective(userRole);
	}

}

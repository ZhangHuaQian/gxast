package com.cen.upms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.upms.dao.RoleDao;
import com.cen.upms.entity.Role;
import com.cen.upms.service.RoleService;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
@Service
@Transactional
public class RoleServiceImpl implements RoleService{
	@Autowired
	private RoleDao roleDao;
	
	public int insertSelective(Role record){
		return roleDao.insertSelective(record);
	}
	
	public Role selectByPrimaryKey(Integer id){
		return roleDao.selectByPrimaryKey(id);
	}

    public int updateByPrimaryKeySelective(Role record){
    	return roleDao.updateByPrimaryKeySelective(record);
    }

	@Override
	public List<Role> selectAll() {
		return roleDao.selectAll();
	}

	@Override
	public List<Role> selectByUid(String userid) {
		return roleDao.selectByUid(userid);
	}
}

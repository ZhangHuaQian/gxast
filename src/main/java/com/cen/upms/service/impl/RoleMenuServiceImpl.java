package com.cen.upms.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.upms.dao.RoleMenuDao;
import com.cen.upms.entity.RoleMenu;
import com.cen.upms.service.RoleMenuService;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
@Service
@Transactional
public class RoleMenuServiceImpl implements RoleMenuService{
	
	@Autowired
	private RoleMenuDao roleMenuDao;
	
	//@Override
	public int insertSelective(RoleMenu roleMenu) {
		return roleMenuDao.insertSelective(roleMenu);
	}

	//@Override
	public RoleMenu selectByPrimaryKey(Integer id) {
		return roleMenuDao.selectByPrimaryKey(id);
	}

	//@Override
	public int updateByPrimaryKeySelective(RoleMenu roleMenu) {
		return roleMenuDao.updateByPrimaryKeySelective(roleMenu);
	}

	//@Override
	public List<RoleMenu> selectByRoleCode(Integer id) {
		return roleMenuDao.selectByRoleCode (id);	
	}

	//@Override
	public void save(int rid, String mids) throws Exception{
		// 删除原来的数据(更改为删除状态)
		List<RoleMenu> list = roleMenuDao.selectByRoleCode(rid);
		for (RoleMenu roleMenu : list) {
			roleMenu.setIsDel(1); //更改为删除状态
			roleMenuDao.updateByPrimaryKeySelective(roleMenu);
		}
		
		//创建
		String[] midsList = mids.split(",");
		for (String mid : midsList) {
			RoleMenu roleMenu = new RoleMenu();
			roleMenu.setIsDel(0); //默认未删
			roleMenu.setCreateTime(new Date()); // 创建时间
			roleMenu.setRoleCode(Integer.toString(rid));
			roleMenu.setMenuCode(mid);
			roleMenuDao.insertSelective(roleMenu);
		}
	}

}

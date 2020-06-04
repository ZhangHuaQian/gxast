package com.cen.upms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.upms.dao.MenuDao;
import com.cen.upms.entity.Menu;
import com.cen.upms.service.MenuService;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
@Service
@Transactional
public class MenuServiceImpl implements MenuService{
	
	@Autowired
	private MenuDao menuDao;
	
	public int insertSelective(Menu record){
		return menuDao.insertSelective(record);
	}

	public Menu selectByPrimaryKey(Integer id){
		return menuDao.selectByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(Menu record){
		return menuDao.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<Menu> selectAll() {
		return menuDao.selectAll();
	}

	@Override
	public List<Menu> selectByRid(String rid) {
		return menuDao.selectByRid(rid);
	}

	@Override
	public List<Menu> selectPhoneByRid(String rid) {
		return menuDao.selectPhoneByRid(rid);
	}

}

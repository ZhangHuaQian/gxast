package com.cen.upms.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.upms.dao.DepartmentDao;
import com.cen.upms.entity.Department;
import com.cen.upms.entity.Role;
import com.cen.upms.service.DepartmentService;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
@Service("departmentService")
@Transactional
public class DepartmentServiceImpl implements DepartmentService{

	@Autowired
	private DepartmentDao departmentDao;

	@Override
	public int insertSelective(Department department) {
		return departmentDao.insertSelective(department);
	}

	@Override
	public Department selectByPrimaryKey(Integer id) {
		return departmentDao.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Department department) {
		return departmentDao.updateByPrimaryKeySelective(department);
	}

	@Override
	public List<Department> selectAll() {
		return departmentDao.selectAll();
	}

	@Override
	public List<Department> selectByThisUser(String did) {
		childMenu = new ArrayList<Department>();// 用户部门;
		List<Department> list = departmentDao.selectAll(); //所有部门
		for (Department department : list) {
			if (department.getId().toString().equals(did)) {
				childMenu.add(department);   // 用户当前所属部门
				break;
			}
		}
		treeMenuList(list, did); // 用户所有子部门
		return childMenu;
	}

	/**
	 * 获取某个父节点下面的所有子节点
	 *
	 * @param menuList
	 * @param pid
	 * @return
	 */
	private List<Department> childMenu = null;
	private void treeMenuList(List<Department> menuList, String pid) {
		for (Department mu : menuList) {
			//遍历出父id等于参数的id，add进子节点集合
			if (pid.equals(mu.getpId())) {
				//递归遍历下一级
				treeMenuList(menuList, mu.getId().toString());
				childMenu.add(mu);
			}
		}
	}

}

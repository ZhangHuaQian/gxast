package com.cen.ucenter.service.impl;


import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.common.util.Page;
import com.cen.ucenter.dao.UserDao;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.upms.entity.UserRole;
import com.cen.upms.service.UserRoleService;



/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年4月25日 
* 
*/
@Service
@Transactional
public class UserServiceImpl implements UserService{

	@Autowired private UserDao userDao;
	@Autowired private UserRoleService userRoleService;

	@Override
	public User selectByLoginName(String loginName) {
		return userDao.selectByLoginName(loginName);
	}

	@Override
	public User selectByPrimaryKey(String id) {
		return userDao.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(User user) {
		return userDao.updateByPrimaryKeySelective(user);
	}

	@Override
	public List<User> selectList(Map<String, Object> map) {
		return userDao.selectList(map);
	}

	@Override
	public int selectListCount(Map<String, Object> map) {
		return userDao.selectListCount(map);
	}

	@Override
	public int selectCount() {
		return userDao.selectCount();
	}

	/**
	 * 用户注册
	 * @param roleIds 角色ID
	 * @param user 
	 * @return
	 */
	@Override
	public int register(String[] roleIds,User user){
		int res = userDao.insertSelective(user); //添加用户
		User u = userDao.selectByLoginName(user.getLoginname());

		int res2 = 0;
		for (String roleId : roleIds){
			UserRole userRole = new UserRole();
			userRole.setUserCode(u.getId().toString());  //用户ID
			userRole.setRoleCode(roleId); //角色ID
			userRole.setCreateTime(new Date()); //创建时间
			userRole.setIsDel(0); // 默认未删
			res2 += userRoleService.insertSelective(userRole); //添加用户角色关联
		}

		return res+res2;
	}

	public boolean resetPsw(String loginname, String newPassword) {
		User user = selectByLoginName(loginname);
		if(user==null){
			return false;
		}
		user.setPassword(newPassword);
		user.setModifyTime(new Date());
		int result = updateByPrimaryKeySelective(user);
		if(result==0)return false;
		return true;
	}

	/**
	 * 用户更新(包括更新角色信息)
	 * @param roleIds
	 * @param user
	 * @return
	 */
	public int save(String[] roleIds, User user) {
		int res = updateByPrimaryKeySelective(user); //添加用户

		// 如果没有更改角色信息，那么只更新用户信息
		if(roleIds!=null && roleIds.length != 0){
			// 更改用户角色关联表删除状态
			UserRole userRole2 = new UserRole();
			userRole2.setUserCode(user.getId().toString());  //用户ID
			userRole2.setIsDel(1); // 更改删除状态
			int res2 = userRoleService.updateByUidSelective(userRole2); //更新用户角色关联

			// 插入新的用户角色关联
			for (String roleId : roleIds){
				UserRole userRole = new UserRole();
				userRole.setUserCode(user.getId().toString());  //用户ID
				userRole.setRoleCode(roleId); //角色ID
				userRole.setCreateTime(new Date()); //创建时间
				userRole.setIsDel(0); // 默认未删
				res += userRoleService.insertSelective(userRole); //添加用户角色关联
			}
		}

		return res;
	}

	@Override
	public int deleteByPrimaryKey(String id) {
		return userDao.deleteByPrimaryKey(id);
	}

	@Override
	public List<User> selectUserList(Map<String, Object> map) {
		return userDao.selectUserList(map);
	}

	@Override
	public int selectUserListCount(Map<String, Object> map) {
		return userDao.selectUserListCount(map);
	}

	@Override
	public List<User> selectUserByRolePower(String power,String did) {
		return userDao.selectUserByRolePower(power,did);
	}

}

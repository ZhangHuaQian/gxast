package com.cen.ucenter.service;


import java.util.List;
import java.util.Map;

import com.cen.common.util.Page;
import com.cen.ucenter.entity.User;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年4月25日 
* 
*/
public interface UserService {
	
	/**
     * 根据登录名称(loginName)查找用户
     * @param loginName
     * @return
     */
    User selectByLoginName(String loginName);
    
    /**
     * 根据ID查找用户
     * @param
     * @return
     */
    User selectByPrimaryKey(String id);
    
    /**
     * 根据ID更新用户
     * @param
     * @return
     */
    int updateByPrimaryKeySelective(User user);
    
    /**
	 * 分页查询
	 * @param
	 * @return
	 */
    List<User> selectList(Map<String, Object> map);

	/**
	 * 分页查询行数
	 * @param map
	 * @return
	 */
	int selectListCount(Map<String, Object> map);
    
    
    /**
	 * 查询总记录数 
	 * @return
	 */
	int selectCount();
	
	/**
	 * 用户注册
	 * @param roleIds
	 * @param user
	 * @return
	 */
	int register(String[] roleIds, User user);

	/**
	 * 根据账号重置密码
	 * @param loginname
	 * @param newPassword
	 * @return
	 */
	boolean resetPsw(String loginname,String newPassword);

	/**
	 * 用户更新(包括更新角色信息)
	 * @param roleIds
	 * @param user
	 * @return
	 */
	int save(String[] roleIds, User user);

	int deleteByPrimaryKey(String id);

	/*查询userType为1的用户*/
	List<User> selectUserList(Map<String, Object> map);
	
	/*分页查询手机用户*/
	int selectUserListCount(Map<String, Object> map);

	/**
	 * 根据角色名称查询用户列表
	 * @param power
	 * @return
	 */
	List<User> selectUserByRolePower(String power, String did);
}

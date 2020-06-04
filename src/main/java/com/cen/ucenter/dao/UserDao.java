package com.cen.ucenter.dao;


import java.util.List;
import java.util.Map;

import com.cen.common.util.Page;
import com.cen.ucenter.entity.User;
import org.apache.ibatis.annotations.Param;

/**
 * 
 * @author cenguocheng
 *	2018-6-1
 */
public interface UserDao {
    int deleteByPrimaryKey(String id);

	int insert(User record);

    int insertSelective(User record);
    
    User selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    /**
     * 根据您用户登录名查询实体
     * @param loginName
     * @return
     */
	User selectByLoginName(String loginName);
	
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

	/*查询userType为1的用户*/
	List<User> selectUserList(Map<String, Object> map);

	/*分页查询手机用户*/
	int selectUserListCount(Map<String, Object> map);

	/**
	 * 根据角色名称\部门查询用户列表
	 *
	 * @param power
	 * @return
	 */
	List<User> selectUserByRolePower(@Param("power") String power, @Param("did") String did);
}
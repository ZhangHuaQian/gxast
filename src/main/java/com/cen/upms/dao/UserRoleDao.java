package com.cen.upms.dao;

import com.cen.upms.entity.UserRole;

/**
 * 
 * @author cenguocheng  Email:137544496@qq.com 
 *	创建时间：2018年5月17日
 */
public interface UserRoleDao {
    int deleteByPrimaryKey(Integer id);

    int insert(UserRole record);

    int insertSelective(UserRole record);

    UserRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserRole record);

    int updateByPrimaryKey(UserRole record);

    int updateByUidSelective(UserRole record);
}
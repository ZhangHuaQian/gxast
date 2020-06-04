package com.cen.upms.dao;

import java.util.List;

import com.cen.upms.entity.Role;

/**
 * 
 * @author cenguocheng  Email:137544496@qq.com 
 *	创建时间：2018年5月17日
 */
public interface RoleDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
    
    List<Role> selectAll();
    
    List<Role> selectByUid(String userid);
}
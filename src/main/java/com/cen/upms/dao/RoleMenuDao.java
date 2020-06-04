package com.cen.upms.dao;

import java.util.List;

import com.cen.upms.entity.RoleMenu;


/**
 * 
 * @author cenguocheng  Email:137544496@qq.com 
 *	创建时间：2018年5月17日
 */
public interface RoleMenuDao {
    int deleteByPrimaryKey(Integer id);

    int insert(RoleMenu record);

    int insertSelective(RoleMenu record);

    RoleMenu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RoleMenu record);

    int updateByPrimaryKey(RoleMenu record);
    
    List<RoleMenu> selectByRoleCode(Integer id);
}
package com.cen.upms.service;

import java.util.List;

import com.cen.upms.entity.Role;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
public interface RoleService {
	int insertSelective(Role record);
	
    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role record);
    
    List<Role> selectAll();
    
    List<Role> selectByUid(String userid);
}

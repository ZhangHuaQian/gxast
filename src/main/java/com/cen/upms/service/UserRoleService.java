package com.cen.upms.service;

import com.cen.upms.entity.UserRole;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
public interface UserRoleService {
	int insertSelective(UserRole userRole);

	UserRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserRole userRole);

	int updateByUidSelective(UserRole userRole);
}

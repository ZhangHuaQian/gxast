package com.cen.upms.service;

import java.util.List;

import com.cen.upms.entity.RoleMenu;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
public interface RoleMenuService {
	int insertSelective(RoleMenu roleMenu);

	RoleMenu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RoleMenu roleMenu);
    
    List<RoleMenu> selectByRoleCode(Integer id);
    
    /**
     * 添加角色菜单关联
     * @param rid 角色ID
     * @param mids 菜单ID 用,字符分组
     * @throws Exception 
     */
    void save(int rid, String mids) throws Exception;
}

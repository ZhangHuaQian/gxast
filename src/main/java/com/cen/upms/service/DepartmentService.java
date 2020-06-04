package com.cen.upms.service;

import java.util.List;

import com.cen.upms.entity.Department;
import com.cen.upms.entity.Role;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
public interface DepartmentService {
	int insertSelective(Department department);
	
	Department selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Department department);
    
    List<Department> selectAll();

    /**
     * 查询当前用户部门（包含所有下级子部门）-后台管理
     * @param did
     * @return
     */
    List<Department> selectByThisUser(String did);
}

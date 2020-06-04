package com.cen.upms.service;

import java.util.List;

import com.cen.upms.entity.Menu;


/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
public interface MenuService {

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Menu record);
    
    List<Menu> selectAll();
    
    /**
     * 根据角色ID查询列表
     * @param rid
     * @return
     */
    List<Menu> selectByRid(String rid);

    /**
     * 根据角色ID查询手机菜单
     * @param rid
     * @return
     */
    List<Menu> selectPhoneByRid(String rid);

}

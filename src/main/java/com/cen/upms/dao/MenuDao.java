package com.cen.upms.dao;

import java.util.List;

import com.cen.upms.entity.Menu;

/**
 * 
 * @author cenguocheng  Email:137544496@qq.com 
 *	创建时间：2018年5月17日
 */
public interface MenuDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);
    
    List<Menu> selectAll();
    
    List<Menu> selectByRid(String rid);

    /**
     * 根据角色ID查询手机菜单
     * @param rid
     * @return
     */
    List<Menu> selectPhoneByRid(String rid);
}
package com.cen.upms.util;

import com.cen.upms.entity.Menu;

import java.util.ArrayList;
import java.util.List;

/**
 * 菜单树解析
 * @author cenguocheng  Email:137544496@qq.com 
 *	创建时间：2018年5月17日
 */
public class MenuTree{

    public List<Menu> menuList = new ArrayList<Menu>(); // 树递归
    private String str = ""; // 遍历菜单HTML

    /**
     *
     * @param treeData  菜单数据
     * @param pid 一级菜单父ID
     * @return
     */
    public MenuTree(List<Menu> treeData ,String pid) {

        // 先找到所有的一级菜单
        for (int i = 0; i < treeData.size(); i++) {
            // 一级菜单父ID为0
            if (treeData.get(i).getpMenuCode().equals(pid)) {
                menuList.add(treeData.get(i));
            }
        }

        // 为一级菜单设置子菜单，getChild是递归调用的
        for (Menu menu : menuList) {
            menu.setChildMenus(getChild(menu.getId(), treeData));
        }

    }

    /**
     * 子菜单递归
     * @param id
     * @param rootMenu
     * @return
     */
    private static List<Menu> getChild(String id, List<Menu> rootMenu) {
        // 子菜单
        List<Menu> childList = new ArrayList<>();
        for (Menu menu : rootMenu) {
            // 遍历所有节点，将父菜单id与传过来的id比较
            if (menu.getpMenuCode().equals(id)) {
                childList.add(menu);
            }
        }

        // 把子菜单的子菜单再循环一遍
        for (Menu menu : childList) {
            menu.setChildMenus(getChild(menu.getId(), rootMenu));// 递归
        }

        // 判断递归结束
        if (childList.size() == 0) {
            return null;
        }
        return childList;
    }


    /**
     * 遍历菜单(左侧)
     * @param arr
     * @param base_uri   项目根路径
     * @return
     */
    public String buildMenuLeft(List<Menu> arr,String base_uri) {
        //System.out.println(arr.size());
        for (int i = 0; i < arr.size(); i++) {
            str += "<li>";
            str += "<a _href='"+base_uri+arr.get(i).getUrl()+"'>" +
                    //"<i class='iconfont'>&#xe6b8;</i>" +
                    "<i class='iconfont'><img src="+base_uri+"uploadFiles/photo/"+arr.get(i).getIcon()+" /></i>" +
                    "<cite>" + arr.get(i).getMenuName() + "</cite>";

            // 存在子菜单  显示图标
            if (arr.get(i).getChildMenus() != null && arr.get(i).getChildMenus().size() > 0) {
                str += "<i class='iconfont nav_right'>&#xe697;</i>";
            }

            str += "</a>";
            //存在子菜单 递归
            if (arr.get(i).getChildMenus() != null && arr.get(i).getChildMenus().size() > 0) {
                str += "<ul class='sub-menu'>";
                buildMenuLeft(arr.get(i).getChildMenus(),base_uri); // 递归
                str += "</ul>";
            }
            str += "</li>";
        }

        return str;
    }

}
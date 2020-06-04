package com.cen.admin.controller;



import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import javax.validation.constraints.Size;

import com.cen.upms.util.MenuTree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cen.common.controller.BaseController;
import com.cen.ucenter.entity.User;
import com.cen.upms.entity.Menu;
import com.cen.upms.entity.Role;
import com.cen.upms.service.MenuService;
import com.cen.upms.service.RoleService;

/**
 * @author cenguocheng E-mail:137544496@qq.com
 * @version 创建时间：2018年4月30日 后台管理系统
 */
@Controller
@RequestMapping("/sys")
public class SysController extends BaseController{
	
	@Autowired MenuService menuService;
	@Autowired RoleService roleService;
	
	/**
	 * 后台管理首页
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index( HttpServletRequest request, HttpServletResponse response) {
		User user = getUser(request);
		if(!isEmpty(user)){
			List<Role> roleList = roleService.selectByUid(user.getId()); //获取角色
			List<Menu> menuList = new ArrayList<Menu>();  //菜单权限
			for (Role role : roleList) {
				List<Menu> menuLists =  menuService.selectByRid(role.getId()); //获取菜单权限
				for (Menu menu : menuLists) {
					menuList.add(menu);
				}
			}
			//List<Menu> menuList = menuService.selectAll(); //所有菜单
			List<Menu> menuList2 = removeDuplicateUser(menuList); //根据对象的属性去重
			//request.setAttribute("menuList", menuList2);

			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+ "/";
			MenuTree menuTree = new MenuTree(menuList2,"76");
			String str = menuTree.buildMenuLeft(menuTree.menuList,basePath);
			request.setAttribute("menuList2", str);
		}
		return "/sys/index";
	}

	/**
	 * list 根据对象的属性去重
	 * @param menus
	 * @return
	 */
	private ArrayList<Menu> removeDuplicateUser(List<Menu> menus) {
		Set<Menu> set = new TreeSet<Menu>(new Comparator<Menu>() {
			//@Override
			public int compare(Menu o1, Menu o2) {
				//字符串,则按照asicc码升序排列
				return o1.getId().compareTo(o2.getId());
			}
		});
		set.addAll(menus);
		return new ArrayList<Menu>(set);
	}


	/**
	 * 后台管理-欢迎页
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/welcome", method = RequestMethod.GET)
	public String welcome(HttpServletRequest request, HttpServletResponse response) {
		Properties p = System.getProperties();
		request.setAttribute("properties", p);
		return "/sys/welcome";
	}
	
	
}

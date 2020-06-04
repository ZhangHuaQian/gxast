package com.cen.upms.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.upms.entity.RoleMenu;
import com.cen.upms.service.RoleMenuService;

/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
@Controller
@RequestMapping(value = "/sys/upms/roleMenu")
public class RoleMenuController extends BaseController{
	
	@Autowired
	RoleMenuService roleMenuService;

	
	
	/**
	 * 添加角色菜单-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(int rid,String mids, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<String,Object>();
		try {
			roleMenuService.save(rid, mids);
			rMap.put("status", ReturnInfoType.SUCEEESS);
			return toJSONString(rMap); 
		} catch (Exception e) {
			e.printStackTrace();
			rMap.put("status", ReturnInfoType.ERROR);
			return toJSONString(rMap); 
		}
	}
	
	/**
	 * 修改角色菜单-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(RoleMenu roleMenu, HttpServletRequest request, HttpServletResponse response) {
		int rs = roleMenuService.updateByPrimaryKeySelective(roleMenu);
		return rs>0?ReturnInfoType.SUCEEESS:ReturnInfoType.ERROR;
	}
	
	/**
	 * 查询（id）角色菜单-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/selectById", method = RequestMethod.POST)
	@ResponseBody
	public String selectById(int rid, HttpServletRequest request, HttpServletResponse response) {
		RoleMenu roleMenu = roleMenuService.selectByPrimaryKey(rid);
		return JSON.toJSONString(roleMenu);
	}
	
	
	/**
	 * 根据rid查询角色菜单-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/selectByRoleCode", method = RequestMethod.GET)
	@ResponseBody
	public String selectByRoleCode(int rid, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<String,Object>();
		List<RoleMenu> list = roleMenuService.selectByRoleCode(rid);
		rMap.put("list", list);
		return toJSONString(rMap);
	}
}

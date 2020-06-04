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
import com.cen.upms.entity.Menu;
import com.cen.upms.service.MenuService;

/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
@Controller
@RequestMapping(value = "/sys/upms/menu")
public class MenuController extends BaseController{
	
	@Autowired
	MenuService menuService;
	
	/**
	 * 添加菜单-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(Menu menu, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		menu.setIsDel(0); //默认未删
		menu.setCreateTime(new Date()); // 创建时间
		int rs = menuService.insertSelective(menu);
		if (rs == 1){
			rMap.put("msg", "添加成功");
			rMap.put("status", ReturnInfoType.SUCEEESS);
		} else{
			rMap.put("msg", "添加失败");
			rMap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(rMap);
	}
	
	/**
	 * 修改菜单-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(Menu menu, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		int rs = menuService.updateByPrimaryKeySelective(menu);
		if (rs == 1){
			rMap.put("msg", "更新成功");
			rMap.put("status", ReturnInfoType.SUCEEESS);
		} else{
			rMap.put("msg", "更新失败");
			rMap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(rMap);
	}
	
	/**
	 * 查询（id）菜单-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/selectById", method = RequestMethod.POST)
	@ResponseBody
	public String selectById(int mid, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		Menu menu = menuService.selectByPrimaryKey(mid);
		rMap.put("menu", menu);
		return toJSONString(rMap);
	}
	
	/**
	 * 查询所有菜单-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/selectAll", method = RequestMethod.POST,produces = "application/json; charset=utf-8")
	@ResponseBody
	public String selectAll( HttpServletRequest request, HttpServletResponse response) {
		List<Menu> list = menuService.selectAll();
		return JSON.toJSONString(list);
	}
	
}

package com.cen.upms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.common.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.cen.common.util.ReturnInfoType;
import com.cen.upms.entity.UserRole;
import com.cen.upms.service.UserRoleService;

import java.util.HashMap;
import java.util.Map;

/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
@Controller
@RequestMapping(value = "/sys/upms/userRole")
public class UserRoleController extends BaseController {
	
	@Autowired
	UserRoleService userRoleService;
	/**
	 * 添加用户角色-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(UserRole userRole, HttpServletRequest request, HttpServletResponse response) {
		int rs = userRoleService.insertSelective(userRole);
		return rs>0?ReturnInfoType.SUCEEESS:ReturnInfoType.ERROR;
	}
	
	/**
	 * 修改用户角色-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(UserRole userRole, HttpServletRequest request, HttpServletResponse response) {
		int rs = userRoleService.updateByPrimaryKeySelective(userRole);
		return rs>0?ReturnInfoType.SUCEEESS:ReturnInfoType.ERROR;
	}
	
	/**
	 * 查询（id）用户角色-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/selectById", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(int uid, HttpServletRequest request, HttpServletResponse response) {
		UserRole userRole = userRoleService.selectByPrimaryKey(uid);
		Map<String, Object> rMap = new HashMap<String,Object>();
		rMap.put("userRole",userRole);
		return toJSONString(rMap);
	}
}

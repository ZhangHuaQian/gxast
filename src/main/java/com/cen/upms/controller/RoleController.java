package com.cen.upms.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.upms.entity.Role;
import com.cen.upms.service.RoleService;

/** 
* @author cenguocheng E-mail:137544496@qq.com 
* @version 创建时间：2018年5月17日 
* 
*/
@Controller
@RequestMapping(value = "/sys/upms/role")
public class RoleController extends BaseController{
	@Autowired
	RoleService roleService;
	
	/**
	 * 添加角色-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(Role role, HttpServletRequest request, HttpServletResponse response) {
		role.setIsDel(0); //默认未删
		role.setCreateTime(new Date()); //创建时间
		int rs = roleService.insertSelective(role);
		return rs>0?ReturnInfoType.SUCEEESS:ReturnInfoType.ERROR;
	}
	
	/**
	 * 修改角色-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(Role role, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		role.setModifyTime(new Date()); //更新时间
		int rs = roleService.updateByPrimaryKeySelective(role);
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
	 * 查询（id）角色-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/selectById", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(int rid, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		Role role = roleService.selectByPrimaryKey(rid);
		rMap.put("role",role);
		return toJSONString(rMap);
	}
	
	

	/**
	 * 查询所有角色-后台管理
	 * @param request 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/selectAll", method = RequestMethod.GET)
	@ResponseBody
	public String selectAll( HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<String,Object>();
		List<Role> list = roleService.selectAll();

		Subject currentUser = SecurityUtils.getSubject();
		if (!currentUser.hasRole("role_super")) {
			for (int i=0;i<list.size();i++) {
				Role role = list.get(i);
				if(role.getId().equals("1"))list.remove(i);break;
			}
		}

		if(!isEmpty(list))rMap.put("list", list);
		return toJSONString(rMap);
	}

	/**
	 * 根据用户ID查询相对应的角色-后台管理
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/selectByUid", method = RequestMethod.GET)
	@ResponseBody
	public String selectByUid(String uid, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<String,Object>();
		List<Role> list = roleService.selectByUid(uid);

		/*Subject currentUser = SecurityUtils.getSubject();
		if (!currentUser.hasRole("超级管理员")) {
			for (int i=0;i<list.size();i++) {
				Role role = list.get(i);
				if(role.getId()==1)list.remove(i);break;
			}
		}*/

		if(!isEmpty(list))rMap.put("list", list);
		return toJSONString(rMap);
	}
	
	
}

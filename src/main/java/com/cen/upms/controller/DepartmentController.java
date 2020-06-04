package com.cen.upms.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.ucenter.entity.User;
import com.cen.upms.entity.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.upms.entity.Department;
import com.cen.upms.entity.Role;
import com.cen.upms.service.DepartmentService;

/**
 * @author cenguocheng E-mail:137544496@qq.com
 * @version 创建时间：2018年5月17日
 */
@Controller
@RequestMapping(value = "/sys/upms/department")
public class DepartmentController extends BaseController {
    @Autowired DepartmentService departmentService;

    /**
     * 添加部门-后台管理
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ResponseBody
    public String insert(Department department, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        department.setIsDel(0); //默认未删
        department.setCreateTime(new Date()); //创建时间
        int rs = departmentService.insertSelective(department);
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
     * 修改部门-后台管理
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public String update(Department department, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        department.setModifyTime(new Date()); //更新时间
        int rs = departmentService.updateByPrimaryKeySelective(department);
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
     * 查询（id）部门-后台管理
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/selectById", method = RequestMethod.GET)
    @ResponseBody
    public String selectById(int did, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        Department department = departmentService.selectByPrimaryKey(did);
        rMap.put("department", department);
        return toJSONString(rMap);
    }

    /**
     * 查询所有部门-后台管理
     * @param request
     * @param response
     * @return
     */
    /*@RequestMapping(value = "/selectAll", method = RequestMethod.GET)
	@ResponseBody
	public String selectAll( HttpServletRequest request, HttpServletResponse response) {
		System.out.println("selectAll()");
		List<Department> list = departmentService.selectAll();
		if(!isEmpty(list))rMap.put("list", list);
		return toJSONString(rMap);
	}*/

    /**
     * 查询当前用户部门（包括子部门）-后台管理
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/selectByThisUser", method = RequestMethod.GET)
    @ResponseBody
    public String selectByThisUser(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> rMap = new HashMap<String, Object>();
        User user = getUser(request); //当前登录用户
        List<Department> childMenu = departmentService.selectByThisUser(user.getDid());
        rMap.put("list", childMenu);
        return toJSONString(rMap);
    }

}

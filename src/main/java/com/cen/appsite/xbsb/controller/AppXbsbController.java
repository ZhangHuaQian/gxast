package com.cen.appsite.xbsb.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.code.entity.code;
import com.cen.code.service.CodeService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.xbsbs.entity.xbsbs;
import com.cen.xbsbs.service.xbsbsService;

@Controller
@RequestMapping("/appsite/xbsbs")
public class AppXbsbController extends BaseController {

	@Autowired
	xbsbsService xbsbService;
	@Autowired
	CodeService CodeService;

	
	@RequestMapping(value = "/code", method = RequestMethod.POST)
	@ResponseBody
	public String code(code code,xbsbs xbsb, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> cmap = new HashMap<>();
		code code2 = CodeService.selectByPassword(code.getPassword());
		if ( code2 == null) {
			cmap.put("msg", "兑换码错误");
			cmap.put("status", ReturnInfoType.FAIL);
			return toJSONString(cmap);
		}
		if (code2.getStatus()==1) {
			cmap.put("msg", "兑换码已经使用过");
			cmap.put("status", ReturnInfoType.FAIL);
			return toJSONString(cmap);
		}else {
			xbsb.setCreatetime(new Date());
			xbsb.setIsover(1);
			int result = xbsbService.insert(xbsb);
			if (result == 1) {
				code2.setStatus(1);
				CodeService.updateByPrimaryKeySelective(code2);
				cmap.put("msg", "购买成功");
				cmap.put("status", ReturnInfoType.SUCEEESS);
			} else {
				cmap.put("msg", "购买失败");
				cmap.put("status", ReturnInfoType.FAIL);
			}
			return toJSONString(cmap);
		}
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(xbsbs xbsb, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> cmap = new HashMap<>();
		int result = xbsbService.insert(xbsb);
		if (result == 1) {
			cmap.put("msg", "兑换成功");
			cmap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			cmap.put("msg", "兑换失败");
			cmap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(cmap);
	}

	@RequestMapping(value = "/selectList", method = RequestMethod.GET)
	@ResponseBody
	public String selectList(Integer pageNum,HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();

		int count = xbsbService.selectList(pmap).size();  //记录行数
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		List<xbsbs> list = xbsbService.selectList(pmap); //列表

		if (!isEmpty(list)) dmap.put("list", list);
		dmap.put("count", count);
		dmap.put("pagecurr", getPageNum(pageNum) + 1);
		return toJSONString(dmap);
	}

	@RequestMapping("/index")
	public String xbsb(){
		System.err.println("---- xbsb index ----");
		return "/app/index";
	}
}

package com.cen.xbsbs.controller;

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

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.news.entity.News;
import com.cen.ucenter.entity.User;
import com.cen.upms.entity.Department;
import com.cen.xbsbs.entity.xbsbs;
import com.cen.xbsbs.service.xbsbsService;

@Controller
@RequestMapping("/sys/xbsbs")
public class XbsbsController extends BaseController {

	@Autowired
	xbsbsService xbsbsService;

	@RequestMapping(value = "/insert", method = RequestMethod.POST)        
	@ResponseBody
	public String insert(xbsbs xbsb, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> cmap = new HashMap<>();
		int result = xbsbsService.insert(xbsb);
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

		int count = xbsbsService.selectList(pmap).size();  //记录行数
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		List<xbsbs> list = xbsbsService.selectList(pmap); //列表

		if (!isEmpty(list)) dmap.put("list", list);
		dmap.put("count", count);
		dmap.put("pagecurr", getPageNum(pageNum) + 1);
		return toJSONString(dmap);
	}

}

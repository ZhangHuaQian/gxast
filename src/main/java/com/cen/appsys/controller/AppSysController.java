package com.cen.appsys.controller;

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
import com.cen.dictionary.entity.Dictionary;
import com.cen.dictionary.service.DictionaryService;
@Controller
@RequestMapping("/appsys")
public class AppSysController extends BaseController{
	@Autowired
	DictionaryService DictionaryService;

	/**
	 * 分页查询所有数据字典
	 * @param dict
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/selectList",method=RequestMethod.GET,produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectList(Dictionary dict,Integer pageNum,HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		
		pmap = MapUtils.beanToMap(dict);
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		
		List<Dictionary> list = DictionaryService.selectList(pmap); //列表
		int count = DictionaryService.selectListCount(pmap);  //记录行数
		
		if(!isEmpty(list)) dmap.put("list", list);
		dmap.put("count", count);
		return toJSONString(dmap);
	}
}

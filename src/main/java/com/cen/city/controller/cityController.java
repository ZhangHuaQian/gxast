package com.cen.city.controller;



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

import com.cen.city.entity.city;
import com.cen.city.service.cityService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;

@Controller
@RequestMapping("/city")
public class cityController extends BaseController{
	@Autowired
	cityService cityService;

	/**
	 * 根据城市查询下级地市
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/select",method=RequestMethod.GET)
	@ResponseBody
	public String selectList(city city, HttpServletRequest request,
							 HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		
		pmap=MapUtils.beanToMap(city); 
		System.out.println(pmap);
		//pmap.put("province_id", "450");
		
		List<city> cities = cityService.selectList(pmap); 
		
		dmap.put("city", cities);
		return toJSONString(dmap);
	}
	
	/**
	 * 根据城市查询下级地市
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/selectByVid",method=RequestMethod.GET)
	@ResponseBody
	public String selectByVid(String vid, HttpServletRequest request,
							 HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		
		city city = cityService.selectByVid(vid);
		
		dmap.put("village", city);
		
		return toJSONString(dmap);
	}
}

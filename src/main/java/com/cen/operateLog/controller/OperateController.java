package com.cen.operateLog.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import com.cen.dictionary.entity.Dictionary;
import com.cen.operateLog.entity.Operatelog;
import com.cen.operateLog.service.OperatelogService;

@Controller
@RequestMapping("/sys/operatelog")
public class OperateController extends BaseController {
   
	@Autowired
	private OperatelogService operatelogService;
	
	/**
	 * 查询日志
	 * @param operatelog
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws ParseException 
	 */
	
	@RequestMapping(value="/selectList",method=RequestMethod.GET)
	@ResponseBody
	public String SelectList(Operatelog operatelog,Integer pageNum,String startTime, String endTime,HttpServletRequest request,
			HttpServletResponse response,ModelMap map) throws ParseException{
		
		
		Date start = null;
		Date end = null;
		
		System.out.println("String开始时间" + startTime);
		System.out.println("String结束时间" + endTime);

		if (!isEmpty(startTime) && !isEmpty(endTime)) {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			start = df.parse(startTime);
			end = df.parse(endTime);
		}
		
		System.out.println("Date开始时间" + start);
		System.out.println("Date结束时间" + end);

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> smap = new HashMap<String, Object>();
		
		pmap = MapUtils.beanToMap(operatelog);
		pmap.put("pageNum",getPageNum(pageNum));
		pmap.put("start", start);
		pmap.put("end", end);
		pmap.put("pageSize",pageSize);
		
		List<Operatelog> list = operatelogService.selectList(pmap);  //列表
		int count = operatelogService.selectListCount(pmap);  //列表数
		
		if(!isEmpty(list)) smap.put("list", list);
		smap.put("count", count);
		
		return toJSONString(smap);
	}
	
	
	/**
	 * 更新操作
	 * @param dict
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public String update(Operatelog operatelog,HttpServletRequest request,HttpServletResponse response,ModelMap map){
		Map<String, Object> umap = new HashMap<String, Object>();
		int count = operatelogService.updateByPrimaryKeySelective(operatelog);
		if(count == 1){
			umap.put("msg", "更新成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			umap.put("msg", "更新失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
	
	
	
}

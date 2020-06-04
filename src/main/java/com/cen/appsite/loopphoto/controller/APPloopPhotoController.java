package com.cen.appsite.loopphoto.controller;

import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.loopphoto.entity.Loopphoto;
import com.cen.loopphoto.service.LoopphotoService;
import com.cen.ucenter.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 轮播图
 */
@Controller
@RequestMapping(value="/appsite/loopphoto")
public class APPloopPhotoController extends BaseController {
	
	@Autowired
	private LoopphotoService loopphotoService;

	/**
	 * 按分类查询轮播图
	 * @param
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value="/loopSelectList/{type}",produces = "application/json;charset=utf-8")
	@ResponseBody
	public String LoopSelectList(@PathVariable("type")String type, HttpServletRequest request ){
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> smap = new HashMap<String, Object>();
		//pmap = MapUtils.beanToMap(loopphoto);
		pmap.put("type",type);
		List<Loopphoto> list = loopphotoService.LoopSelectList(pmap);  //列表
		int count = loopphotoService.selectListCount(pmap);  //列表数
		if(!isEmpty(list)) {
			for (Loopphoto l:list ) {
				l.setProjectImg(system_base+system_base_photo+l.getProjectImg());
			}
			smap.put("list", list);
			smap.put("count", count);
			smap.put("status", ReturnInfoType.SUCEEESS);
		}
		return toJSONString(smap);
	}

	
}

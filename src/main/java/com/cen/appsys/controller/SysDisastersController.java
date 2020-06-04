package com.cen.appsys.controller;


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
import com.cen.disasters.entity.Disasters;
import com.cen.disasters.service.DisastersService;
import com.cen.news.entity.News;
import com.cen.ucenter.entity.User;

@Controller
@RequestMapping("/appsys/disasters")
public class SysDisastersController extends BaseController{
	@Autowired
	DisastersService DisastersService;
	
	
	
	/**
	 * 分页查询所有资讯
	 * @param news
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/selectList",method=RequestMethod.GET)
	@ResponseBody
	public String selectList(Integer pageNum,String title,HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		User user = getUser(request);
		pmap.put("userid", user.getId());
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("title", title);
		List<Disasters> list = DisastersService.selectList(pmap); //列表
		dmap.put("count", list.size());
		if(!isEmpty(list)) dmap.put("list", list);
		return toJSONString(dmap);
	}
	/**
	 * 根据id删除资讯
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public String delete(int id,HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Disasters disasters=DisastersService.selectByPrimaryKey(id);
		disasters.setIsDel(1);//假删除
		int result=DisastersService.updateByPrimaryKeySelective(disasters);
		if(result == 1){
			umap.put("msg", "删除成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			umap.put("msg", "删除失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
}

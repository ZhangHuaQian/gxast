package com.cen.appsite.disasters.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.operateLog.annotation.UserOperate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.disasters.entity.Disasters;
import com.cen.disasters.service.DisastersService;

@Controller
@RequestMapping(value="/appsite/disasters")
public class APPDisastersController extends BaseController {

	@Autowired
	private DisastersService disastersService;
	
	/**
	 * 查询所有灾害防御信息
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/selectAll",method=RequestMethod.GET)
	@ResponseBody
	public String selectAll(int pageNum,String typeValue,String title, HttpServletRequest request,
			HttpServletResponse response,ModelMap map){
		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, Object> rmap = new HashMap<String, Object>();
		
		dmap.put("pageNum", getPageNum(pageNum));
		dmap.put("pageSize", pageSize);
		dmap.put("title", title);
		dmap.put("typeValue", typeValue);
		
		List<Disasters> list = disastersService.selectAll(dmap);
		if(!isEmpty(list)) rmap.put("list", list);
		
		rmap.put("count", list.size());
		
		return toJSONString(rmap);
	}
	
	/**
	 * 根据id查询灾害防御信息
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/select", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(int id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Disasters disasters=disastersService.selectByPrimaryKey(id);
		return toJSONString(disasters);
	}
	
	/**
	 * 根据id查询灾害防御信息
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/details", method = RequestMethod.GET)
	public String view(int id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Disasters disasters=disastersService.selectByPrimaryKey(id);
		request.setAttribute("disasters",disasters);
		return "appsite/disasters/details";
	}
	
	/**
	 * 根据名称查询商品集合
	 * @param name
	 * @param pageNum
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/findByName",method=RequestMethod.GET)
	@ResponseBody
    public String findByName(String name,int pageNum,HttpServletRequest request,HttpServletResponse response){
		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> rmap = new HashMap<String, Object>();
		
		map.put("pageSize", pageSize);
		map.put("pageNum", getPageNum(pageNum));
		map.put("name", name);
		
		List<Disasters> list = disastersService.findByName(map);
		int count = disastersService.selectListCount(map);
		if(!isEmpty(list))
		    request.setAttribute("list", list);
		    request.setAttribute("count", count);
    	return "appsite/disasters/list";
    }

	/**
	 * 假删除数据
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@UserOperate(moduleName="防灾减灾",option = "删除")
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public String delete(int id,HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Disasters disasters = disastersService.selectByPrimaryKey(id);
		disasters.setIsDel(1);//假删除
		int result=disastersService.updateByPrimaryKeySelective(disasters);
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

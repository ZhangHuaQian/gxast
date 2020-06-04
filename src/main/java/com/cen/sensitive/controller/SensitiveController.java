package com.cen.sensitive.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.operateLog.annotation.UserOperate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.news.entity.News;
import com.cen.sensitive.entity.sensitive;
import com.cen.sensitive.service.sensitiveService;
@Controller
@RequestMapping("/sys/sensitive")
public class SensitiveController extends BaseController{

	@Autowired
	sensitiveService sensitiveService;
	
	//敏感词检测
	@RequestMapping(value="/TextAudit", method=RequestMethod.POST)
	@ResponseBody
	public int TextAudit(String txt,HttpServletRequest request,HttpServletResponse response){
		/*Set result = new HashSet(sensitiveService.selectAll());
		//初始化敏感词库
        sensitiveService.initSensitiveWordMap(result);
        //是否含有关键字
        boolean flag = sensitiveService.contains(txt,2);
        System.out.println(txt);
		return flag?1:0;*/
		return 0;
	}
	/**
	 * 添加敏感词
	 * @param dict
	 * @param request
	 * @param response
	 * @return
	 */
	@UserOperate(moduleName="敏感词",option = "添加敏感词")
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	@ResponseBody
	public String insert(sensitive sensitive,HttpServletRequest request,HttpServletResponse response){
      Map<String, Object> cmap = new HashMap<String, Object>();
      int count = sensitiveService.selectByWords(sensitive.getWords());
      if (count<1) {
    	  int result=sensitiveService.insert(sensitive);
    	  if (result==1) {
        	  cmap.put("msg", "添加成功");
    	      cmap.put("status", ReturnInfoType.SUCEEESS);
    	      return toJSONString(cmap);
          }
          else {
        	  cmap.put("msg", "添加失败");
    	      cmap.put("status", ReturnInfoType.FAIL);
    	      return toJSONString(cmap);
          }
      }else {
    	  cmap.put("msg", "敏感词已存在");
	      cmap.put("status", ReturnInfoType.FAIL);
	      return toJSONString(cmap);
      }
	}
	/**
	 * 根据id删除敏感词
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@UserOperate(moduleName="敏感词",option = "删除敏感词")
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public String delete(int id,HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		int result=sensitiveService.deleteByPrimaryKey(id);
		if(result == 1){
			umap.put("msg", "删除成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			umap.put("msg", "删除失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
	/**
	 * 分页查询所有资讯
	 * @param news
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@UserOperate(moduleName="敏感词",option = "查看敏感词列表")
	@RequestMapping(value="/selectList",method=RequestMethod.GET)
	@ResponseBody
	public String selectList(sensitive sensitive,Integer pageNum,HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		
		pmap = MapUtils.beanToMap(sensitive);
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		
		List<sensitive> list = sensitiveService.selectList(pmap); //列表
		int count = sensitiveService.selectListCount(pmap);  //记录行数

		if(!isEmpty(list)) dmap.put("list", list);
		dmap.put("count", count);
		return toJSONString(dmap);
	}
}

package com.cen.dictionary.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.operateLog.annotation.UserOperate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.dictionary.entity.Dictionary;
import com.cen.dictionary.service.DictionaryService;
import com.cen.ucenter.entity.User;

@Controller
@RequestMapping("/sys/dictionary")
public class DictionaryController extends BaseController {

	@Autowired
	private DictionaryService DictionaryService;
	
	/**
	 * 添加字典
	 * @param dict
	 * @param request
	 * @param response
	 * @return
	 */
	@UserOperate(moduleName="数据字典",option = "添加数据字典")
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	@ResponseBody
	public String insert(Dictionary dict,HttpServletRequest request,HttpServletResponse response){
       Map<String, Object> dmap = new HashMap<String, Object>();
       Dictionary dictionay = DictionaryService.selectByName(dict.getName().trim());
       if(isEmpty(dictionay)){
    	  dict.setIsDel(0);
          DictionaryService.insertSelective(dict);
          dmap.put("msg", "字典添加成功");
          dmap.put("status", ReturnInfoType.SUCEEESS);
       }else{
    	   dmap.put("msg", "字典已存在");
    	   dmap.put("status", ReturnInfoType.ERROR);
       }
		return toJSONString(dmap);
	}
	@UserOperate(moduleName="数据字典",option = "查看数据字典")
	@RequestMapping(value="/select", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(int id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Dictionary dict = DictionaryService.selectByPrimaryKey(id);
		if (!isEmpty(dict))
			smap.put("dict", dict);

		return toJSONString(smap);
	}

	/**
	 * 查询出所有类型历史
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@UserOperate(moduleName="数据字典",option = "查看字典类型")
	@RequestMapping(value="/selecttype", method = RequestMethod.GET)
	@ResponseBody
	public String selectType( HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		List<Dictionary> list = DictionaryService.selectType();
		if (!isEmpty(list))
			smap.put("list", list);
		return toJSONString(smap);
	}
	
	/**
	 * 分页查询所有数据字典
	 * @param dict
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@UserOperate(moduleName="数据字典",option = "查看数据字典列表")
	@RequestMapping(value="/selectList",method=RequestMethod.GET,produces = "application/json;charset=utf-8")
	@ResponseBody
	public String selectList(Dictionary dict,Integer pageNum,HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		
		pmap = MapUtils.beanToMap(dict);
		//pmap.put("pageNum", getPageNum(pageNum));
		//pmap.put("pageSize", pageSize);
		
		List<Dictionary> list = DictionaryService.selectList(pmap); //列表
		int count = DictionaryService.selectListCount(pmap);  //记录行数
		
		if(!isEmpty(list)) dmap.put("list", list);
		dmap.put("count", count);
		return toJSONString(dmap);
	}
	
	
	/**
	 * 更新操作
	 * @param dict
	 * @param request
	 * @param response
	 * @return
	 */
	@UserOperate(moduleName="数据字典",option = "更新数据字典")
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public String update(Dictionary dict,HttpServletRequest request,HttpServletResponse response,ModelMap map){
		Map<String, Object> umap = new HashMap<String, Object>();
		int count = DictionaryService.updateByPrimaryKeySelective(dict);
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

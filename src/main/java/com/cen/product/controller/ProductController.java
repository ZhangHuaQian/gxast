package com.cen.product.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.operateLog.annotation.UserOperate;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
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
import com.cen.dictionary.entity.Dictionary;
import com.cen.dictionary.service.DictionaryService;
import com.cen.news.entity.News;
import com.cen.operateLog.entity.Operatelog;
import com.cen.product.entity.Product;
import com.cen.product.service.ProductService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.upms.entity.Department;
import com.cen.upms.service.DepartmentService;

@Controller
@RequestMapping(value="/sys/product")
public class ProductController extends BaseController {
	
	@Autowired
	private ProductService productService;
	@Autowired
	private DepartmentService DepartmentService;
	@Autowired
	private DictionaryService DictionaryService;
	@Autowired
	private UserService UserService;
	/**
	 * 添加操作
	 * @param product
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/insert",method=RequestMethod.POST)
	@ResponseBody
	public String insert(Product product,HttpServletRequest request,HttpServletResponse response){
             
		Map<String, Object> map = new HashMap<String,Object>();
		
		product.setCreatetime(new Date());
		product.setUid(getUser(request).getId());
		
		int recond = productService.insertSelective(product);
		if(recond == 1){
			map.put("msg", "添加成功");
			map.put("status", ReturnInfoType.SUCEEESS);
		}else{
			map.put("msg", "添加失败");
			map.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(map);
	}
	/**
	 * 分页查询
	 * @param product
	 * @param pageNum
	 * @param date1
	 * @param date2
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value="/selectList",method=RequestMethod.GET)
	@ResponseBody
	public String SelectList(Product product,Integer pageNum,Date date1, Date date2,HttpServletRequest request,
			HttpServletResponse response,ModelMap map) throws ParseException{	
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> smap = new HashMap<String, Object>();
		
		pmap=MapUtils.beanToMap(product);
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("start", date1);
		pmap.put("end", date2);
		
		List<Product> list = productService.selectList(pmap);  //列表
		int count = productService.selectListCount(pmap);  //列表数
		
		List<String> deList =new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			User user = UserService.selectByPrimaryKey(list.get(i).getUid());
			if(user != null){
				deList.add(user.getName());
			}
		}
		
		if(!isEmpty(list)) {
			smap.put("list", list);
			smap.put("deList", deList);  
		}
		smap.put("count", count);
		
		return toJSONString(smap);
	}
	
	/**
	 * 
	 * @param product
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public String update(Product product,HttpServletRequest request,HttpServletResponse response,ModelMap map){
		Map<String, Object> umap = new HashMap<String, Object>();
		int count = productService.updateByPrimaryKeySelective(product);
		if(count == 1){
			umap.put("msg", "更新成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			umap.put("msg", "更新失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
	
	/**
	 * 删除
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public String delete(String id,HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		int result=productService.deleteByPrimaryKey(id);
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
	 * 查看商品信息
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/select", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(String id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Product product = productService.selectByPrimaryKey(id);
		if (!isEmpty(product)){    
			smap.put("type",product.getType());
			smap.put("product", product);
		}
		return toJSONString(smap);
	}
	/**
	 * 日期转化器
	 * @param binder
	 */
	@InitBinder
	public void transferToDate(WebDataBinder binder){
	binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"),true));
	}
	
	
}

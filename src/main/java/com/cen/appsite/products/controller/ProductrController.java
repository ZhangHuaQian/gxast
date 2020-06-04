package com.cen.appsite.products.controller;

import java.math.BigDecimal;
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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cen.ProductCollect.entity.ProductCollect;
import com.cen.ProductCollect.service.ProductCollectService;
import com.cen.common.util.ReturnInfoType;
import com.cen.ucenter.entity.User;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.cen.common.controller.BaseController;
import com.cen.dictionary.service.DictionaryService;
import com.cen.product.entity.Product;
import com.cen.product.entity.specifications;
import com.cen.product.service.ProductService;
import com.cen.ucenter.service.UserService;
@Controller
@RequestMapping(value = "/appsite/product")
public class ProductrController extends BaseController {

	@Autowired
	private ProductService productService;
	@Autowired
	private DictionaryService DictionaryService;
	@Autowired
	private UserService UserService;

	@Autowired
	ProductCollectService<ProductCollect> productCollectService;


	@RequestMapping(value ="/sub",method = RequestMethod.POST)
	public void sub(String s){
		System.err.println(s.length());
	}

	/**
	 * 商品收藏、取消收藏
	 * @return
	 */
	@RequestMapping(value = "/collect", method = RequestMethod.POST)
	@ResponseBody
	public String collect(String pId,HttpServletRequest request){
		Map<String,Object> rMap = new HashMap<>();
		rMap.put("msg","操作失败");
		rMap.put("status",ReturnInfoType.FAIL);
		User user = getUser(request);
		if(user == null){
			rMap.put("msg","请先登录");
			rMap.put("status",ReturnInfoType.FAIL);
			return toJSONString(rMap);
		}
		ProductCollect productCollect = productCollectService.selectByUidAndPid(user.getId(), pId);
		int res = 0;
		if(productCollect == null){
			//执行收藏操作
			productCollect = new ProductCollect();
			productCollect.setUId(user.getId());
			productCollect.setPId(pId);
			productCollect.setCreateTime(new Date());
			res = productCollectService.insertSelective(productCollect);
			if (res > 0){
				rMap.put("msg","收藏成功");
				rMap.put("status",ReturnInfoType.SUCEEESS);
			}
		}else{
			//取消收藏
			res = productCollectService.deleteByPrimaryKey(productCollect.getId());
			if (res > 0){
				rMap.put("msg","取消收藏");
				rMap.put("status",2);
			}
		}
		return toJSONString(rMap);
	}

	/**
	 * 分页查询
	 * 
	 * @param product
	 * @param pageNum
	 * @param request
	 * @param response
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value = "/selectList", method = RequestMethod.GET)
	@ResponseBody
	public String selectList(Product product, Integer pageNum, Integer pageSize, HttpServletRequest request,
			HttpServletResponse response) throws ParseException {
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();

		pmap.put("name", product.getName());
		pmap.put("up", 1);
		pmap.put("pageNum", (pageNum - 1) * pageSize);
		pmap.put("pageSize", pageSize);
		pmap.put("switch", 1); 
		pmap.put("type",product.getType());

		List<Product> list = productService.selectList(pmap); // 列表
		int count = productService.selectListCount(pmap); // 列表数

		for (int i = 0; i < list.size(); i++) {
			List<specifications> List = JSON.parseArray(list.get(i).getSpecifications(), specifications.class);
			list.get(i).setPrice(List.get(0).getPrice());
		}

		if (!isEmpty(list)) {
			map.put("list", list);
		}
		map.put("count", count);
		map.put("pagenum", count / pageSize);

		return toJSONString(map);
	}

	/**
	 * 查看商品信息
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(String id, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Product product = productService.selectByPrimaryKey(id);
		if (!isEmpty(product)) {
			String specifications = product.getSpecifications();
			JSONArray array = JSONObject.parseArray(specifications);
			product.setPrice(BigDecimal.valueOf(array.getJSONObject(0).getDouble("price")));
			smap.put("type",product.getType());
			smap.put("product", product);
		}
		return toJSONString(smap);
	}

	/**
	 * 日期转化器
	 * 
	 * @param binder
	 */
	@InitBinder
	public void transferToDate(WebDataBinder binder) {
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
	}

}

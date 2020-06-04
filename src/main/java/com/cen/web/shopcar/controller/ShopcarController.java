package com.cen.web.shopcar.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.product.entity.Product;
import com.cen.product.entity.specifications;
import com.cen.product.service.ProductService;
import com.cen.shopcar.entity.shopcar;
import com.cen.shopcar.service.ShopcarService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;

@Controller
@RequestMapping(value="/web/shopcar")
public class ShopcarController extends BaseController{
	@Autowired
	UserService userService;
	@Autowired
	ProductService productService;
	@Autowired
	ShopcarService shopcarService;
	/**
	 * 添加购物车
	 * @param specifications 型号
	 * @param number 购买数量
	 * @param id 商品id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/insert",method=RequestMethod.POST)
	@ResponseBody
	public String insert(specifications specifications,Integer number,String id,HttpServletRequest request,HttpServletResponse response){
		Map<String, Object> pmap = new HashMap<String,Object>();
		Map<String, Object> map = new HashMap<String,Object>();
		User user = getUser(request);
		//如果是未登录状态
		if (user==null) {
			map.put("msg", "请先登录");
			map.put("status", ReturnInfoType.FAIL);
			System.err.println(toJSONString(map));
			return toJSONString(map);
		}
		Product product = productService.selectByPrimaryKey(id);
		List<specifications> list = JSON.parseArray(product.getSpecifications(), specifications.class);  
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getId_()==specifications.getId_()) {
				specifications.setPrice(list.get(i).getPrice());
				specifications.setStock(list.get(i).getStock());
				specifications.setWeight(list.get(i).getWeight());
				break;
			}
		}
		shopcar shopcar = new shopcar();
		shopcar.setCreatetime(new Date());
		shopcar.setName(specifications.getName());
		shopcar.setNumber(number);
		shopcar.setPid(specifications.getId_());
		shopcar.setPrice(specifications.getPrice());
		shopcar.setStatus(0);//未支付
		shopcar.setUserId(user.getId());
		shopcar.setProductId(id);
		
		pmap.put("pid", shopcar.getPid());
		pmap.put("productId", shopcar.getProductId());
		pmap.put("userId", user.getId());
		List<shopcar> shopcars = shopcarService.selectList(pmap);
		if (shopcars.size()>0&&shopcars.get(0).getStatus()==0) {
			shopcar shopcar2 = shopcars.get(0);
			//如果小于0
			if (shopcar2.getNumber() + number < 0) {
				map.put("msg", "错误");
				map.put("status", ReturnInfoType.FAIL);
				return toJSONString(map);
			}
			//如果超出库存
			if (specifications.getStock()<shopcar2.getNumber()+number) {
				map.put("msg", specifications.getName()+":购物车数量超出库存");
				map.put("status", ReturnInfoType.SUCEEESS);
				map.put("max", ReturnInfoType.SUCEEESS);
				return toJSONString(map);
			}
			//数量叠加
			shopcar2.setNumber(shopcar2.getNumber()+shopcar.getNumber());
			
			int recond1 = shopcarService.updateByPrimaryKeySelective(shopcar2);
			if(recond1 == 1){
				map.put("id", shopcar2.getId());
				map.put("msg", "添加成功");
				map.put("status", ReturnInfoType.SUCEEESS);
			}else{
				map.put("msg", "添加失败");
				map.put("status", ReturnInfoType.FAIL);
			}
			return toJSONString(map);
		}else {
			int recond1 = shopcarService.insertSelective(shopcar);
			if(recond1 == 1){        
				map.put("id", shopcar.getId());
				map.put("msg", "添加成功");
				map.put("status", ReturnInfoType.SUCEEESS);
			}else{
				map.put("msg", "添加失败");
				map.put("status", ReturnInfoType.FAIL);
			}
			return toJSONString(map);
		}
	}

	/**
	 *  修改购物车商品数量
	 * @param carId  购物车id
	 * @param prodId 商品id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public String update(String carId, String prodId, Integer num, HttpServletRequest request,HttpServletResponse response){

		Map<String,Object> rMap = new HashMap<>();
		rMap.put("msg","操作失败");
		rMap.put("status",ReturnInfoType.FAIL);
		Product product = productService.selectByPrimaryKey(prodId);
		List<specifications> list = null;
		if(product != null){
			list = JSON.parseArray(product.getSpecifications(), specifications.class);
		}

		User user = getUser(request);
		if(user == null){
			rMap.put("msg","请先登录");
			rMap.put("status",ReturnInfoType.FAIL);
		}
		//1.判断是否小于库存数量
		if(num < 0){
			return toJSONString(rMap);
		}else if ( num < list.get(0).getStock()){
			shopcar shopcar = new shopcar();
			shopcar.setId(carId);
			shopcar.setNumber(num);
			int res = shopcarService.updateByPrimaryKeySelective(shopcar);
			if(res > 0){
				rMap.put("msg","操作成功");
				rMap.put("status",ReturnInfoType.SUCEEESS);
			}
		}else{
			rMap.put("msg","库存数量不足");
			rMap.put("status",ReturnInfoType.FAIL);
		}
		return toJSONString(rMap);
	}

	/**
	 * 查看购物车
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/shopcar", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		User user = getUser(request);
		String id = getUser(request).getId();
		
		pmap.put("userId", id);
		pmap.put("status", 0);   
		List<shopcar> shopcars = shopcarService.selectList(pmap);
		List<Product> products = new ArrayList<>();
		List<shopcar> shopcars2 = new ArrayList<>();

		for (int i = 0; i < shopcars.size(); i++) {
			String pid = shopcars.get(i).getProductId();        
			Product product = productService.selectByPrimaryKey(pid);
			if (product!=null) {
				products.add(product);
				shopcars2.add(shopcars.get(i));
			}
		} 
		smap.put("products", products);         
		smap.put("shopcars", shopcars2); 
		
		return toJSONString(smap);
	}
	
	/**
	 * 查看某个购物车
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/select", method = RequestMethod.GET)
	@ResponseBody
	public String select(String shopcarId,HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		
		shopcar shopcar = shopcarService.selectByPrimaryKey(shopcarId);
		Product product = productService.selectByPrimaryKey(shopcar.getProductId());
		
		smap.put("shopcar", shopcar); 
		smap.put("product", product); 
		
		return toJSONString(smap);
	}
	
	/**
	 * 删除购物车
	 * @param id1
	 * @param
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public String delete(String id1,HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		String id = getUser(request).getId();//用户id
		//如果购物车用户id不匹配    
		if (!shopcarService.selectByPrimaryKey(id1).getUserId().equals(id)) {
			umap.put("msg", "错误"); 
			umap.put("status", ReturnInfoType.FAIL);
		}else {
			int result1=shopcarService.deleteByPrimaryKey(id1);
			if(result1 == 1){
				umap.put("msg", "删除成功");
				umap.put("status", ReturnInfoType.SUCEEESS);
			}else{
				umap.put("msg", "删除失败");
				umap.put("status", ReturnInfoType.FAIL);
			}
		}
		return toJSONString(umap);
	}

	/**
	 * 删除选中商品
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/deleteCheckedProduct",method=RequestMethod.POST)
	@ResponseBody
	public String deleteCheckedProduct(String[] carIdArray, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		User user = getUser(request);
		if(user == null){
			rMap.put("msg", "请先登录");
			rMap.put("status", ReturnInfoType.FAIL);
		}
		int result = shopcarService.deleteCheckedProduct(carIdArray);
		if(result == 1){
			rMap.put("msg", "删除成功");
			rMap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			rMap.put("msg", "删除失败");
			rMap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(rMap);
	}
	
	/**
	 * 删除购物车全部
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/deleteAll",method=RequestMethod.POST)
	@ResponseBody
	public String delete(HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Map<String, Object> smap = new HashMap<String, Object>();
		String id = getUser(request).getId();//用户id
		List<String> list = new ArrayList<>();
		list.add(id);
		smap.put("List", list);
		int result=shopcarService.deleteBat(smap);
		if(result == 1){
			umap.put("msg", "全部删除成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		}else{
			umap.put("msg", "全部删除失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}

}

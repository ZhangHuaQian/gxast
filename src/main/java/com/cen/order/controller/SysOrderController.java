package com.cen.order.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.cen.Message.entity.Message;
import com.cen.Message.service.MessageService;
import com.cen.address.entity.Address;
import com.cen.address.service.AddressService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.order.entity.order;
import com.cen.order.service.orderService;
import com.cen.product.entity.Product;
import com.cen.product.entity.specifications;
import com.cen.product.service.ProductService;
import com.cen.shopcar.entity.shopcar;
import com.cen.shopcar.service.ShopcarService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;

@Controller
@RequestMapping(value = "/sys/order")
public class SysOrderController extends BaseController {

	@Autowired
	ShopcarService ShopcarService;
	@Autowired
	AddressService AddressService;
	@Autowired
	private orderService orderService;
	@Autowired
	private ProductService productService;
	@Autowired
	private UserService UserService;
	@Autowired
	private MessageService MessageService;

	/**
	 * 查询订单
	 * 
	 * @param order
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectList", method = RequestMethod.GET)
	@ResponseBody
	public String selectList(order order, Integer pageNum, Date date1, Date date2,
			HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();                     

		String id = getUser(request).getId();

		pmap = MapUtils.beanToMap(order);
		pmap.put("start", date1);
		pmap.put("end", date2);
		List<order> orders2 = orderService.selectList(pmap);
		pmap.put("pageNum", (pageNum - 1) * 10);
		pmap.put("pageSize", pageSize);
		pmap.put("puid", id);// 查看自己发布的商品的订单

		List<Product> products = new ArrayList<>();
		List<order> orders = orderService.selectList(pmap);
		for (int i = 0; i < orders.size(); i++) {
			BigDecimal total = new BigDecimal(0);
			order order2 = orders.get(i);
			Product product = productService.selectByPrimaryKey(order2.getProductId());
			User user = UserService.selectByPrimaryKey(order2.getUserId());
			String[] shopcars = order2.getShopcarId().split(",");
			for (int j = 0; j < shopcars.length; j++) {
				shopcar shopcar = ShopcarService.selectByPrimaryKey(shopcars[j]);
				if(shopcar != null)
					total=total.add(shopcar.getPrice().multiply(new BigDecimal(shopcar.getNumber())));
			}
			System.out.println("cat:"+total);
			products.add(product);
			orders.get(i).setProductName(product.getName());
			orders.get(i).setProductImage(product.getImage());
			orders.get(i).setUsername(user.getName());
			orders.get(i).setTotal(total);
		}

		smap.put("orders", orders);
		smap.put("count", orders2.size());

		return toJSONString(smap);
	}
	/**
	 * 后台根据状态查询
	 * @param status
	 * @return
	 */
	@RequestMapping(value = "/selectListStatus", method = RequestMethod.GET)
	@ResponseBody
	public String selectList(Integer status,HttpServletRequest request, HttpServletResponse response, ModelMap map){
		Map<String, Object> smap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();                     

		String id = getUser(request).getId();
		pmap.put("userId", id);
		pmap.put("status", status);
		List<order> orders = orderService.selectList(pmap);
		smap.put("count", orders.size());
		return toJSONString(smap);
	}

	/**
	 * 查看订单信息
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
		order order = orderService.selectByPrimaryKey(id);
		List<shopcar> sList = new ArrayList<>();
		List<Product> products = new ArrayList<>();
		String[] shopcars = order.getShopcarId().split(",");
		for (int i = 0; i < shopcars.length; i++) {
			shopcar shopcar = ShopcarService.selectByPrimaryKey(shopcars[i]);
			sList.add(shopcar);
			products.add(productService.selectByPrimaryKey(shopcar.getProductId()));
		}

		smap.put("order", order);
		smap.put("shopcars", sList);
		smap.put("products", products);

		return toJSONString(smap);
	}

	/**
	 * 删除订单
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(String id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();

		order order = orderService.selectByPrimaryKey(id);
		Product product = productService.selectByPrimaryKey(order.getProductId());

		String[] shopcars = order.getShopcarId().split(",");
		List<specifications> List = JSON.parseArray(product.getSpecifications(), specifications.class);

		for (int i = 0; i < shopcars.length; i++) {
			shopcar shopcar = ShopcarService.selectByPrimaryKey(shopcars[i]);
			for (int j = 0; j < List.size(); j++) {
				specifications specifications = List.get(i);
				if (shopcar.getPid() == specifications.getId_()) {
					List.get(j).setStock(shopcar.getNumber() + specifications.getStock());
				}
			}
		}

		product.setSpecifications(toJSONString(List));
		productService.updateByPrimaryKeySelective(product);

		int result = orderService.deleteByPrimaryKey(id);
		if (result == 1) {
			umap.put("msg", "删除订单成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "删除订单失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}

	/**
	 * 提交物流号
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/logistics", method = RequestMethod.POST)
	@ResponseBody
	public String logistics(String id, String logistics, HttpServletRequest request, HttpServletResponse response,
			ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		order order = orderService.selectByPrimaryKey(id);

		order.setStatus(2);
		order.setLogistics(logistics);
		Product product = productService.selectByPrimaryKey(order.getProductId());

		Message message = new Message();
		message.setMessage("你的订单：" + product.getName() + " 发货了");
		message.setSendid(product.getUid());
		message.setType("Private");
		message.setPostdate(new Date());
		message.setTitle("订单模块");

		String[] recid = { order.getUserId() };

		MessageService.sendMessage(message, recid);

		int result = orderService.updateByPrimaryKeySelective(order);
		if (result == 1) {
			smap.put("msg", "提交成功");
			smap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			smap.put("msg", "提交失败");
			smap.put("status", ReturnInfoType.FAIL);
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

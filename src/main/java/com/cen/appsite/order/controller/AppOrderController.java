package com.cen.appsite.order.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
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

@Controller
@RequestMapping(value = "/appsite/order")
public class AppOrderController extends BaseController {

	@Autowired
	ShopcarService ShopcarService;
	@Autowired
	AddressService AddressService;
	@Autowired
	private orderService orderService;
	@Autowired
	private ProductService productService;
	@Autowired
	private MessageService MessageService;

	/**
	 * 添加订单
	 * 
	 * @param phone
	 * @param addressId
	 * @param shopcarId
	 * @param remark
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(String content, HttpServletRequest request, HttpServletResponse response) {
		List<order> list = JSON.parseArray(content, order.class);
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < list.size(); i++) {
			order order = list.get(i);
			shopcar shopcar = ShopcarService.selectByPrimaryKey(order.getShopcarId());
			Address address = AddressService.selectByPrimaryKey(order.getAddressId());
			System.out.println(address);
			Product product = productService.selectByPrimaryKey(shopcar.getProductId());
			System.out.println(product);
			List<specifications> List = JSON.parseArray(product.getSpecifications(), specifications.class);
			for (int j = 0; j < List.size(); j++) {
				specifications specifications = List.get(j);
				if (specifications.getId_() == shopcar.getPid()) {
					if (specifications.getStock() < shopcar.getNumber()) {
						map.put("msg", "库存不足");
						map.put("status", ReturnInfoType.FAIL);
						return toJSONString(map);
					} else {
						List.get(j).setStock(specifications.getStock() - shopcar.getNumber());
						product.setSpecifications(toJSONString(List));
						product.setSales(shopcar.getNumber() + product.getSales());
						productService.updateByPrimaryKeySelective(product);
					}
				}
			}

			order order2 = new order();

			order2.setPhone(address.getPhone());
			order2.setName(address.getName());
			order2.setAddressId(order.getAddressId());
			order2.setAddress(address.getAddress() + address.getDetailaddress());
			order2.setCreatetime(new Date());
			order2.setProductId(shopcar.getProductId());
			order2.setUserId(shopcar.getUserId());
			order2.setRemarks(order.getRemarks() == null ? "" : order.getRemarks());
			order2.setStatus(order.getStatus());
			// 如果订单有同一个未支付的商品(当前用户)，则叠加到订单
			order order3 = orderService.selectByPid(shopcar.getProductId(), getUser(request).getId());
			if (order3 != null && order3.getAddressId().equals(order.getAddressId())) {
				order3.setShopcarId(order3.getShopcarId() + "," + shopcar.getId());
				order3.setRemarks(order.getRemarks() == null ? "" : order.getRemarks());
				order3.setStatus(order.getStatus());
				// 从购物车删除
				shopcar.setStatus(1);
				ShopcarService.updateByPrimaryKeySelective(shopcar);

				int recond = orderService.updateByPrimaryKeySelective(order3);
				if (recond != 1) {
					map.put("msg", "添加订单失败");
					map.put("status", ReturnInfoType.FAIL);
					return toJSONString(map);
				}
			} else {
				order2.setShopcarId(shopcar.getId());
				// 从购物车删除
				shopcar.setStatus(1);
				ShopcarService.updateByPrimaryKeySelective(shopcar);

				Message message = new Message();
				message.setMessage("添加商品：" + product.getName() + " 到订单");
				message.setSendid(product.getUid());
				message.setType("Private");
				message.setPostdate(new Date());
				message.setTitle("订单模块");

				String[] recid = { shopcar.getUserId() };

				MessageService.sendMessage(message, recid);

				int recond = orderService.insertSelective(order2);
				if (recond != 1) {
					map.put("msg", "添加订单失败");
					map.put("status", ReturnInfoType.FAIL);
				}
			}
		}
		map.put("msg", "添加订单成功");
		map.put("status", ReturnInfoType.SUCEEESS);
		return toJSONString(map);
	}

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
	public String selectById(order order, Integer pageNum, Integer pageSize, HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();

		String id = getUser(request).getId();
		order.setUserId(id);
		pmap = MapUtils.beanToMap(order);
		List<order> orders2 = orderService.selectList(pmap);
		if (pageNum != null && pageSize != null) {
			pmap.put("pageNum", (pageNum - 1) * pageSize);
			pmap.put("pageSize", pageSize);
		}

		List<Product> products = new ArrayList<>();
		List<order> orders = orderService.selectList(pmap);
		Map<String, Object> omap = new HashMap<String, Object>();
		for (int i = 0; i < orders.size(); i++) {
			List<shopcar> shopcars = new ArrayList<>();
			order order2 = orders.get(i);
			String[] strings = order2.getShopcarId().split(",");
			for (int j = 0; j < strings.length; j++) {
				shopcars.add(ShopcarService.selectByPrimaryKey(strings[j]));
			}
			Product product = productService.selectByPrimaryKey(orders.get(i).getProductId());
			products.add(product);
			orders.get(i).setProductName(product.getName());
			orders.get(i).setProductImage(product.getImage());
			omap.put(order2.getId(), shopcars);
		}

		smap.put("shopcars", omap);
		smap.put("products", products);
		smap.put("orders", orders);
		smap.put("count", orders2.size());

		return toJSONString(smap);
	}

	/**
	 * 一次性查询5个订单分类
	 * 
	 * @param order
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectAll", method = RequestMethod.GET)
	@ResponseBody
	public String selectAll(order order, Integer pageNum, Integer pageSize, HttpServletRequest request,
			HttpServletResponse response, ModelMap map) {
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> amap = new HashMap<String, Object>();
		String id = getUser(request).getId();
		order.setUserId(id);
		Integer[] integers = { 10, 0, 1, 2, 3 };
		for (int k = 0; k < integers.length; k++) {
			Map<String, Object> smap = new HashMap<String, Object>();
			if (integers[k] != 10) {
				order.setStatus(integers[k]);
			}
			pmap = MapUtils.beanToMap(order);
			List<order> orders2 = orderService.selectList(pmap);
			if (pageNum != null && pageSize != null) {
				pmap.put("pageNum", (pageNum - 1) * pageSize);
				pmap.put("pageSize", pageSize);
			}
			List<Product> products = new ArrayList<>();
			List<order> orders = orderService.selectList(pmap);
			Map<String, Object> omap = new HashMap<String, Object>();
			for (int i = 0; i < orders.size(); i++) {
				List<shopcar> shopcars = new ArrayList<>();
				order order2 = orders.get(i);
				String[] strings = order2.getShopcarId().split(",");
				for (int j = 0; j < strings.length; j++) {
					shopcars.add(ShopcarService.selectByPrimaryKey(strings[j]));
				}
				Product product = productService.selectByPrimaryKey(orders.get(i).getProductId());
				products.add(product);
				orders.get(i).setProductName(product.getName());
				orders.get(i).setProductImage(product.getImage());
				omap.put(order2.getId(), shopcars);
			}

			smap.put("shopcars", omap);
			smap.put("products", products);
			smap.put("orders", orders);
			smap.put("count", orders2.size());
			amap.put(integers[k] + "", smap);
		}

		return toJSONString(amap);
	}

	/**
	 * 购买订单
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/buy", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String update(String id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		order order = orderService.selectByPrimaryKey(id);
		order.setStatus(1);
		orderService.updateByPrimaryKeySelective(order);
		umap.put("msg", "支付成功");
		return toJSONString(umap);
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
		String[] shopcars = order.getShopcarId().split(",");
		BigDecimal total = new BigDecimal(0);
		for (int i = 0; i < shopcars.length; i++) {
			shopcar shopcar = ShopcarService.selectByPrimaryKey(shopcars[i]);
			Product product = productService.selectByPrimaryKey(shopcar.getProductId());
			List<specifications> specifications = JSON.parseArray(product.getSpecifications(), specifications.class);
			for (int j = 0; j < specifications.size(); j++) {
				if (specifications.get(j).getId_() == shopcar.getPid()) {
					shopcar.setImage(specifications.get(j).getImage());
					shopcar.setName(product.getName()+"("+shopcar.getName()+")");
					break;
				}
			}
			total.add(shopcar.getPrice().multiply(new BigDecimal(shopcar.getNumber())));
			sList.add(shopcar);
		}
		smap.put("total", total);
		smap.put("order", order);
		smap.put("shopcars", sList);

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

		if (getUser(request) == null) {
			umap.put("msg", "请先登录");
			umap.put("status", ReturnInfoType.FAIL);
		}

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
	
	@RequestMapping(value = "/confirm", method = RequestMethod.POST)
	@ResponseBody
	public String confirm(String id, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();

		if (getUser(request) == null) {
			umap.put("msg", "请先登录");
			umap.put("status", ReturnInfoType.FAIL);
		}
		
		order order = orderService.selectByPrimaryKey(id);
		order.setStatus(3);
		int res = orderService.updateByPrimaryKeySelective(order);
		if (res == 1) {
			umap.put("msg", "确认收货成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "确认收货失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
}

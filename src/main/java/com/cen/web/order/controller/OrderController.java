package com.cen.web.order.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
import com.cen.ucenter.entity.User;

@Controller
@ServerEndpoint("/webSocket/{username}")
@RequestMapping(value = "/web/order")
public class OrderController extends BaseController {

	private static Map<String, OrderController> clients = new ConcurrentHashMap<String, OrderController>();
	private Session session;
	private String username;

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

	@OnOpen
	public void onOpen(@PathParam("username") String username, Session session) throws IOException {
		this.username = username;
		this.session = session;
		clients.put(username, this);
		System.out.println(username + "已连接");
	}

	@OnClose
	public void onClose() throws IOException {
		clients.remove(username);
	}

	public void sendMessageTo(String message,String id) throws IOException {
		for (OrderController item : clients.values()) {  
            if (item.username.equals(id)){
            	item.session.getAsyncRemote().sendText(message);  
            	break;
            }
        }  
	}

	/**
	 * 用户“立即购买”生成订单
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/buynow", method = RequestMethod.POST)
	@ResponseBody
	@Transactional
	public String buynow(order order, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> rMap = new HashMap<>();
		User user = getUser(request);
		if(user == null){
			rMap.put("msg", "请先登录");
			rMap.put("status", ReturnInfoType.FAIL);
			return toJSONString(rMap);
		}

		Address address = AddressService.selectByPrimaryKey(order.getAddressId());
		if (address == null){
			rMap.put("msg", "收货地址错误");
			rMap.put("status", ReturnInfoType.FAIL);
			return toJSONString(rMap);
		}



		//插入购物车
		Product product = productService.selectByPrimaryKey(order.getProductId());
		if(product == null){
			rMap.put("msg", "商品不存在");
			rMap.put("status", ReturnInfoType.FAIL);
			return toJSONString(rMap);
		}
		shopcar shopcar = new shopcar();
		shopcar.setCreatetime(new Date());
		shopcar.setUserId(user.getId());
		shopcar.setStatus(1);
		shopcar.setNumber(order.getNumber());
		shopcar.setName(product.getName());
		shopcar.setPid(1);
		shopcar.setProductId(order.getProductId());

		String specifications = product.getSpecifications();
		JSONArray array = JSONObject.parseArray(specifications);
		shopcar.setPrice(BigDecimal.valueOf(array.getJSONObject(0).getDouble("price")));
		int res = ShopcarService.insertSelective(shopcar);

		//生成订单
		order.setPhone(address.getPhone());
		order.setName(address.getName());
		order.setStatus(0); // 0-待付款
		order.setAddress(address.getAddress() + address.getDetailaddress());
		order.setShopcarId(shopcar.getId());
		order.setUserId(user.getId());
		order.setCreatetime(new Date());
		int res2 = orderService.insertSelective(order);
		if(res > 0 && res2 > 0){
			rMap.put("msg", "提交订单成功");
			rMap.put("status", ReturnInfoType.SUCEEESS);
			rMap.put("orderId", order.getId());
		}else{
			rMap.put("msg", "提交订单失败");
			rMap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(rMap);
	}

	/**
	 * 获取订单信息 -- 订单支付页面
	 * @return
	 */
	@RequestMapping(value = "/getOrderInfo", method = RequestMethod.POST)
	@ResponseBody
	public String getOrderInfo(String orderId, String[] orderIdList, String way, HttpServletRequest request){
		Map<String, Object> rMap = new HashMap<>();
		rMap.put("msg", "获取订单信息异常");
		rMap.put("status", ReturnInfoType.FAIL);

		User user = getUser(request);
		if(user == null){
			rMap.put("msg", "请先登录");
			rMap.put("status", ReturnInfoType.FAIL);
			return toJSONString(rMap);
		}

		if(way.equals("car")){ //购物车结算
			StringBuffer sb = new StringBuffer();
			BigDecimal price = new BigDecimal(0);
			int count = 0;
			for (String rId : orderIdList) {
				order order = orderService.selectByPrimaryKey(rId);
				if(order == null){
					return toJSONString(rMap);
				}
				shopcar shopcar = ShopcarService.selectByPrimaryKey(order.getShopcarId());
				if(shopcar != null){
					BigDecimal num = new BigDecimal(shopcar.getNumber().toString());
					BigDecimal multiply = num.multiply(shopcar.getPrice());
					price = price.add(multiply);
					if(count < orderIdList.length -1){
						sb.append(shopcar.getName());
						sb.append(" | ");
					}else{
						sb.append(shopcar.getName());
					}
				}
				count++;
			}
			rMap.put("name", sb.toString());
			rMap.put("price", price);
			rMap.put("msg", "获取订单信息成功");
			rMap.put("status", ReturnInfoType.SUCEEESS);

		}else{
			order order = orderService.selectByPrimaryKey(orderId);
			if(order == null){
				return toJSONString(rMap);
			}
			shopcar shopcar = ShopcarService.selectByPrimaryKey(order.getShopcarId());
			if(shopcar != null){
				BigDecimal num = new BigDecimal(shopcar.getNumber().toString());
				BigDecimal multiply = num.multiply(shopcar.getPrice());
				rMap.put("name", shopcar.getName());
				rMap.put("price", multiply);
				rMap.put("msg", "获取订单信息成功");
				rMap.put("status", ReturnInfoType.SUCEEESS);
			}
		}

		return toJSONString(rMap);
	}



	/**
	 * 添加订单
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(String content, HttpServletRequest request, HttpServletResponse response) {
		List<order> list = JSON.parseArray(content, order.class);
		Map<String, Object> map = new HashMap<String, Object>();
		List<String> orderIdList = new ArrayList<>();

		for (int i = 0; i < list.size(); i++) {
			order order = list.get(i);
			shopcar shopcar = ShopcarService.selectByPrimaryKey(order.getShopcarId());
			Address address = AddressService.selectByPrimaryKey(order.getAddressId());
			Product product = productService.selectByPrimaryKey(shopcar.getProductId());
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
				}else{
					orderIdList.add(order2.getId());
				}
			}
		}
		map.put("msg", "添加订单成功");
		map.put("status", ReturnInfoType.SUCEEESS);
		map.put("orderIdList", orderIdList);
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

		// 1.根据用户id查到的订单
		List<order> orders1 = orderService.selectList(pmap);

		List<order> orders = new ArrayList<>();
		if (pageNum != null && pageSize != null) {
			pmap.put("pageNum", (pageNum - 1) * pageSize);
			pmap.put("pageSize", pageSize);
			orders = orderService.selectList(pmap);
			HashMap<String, List<shopcar>> hashMap = new HashMap<>();
			for (int i = 0; i < orders.size(); i++) {
				order order2 = orders.get(i);
				List<specifications> specifications = JSON.parseArray(order2.getSpecifications(), specifications.class);
				String[] shopcars = order2.getShopcarId().split(",");
				List<shopcar> list = new ArrayList<>();
				for (int j = 0; j < shopcars.length; j++) {
					shopcar shopcar = ShopcarService.selectByPrimaryKey(shopcars[j]);
					if(shopcar != null){
						for (int k = 0; k < specifications.size(); k++) {
							specifications specifications2 = specifications.get(k);
							if (specifications2.getId_() == shopcar.getPid()) {
								shopcar.setImage(specifications2.getImage());
								shopcar.setOrderTime(order2.getCreatetime());
								shopcar.setOrderStatus(order2.getStatus());
								shopcar.setOrderId(order2.getId());
								break;
							}
						}

						list.add(shopcar);
					}
				}
				hashMap.put(order2.getId(), list);
			}
			smap.put("orders", hashMap);
			smap.put("count", orders1.size());
		} else {
			pmap.put("pageNum", (pageNum - 1) * 10);
			pmap.put("pageSize", 10);
			orders = orderService.selectList(pmap);
			smap.put("orders", orders);
			smap.put("count", orders1.size());
		}

		return toJSONString(smap);
	}

	/**
	 * 获取全部订单分类的数量
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectListCount", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();

		String id = getUser(request).getId();
		order order = new order();
		order.setUserId(id);
		pmap = MapUtils.beanToMap(order);
		List<order> orders = orderService.selectList(pmap);
		List<Integer> counts = new ArrayList<>();
		counts.add(orders.size());
		for (int i = 0; i < 4; i++) {
			order.setStatus(i);
			pmap = MapUtils.beanToMap(order);
			List<order> orders1 = orderService.selectList(pmap);
			counts.add(orders1.size());
		}
		smap.put("count", counts);
		return toJSONString(smap);
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
		User user = getUser(request);
		Map<String, Object> umap = new HashMap<String, Object>();
		order order = orderService.selectByPrimaryKey(id);
		order.setStatus(1);
		orderService.updateByPrimaryKeySelective(order);
		umap.put("msg", "支付成功");
		try {
			sendMessageTo("success",user.getId());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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

	/**
	 * 确认收货
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/confirm",method = RequestMethod.POST)
	@ResponseBody
	public String confirm(order order,HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> rMap = new HashMap<>();
		if (getUser(request) == null) {
			rMap.put("msg", "请先登录");
			rMap.put("status", ReturnInfoType.FAIL);
		}
		order.setStatus(3);
		int result = orderService.updateByPrimaryKeySelective(order);
		if(result > 0){
			rMap.put("msg","确认收货成功");
			rMap.put("status",ReturnInfoType.SUCEEESS);
		}else{
			rMap.put("msg","确认收货失败");
			rMap.put("status",ReturnInfoType.FAIL);
		}
		return toJSONString(rMap);
	}
}

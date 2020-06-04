package com.cen.appsite.shopcar.controller;

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
import com.cen.address.entity.Address;
import com.cen.address.service.AddressService;
import com.cen.appsite.shopcar.utill.AppUtill;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.product.entity.Product;
import com.cen.product.entity.specifications;
import com.cen.product.service.ProductService;
import com.cen.shopcar.entity.shopcar;
import com.cen.shopcar.service.ShopcarService;
import com.cen.ucenter.service.UserService;

@Controller
@RequestMapping(value = "/appsite/shopcar")
public class AppShopcarController extends BaseController {
	@Autowired
	UserService userService;
	@Autowired
	ProductService productService;
	@Autowired
	ShopcarService shopcarService;
	@Autowired
	AddressService AddressService;

	/**
	 * 添加购物车
	 * 
	 * @param specifications
	 *            型号
	 * @param number
	 *            购买数量
	 * @param id
	 *            商品id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(specifications specifications, Integer number, String id, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		// 如果是未登录状态
		if (getUser(request) == null) {
			map.put("msg", "请先登录");
			map.put("status", ReturnInfoType.FAIL);
			return toJSONString(map);
		}
		Product product = productService.selectByPrimaryKey(id);
		List<specifications> list = JSON.parseArray(product.getSpecifications(), specifications.class);
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getId_() == specifications.getId_()) {
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
		shopcar.setStatus(0);// 未支付
		shopcar.setUserId(getUser(request).getId());
		shopcar.setProductId(id);

		pmap.put("pid", shopcar.getPid());
		pmap.put("productId", shopcar.getProductId());
		List<shopcar> shopcars = shopcarService.selectList(pmap);
		if (shopcars.size() > 0 && shopcars.get(0).getStatus() == 0) {
			shopcar shopcar2 = shopcars.get(0);
			// 如果小于0
			if (shopcar2.getNumber() + number < 0) {
				map.put("msg", "错误");
				map.put("status", ReturnInfoType.FAIL);
				return toJSONString(map);
			}
			// 如果超出库存
			if (specifications.getStock() < shopcar2.getNumber() + number) {
				map.put("msg", specifications.getName() + ":数量超出库存");
				map.put("status", ReturnInfoType.SUCEEESS);
				//超出库存
				map.put("max", ReturnInfoType.SUCEEESS);
				return toJSONString(map);
			}
			// 数量叠加
			shopcar2.setNumber(shopcar2.getNumber() + shopcar.getNumber());

			int recond1 = shopcarService.updateByPrimaryKeySelective(shopcar2);
			if (recond1 == 1) {
				map.put("id", shopcar2.getId());
				map.put("msg", "添加成功");
				map.put("status", ReturnInfoType.SUCEEESS);
			} else {
				map.put("msg", "添加失败");
				map.put("status", ReturnInfoType.FAIL);
			}
			return toJSONString(map);
		} else {
			int recond1 = shopcarService.insertSelective(shopcar);
			if (recond1 == 1) {
				map.put("id", shopcar.getId());
				map.put("msg", "添加成功");
				map.put("status", ReturnInfoType.SUCEEESS);
			} else {
				map.put("msg", "添加失败");
				map.put("status", ReturnInfoType.FAIL);
			}
			return toJSONString(map);
		}
	}

	/**
	 * 查看购物车
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/shopcar", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Map<String, Object> pmap = new HashMap<String, Object>();
		String id = getUser(request).getId();

		pmap.put("userId", id);
		pmap.put("status", 0);
		List<shopcar> shopcars = shopcarService.selectList(pmap);
		List<Product> products = new ArrayList<>();

		for (int i = 0; i < shopcars.size(); i++) {
			String pid = shopcars.get(i).getProductId();
			System.out.println(pid);
			Product product = productService.selectByPrimaryKey(pid);
			products.add(product);
		}
		smap.put("products", products);
		smap.put("shopcars", shopcars);

		return toJSONString(smap);
	}

	/**
	 * 提交购物车获取订单列表
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/shopcarList", method = RequestMethod.POST)
	@ResponseBody
	public String shopcarList(String content, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Map<String, Object> amap = new HashMap<String, Object>();
		String id = getUser(request).getId();
		amap.put("userid", id);
		List<Address> addresses = AddressService.selectList(amap);
		String[] sid = content.split(",");
		List<shopcar> shopcars = new ArrayList<>();
		List<Product> products = new ArrayList<>();
		for (int i = 0; i < sid.length; i++) {
			shopcar shopcar = shopcarService.selectByPrimaryKey(sid[i]);
			Product product = productService.selectByPrimaryKey(shopcar.getProductId());
			shopcars.add(shopcar);
			products.add(product);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		BigDecimal total = new BigDecimal(0);
		products = AppUtill.removeDuplicate(products);
		for (int i = 0; i < products.size(); i++) {
			List<specifications> specifications = JSON.parseArray(products.get(i).getSpecifications(),
					specifications.class);
			List<shopcar> shopcars2 = new ArrayList<>();
			for (int j = 0; j < shopcars.size(); j++) {
				shopcar shopcar = shopcars.get(j);
				if (shopcar.getProductId().equals(products.get(i).getId())) {
					for (int k = 0; k < specifications.size(); k++) {
						if (specifications.get(k).getId_() == shopcar.getPid()) {
							shopcars.get(j).setImage(specifications.get(k).getImage());
							break;
						}
					}
					shopcars.get(j).setProductName(products.get(i).getName());
					shopcars.get(j).setProductDesc(products.get(i).getDescription());
					shopcars2.add(shopcar);
					total.add(shopcar.getPrice().multiply(new BigDecimal(shopcar.getNumber()))) ;
				}
			}
			map.put(products.get(i).getId(), shopcars2);
		}
		smap.put("total", total);
		smap.put("orders", map);
		smap.put("addresses", addresses);
		return toJSONString(smap);
	}

	/**
	 * 查看某个购物车
	 * 
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	@ResponseBody
	public String select(String shopcarId, HttpServletRequest request, HttpServletResponse response, ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();

		shopcar shopcar = shopcarService.selectByPrimaryKey(shopcarId);
		Product product = productService.selectByPrimaryKey(shopcar.getProductId());

		smap.put("shopcar", shopcar);
		smap.put("product", product);

		return toJSONString(smap);
	}

	/**
	 * 删除购物车
	 * 
	 * @param id1
	 * @param id2
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(String id1, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		String id = getUser(request).getId();// 用户id
		// 如果购物车用户id不匹配
		if (!shopcarService.selectByPrimaryKey(id1).getUserId().equals(id)) {
			umap.put("msg", "错误");
			umap.put("status", ReturnInfoType.FAIL);
		} else {
			int result1 = shopcarService.deleteByPrimaryKey(id1);
			if (result1 == 1) {
				umap.put("msg", "删除成功");
				umap.put("status", ReturnInfoType.SUCEEESS);
			} else {
				umap.put("msg", "删除失败");
				umap.put("status", ReturnInfoType.FAIL);
			}
		}
		return toJSONString(umap);
	}

	/**
	 * 删除购物车全部
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/deleteAll", method = RequestMethod.POST)
	@ResponseBody
	public String delete(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Map<String, Object> smap = new HashMap<String, Object>();
		String id = getUser(request).getId();// 用户id
		List<String> list = new ArrayList<>();
		list.add(id);
		smap.put("List", list);
		int result = shopcarService.deleteBat(smap);
		if (result == 1) {
			umap.put("msg", "全部删除成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "全部删除失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
}

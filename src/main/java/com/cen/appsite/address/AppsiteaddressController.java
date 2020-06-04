package com.cen.appsite.address;

import com.cen.address.entity.Address;
import com.cen.address.service.AddressService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.ucenter.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/appsite/address")
public class AppsiteaddressController extends BaseController {

	@Autowired
	AddressService addressService;

	/**
	 * 添加apk
	 * 
	 * @param
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public String insert(Address address, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> cmap = new HashMap<String, Object>();
		address.setCreateDate(new Date());
		address.setIsDel(0);
		address.setAddress(address.getProvince()+address.getCity()+address.getArea());
		if(address.getState()==null){
			address.setState(0);
		}else {
			addressService.updateState(address.getUserid());
		}
		int a=addressService.insert(address);


		cmap.put("msg", "添加成功");
		cmap.put("status", ReturnInfoType.SUCEEESS);
		return toJSONString(cmap);
	}



	/**
	 * 查询所有地址
	 * 
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/selectList", method = RequestMethod.GET)
	@ResponseBody
	public String selectList(String userid, int pageNum, HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("userid", userid);
		List<Address> addressList=addressService.selectList( pmap);

		dmap.put("list", addressList);
		dmap.put("count", addressList.size());
		return toJSONString(dmap);
	}

    /****
     * 手机端查询所有地址
	 * @param request
     * @param response
     * @param map
     * @return
     */
	@RequestMapping(value = "/selectAddressList", method = RequestMethod.GET)
	@ResponseBody
	public String selectAddressList( HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> dmap = new HashMap<String, Object>();
		User u =getUser(request);
		pmap.put("userid", u.getId());
		List<Address> addressList=addressService.selectList( pmap);
		Address address=addressService.getuserAddress(u.getId());
		dmap.put("address", address);
		dmap.put("list", addressList);
		dmap.put("count", addressList.size());
		return toJSONString(dmap);
	}
	/**
	 * 查询用户默认地址
	 *
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/getuserAddress", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	@ResponseBody
	public String getuserAddress(String userid,HttpServletRequest request, HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Address address=addressService.getuserAddress(userid);
		dmap.put("address", address);
		return toJSONString(dmap);
	}


	/**
	 * 根据id删除apk
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
		int result = addressService.deleteByPrimaryKey(id);
		if (result == 1) {
			umap.put("msg", "删除成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "删除失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
	/**
	 * 根据id删除apk
	 *
	 * @param id
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/changestate", method = RequestMethod.POST)
	@ResponseBody
	public String changestate(String id,String userid, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Address ad = addressService.selectByPrimaryKey(id);
		ad.setState(1);
		int result=0;
		int change= addressService.updateState(userid);
		if(change>0){
			result= addressService.updateByPrimaryKeySelective(ad);
		}
		if (result == 1) {
			umap.put("msg", "修改成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "修改失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}
	/**
	 * 跳转update更新页面
	 * @param id
	 * @param
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/toupdate", method = RequestMethod.GET)
	@ResponseBody
	public String toupdate(String id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		Address address = addressService.selectByPrimaryKey(id);
		umap.put("address", address);
		return toJSONString(umap);
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(Address address, HttpServletRequest request, HttpServletResponse response,
						 ModelMap map) {
		Map<String, Object> umap = new HashMap<String, Object>();
		address.setAddress(address.getProvince()+address.getCity()+address.getArea());
		int count = addressService.updateByPrimaryKeySelective(address);
		if (count == 1) {
			umap.put("msg", "更新成功");
			umap.put("status", ReturnInfoType.SUCEEESS);
		} else {
			umap.put("msg", "更新失败");
			umap.put("status", ReturnInfoType.FAIL);
		}
		return toJSONString(umap);
	}

}

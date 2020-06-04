package com.cen.iproll.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.operateLog.annotation.UserOperate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.iproll.entity.IpRoll;
import com.cen.iproll.service.iprollService;

@Controller
@RequestMapping("/sys/iproll")
public class iprollController extends BaseController{
	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
    private iprollService iprollService;

	/**
	 * 添加黑白名单
	 * @param ipRoll
	 * @param request
	 * @param response
	 * @return
	 */
	@UserOperate(moduleName="黑白名单",option = "添加黑白名单")
	@RequestMapping(value="/insert",method=RequestMethod.POST)
	@ResponseBody
	public String insert(IpRoll ipRoll,HttpServletRequest request,HttpServletResponse response){

		Map<String, Object> map = new HashMap<String, Object>();

		IpRoll ip = iprollService.selectByIp(ipRoll.getIpaddress().trim()); //查询ip

		if(isEmpty(ip)){
			ipRoll.setCreatetime(new Date());
			ipRoll.setIsDel(0);
			iprollService.insertSelective(ipRoll);
			map.put("msg", "数据添加成功");
			map.put("status", ReturnInfoType.SUCEEESS);
		}else{
			map.put("msg", "ip已存在");
			map.put("status", ReturnInfoType.ERROR);
		}
		return toJSONString(map);
	}


	/**
	 *
	 * @param ipRoll
	 * @param pageNum
	 * @param startTime
	 * @param endTime
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws ParseException
	 */
	@UserOperate(moduleName="黑白名单",option = "查看黑白名单列表")
	@RequestMapping(value="/selectList",method=RequestMethod.GET)
	@ResponseBody
	public String selectList(IpRoll ipRoll,Integer pageNum,String startTime,String endTime,
			HttpServletRequest request,HttpServletResponse response,ModelMap map) throws ParseException{

		Date start = null;
		Date end = null;

		//System.out.println("String开始时间" + startTime);
		//System.out.println("String结束时间" + endTime);

		if (!isEmpty(startTime) && !isEmpty(endTime)) {
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			start = df.parse(startTime);
			end = df.parse(endTime);
		}

		//System.out.println("Date开始时间" + start);
		//System.out.println("Date结束时间" + end);

		Map<String, Object> pmap = new HashMap<String, Object>();
		Map<String, Object> smap = new HashMap<String, Object>();

		pmap = MapUtils.beanToMap(ipRoll);
		pmap.put("pageNum", getPageNum(pageNum));
		pmap.put("pageSize", pageSize);
		pmap.put("start", start);
		pmap.put("end", end);

		List<IpRoll> list = iprollService.selectList(pmap);
		int count = iprollService.selectListCount(pmap);

		if(!isEmpty(list)) smap.put("list", list);
		smap.put("count", count);
		return toJSONString(smap);
	}

	/**
	 *
	 * @param ipRoll
	 * @param request
	 * @param response
	 * @return
	 */
	@UserOperate(moduleName="黑白名单",option = "更新黑白名单信息")
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public String update(IpRoll ipRoll,HttpServletRequest request, HttpServletResponse response){

		Map<String, Object> umap = new HashMap<String, Object>();
		int count = iprollService.updateByPrimaryKeySelective(ipRoll);
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

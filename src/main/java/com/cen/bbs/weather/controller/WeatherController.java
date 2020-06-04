package com.cen.bbs.weather.controller;


import com.alibaba.fastjson.JSONObject;
import com.cen.bbs.comment.entity.Comment;
import com.cen.bbs.comment.service.CommentService;
import com.cen.bbs.favorite.entity.Favorite;
import com.cen.bbs.favorite.service.FavoriteService;
import com.cen.bbs.toconmment.entity.Toconmment;
import com.cen.bbs.toconmment.service.ToconmmentService;
import com.cen.bbs.topic.entity.Topic;
import com.cen.bbs.topic.service.TopicService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.HttpUtil;
import com.cen.common.util.ReturnInfoType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping("/weather")
public class WeatherController extends BaseController{
	/**
	 * 根据城市查询下级地市
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/selectweather",method=RequestMethod.POST)
	@ResponseBody
	public String answer(HttpServletRequest request,HttpServletResponse response, ModelMap map) {

		Map<String, Object> dmap = new HashMap<String, Object>();
		Map<String, String> params2 = new HashMap<String, String>();
		String city="南宁";

		String s = HttpUtil.getIpAddr(request);//获取IP地址

		dmap.put("client-ip",HttpUtil.getIpAddr(request));

		try {

			params2.put("ip", s);///
			String data22=HttpUtil.sendGet("http://ip.taobao.com/service/getIpInfo.php",params2);//根据ip获取地址
			JSONObject jsonObject22 = JSONObject.parseObject(data22);
			JSONObject jsonObject0 = JSONObject.parseObject(jsonObject22.get("data").toString());
			city = jsonObject0.getString("city");//获取城市名称
		}catch (Exception e){
			System.out.println(e);
		}



		Map<String, String> params = new HashMap<String, String>();
		if(city.contains("ip")){
			city="南宁";
		}
		params.put("city", city);
		//String data={"code":200,"msg":"成功!","data":{"yesterday":{"date":"20日星期三","high":"高温 15℃","fx":"东风","low":"低温 10℃","fl":"\u003c![CDATA[\u003c3级]]\u003e","type":"小雨"},"city":"南宁","aqi":null,"forecast":[{"date":"21日星期四","high":"高温 18℃","fengli":"\u003c![CDATA[\u003c3级]]\u003e","low":"低温 11℃","fengxiang":"东北风","type":"小雨"},{"date":"22日星期五","high":"高温 17℃","fengli":"\u003c![CDATA[\u003c3级]]\u003e","low":"低温 11℃","fengxiang":"东北风","type":"阴"},{"date":"23日星期六","high":"高温 14℃","fengli":"\u003c![CDATA[\u003c3级]]\u003e","low":"低温 10℃","fengxiang":"东北风","type":"小雨"},{"date":"24日星期天","high":"高温 15℃","fengli":"\u003c![CDATA[\u003c3级]]\u003e","low":"低温 10℃","fengxiang":"东北风","type":"阴"},{"date":"25日星期一","high":"高温 15℃","fengli":"\u003c![CDATA[\u003c3级]]\u003e","low":"低温 12℃","fengxiang":"东北风","type":"小雨"}],"ganmao":"天冷空气湿度大且昼夜温差也很大，易发生感冒，请注意适当增减衣服。","wendu":"13"}}
		String data=HttpUtil.sendGet("https://www.apiopen.top/weatherApi",params);//根据城市名称获取天气情况
		JSONObject jsonObject = JSONObject.parseObject(data);///把天气数据转化成JSONObject格式

		dmap.put("status", ReturnInfoType.SUCEEESS);
		dmap.put("data", jsonObject);
		return toJSONString(dmap);
	}





}


package com.cen.appsite.wechat.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentLinkedQueue;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cen.appsite.wechat.util.ConfigUtil;
import com.cen.appsite.wechat.util.HttpRequestUtil;
import com.cen.appsite.wechat.util.Sign;
import com.cen.appsite.wechat.util.WeChatUtil;
import com.cen.appsite.wechat.util.WxCustomerServiceMessageUtil;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ResData;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;

@Controller
@RequestMapping("/appsite/wechat")
public class WeChatController extends BaseController {
	
	@Autowired
	UserService UserService;
	/**
	 * 通过code换取网页授权access_token
	 * 
	 * @param request
	 * @param response
	 * @return access_token 网页授权接口调用凭证,注意：此access_token与基础支持的access_token不同
	 *         expires_in access_token接口调用凭证超时时间，单位（秒） refresh_token
	 *         用户刷新access_token openid
	 *         用户唯一标识，请注意，在未关注公众号时，用户访问公众号的网页，也会产生一个用户和公众号唯一的OpenID scope
	 *         用户授权的作用域，使用逗号（,）分隔
	 */
	@RequestMapping(value = "/getAccess_token", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getAccess_token(HttpServletRequest request, HttpServletResponse response) {
		String code = request.getParameter("code");
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token";
		Map<String, String> params = new HashMap<String, String>();
		params.put("appid", ConfigUtil.APPID);
		params.put("secret", ConfigUtil.APP_SECRET);
		params.put("code", code);
		params.put("grant_type", "authorization_code");
		String result = HttpRequestUtil.getInfoByNet(url, params, "POST", "https", null);
		return result;
	}
	
	/**
     * 返回微信配置需要的
     * appId: appID, // 必填，公众号的唯一标识
     * timestamp: timestamp1, // 必填，生成签名的时间戳
     * nonceStr: nonceStr1, // 必填，生成签名的随机串
     * signature: signature1,// 必填，签名
     */
    @RequestMapping(value = "/config", method = RequestMethod.GET,produces = "application/json; charset=utf-8")
    @ResponseBody
    public String config(HttpServletRequest request, HttpServletResponse response){
        // 注意 URL 一定要动态获取，不能 hardcode
        String url = request.getParameter("url");
        //如果时间戳缓存为空串，说明第一次访问，一切都需要重新设置
        //如果缓存时间戳与当前时间差距大于7000s，则需要重新获取，时间戳为10位，既S为单位
        Long nowTime = (System.currentTimeMillis() / 1000);
        if(ConfigUtil.TIMESTAMP.equals("")||(nowTime-Long.valueOf(ConfigUtil.TIMESTAMP))>7100){
            WeChatUtil.getAccessToken();
            WeChatUtil.getJsapiTicket();
            Map<String, String> ret = Sign.sign(ConfigUtil.JSAPI_TICKET, url);
            return JSON.toJSONString(ret);
        }else{
            //调用旧的设置
            Map<String, String> ret = new HashMap<String, String>();
            ret.put("appId",ConfigUtil.APPID);
            ret.put("url", url);
            ret.put("jsapi_ticket", ConfigUtil.JSAPI_TICKET);
            ret.put("nonceStr", ConfigUtil.NONCESTR);
            ret.put("timestamp", ConfigUtil.TIMESTAMP);
            ret.put("signature", ConfigUtil.SIGNATURE);
            return JSON.toJSONString(ret);
        }
    }
	
    /**
     * 更新签名
     */
    @RequestMapping(value = "/updateSignature")
    @ResponseBody
    public String updateSignature(String url,HttpServletRequest request){
        WeChatUtil.getAccessToken();
        WeChatUtil.getJsapiTicket();
        Map<String, String> ret = Sign.sign(ConfigUtil.JSAPI_TICKET, url);
        return ResData.SUCCESS().toString();
    }
    
}

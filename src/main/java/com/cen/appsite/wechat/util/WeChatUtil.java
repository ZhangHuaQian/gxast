package com.cen.appsite.wechat.util;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * 获取微信开发必要参数工具类
 *
 */
@Service
public class WeChatUtil{

    /*public static void main(String[] args){
        getAccessToken();
    }*/

    /** 
     * 获取access_token
     */
    public static void getAccessToken(){
        Map<String,String> params = new HashMap<String, String>();
        params.put("grant_type",ConfigUtil.GRANT_TYPE);
        params.put("appid",ConfigUtil.APPID);
        params.put("secret",ConfigUtil.APP_SECRET);
        String result = HttpRequestUtil.getRequest(ConfigUtil.ACCESS_TOKEN_URL,params);
        AccessToken access = GsonUtil.fromJson(result,AccessToken.class);
        ConfigUtil.ACCESS_TOKEN = access.getAccess_token();
        //System.out.println("access_token:   "+ConfigUtil.ACCESS_TOKEN);
    }

    /**
     * 获取jsapi_ticket
     */
    public static void getJsapiTicket(){
        Map<String,String> params = new HashMap<String, String>();
        params.put("access_token",ConfigUtil.ACCESS_TOKEN);
        params.put("type",ConfigUtil.JSAPI_TICKET_TYPE);
        String result = HttpRequestUtil.getRequest(ConfigUtil.JSAPI_TICKET_URL,params);
        JsapiTicket ticket = GsonUtil.fromJson(result,JsapiTicket.class);
        //System.out.println("ticket: "+ticket.getTicket());
        ConfigUtil.JSAPI_TICKET = ticket.getTicket();
    }
}

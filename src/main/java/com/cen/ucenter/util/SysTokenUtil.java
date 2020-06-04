package com.cen.ucenter.util;

import com.cen.common.util.ReturnInfoType;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by cenguocheng on 2018/10/31.
 * 137544496@qq.com
 */
public class SysTokenUtil {

    /**
     * 获取token
     * @param request
     * @return
     */
    public static String getToken(HttpServletRequest request){

        String token = "";
        // Header 获取 token
        if(token==null || token.equals("")){
            token =  request.getHeader(ReturnInfoType.cen_xczhapp_token);
            //System.out.println("Header:"+token);
        }

        // 参数 获取 token
        if(token==null || token.equals("")){
            token =  request.getParameter(ReturnInfoType.cen_xczhapp_token);
            //System.out.println("getParameter:"+token);
        }

        // cookie 获取 token
        if(token==null || token.equals("")){
            if(request.getCookies()!=null){
                for (Cookie c:request.getCookies()) {
                    if (c.getName().equals(ReturnInfoType.cen_xczhapp_token)){
                        token = c.getValue();
                    }
                }
            }
            //System.out.println("getCookies:"+token);
        }

        return token;
    }

}

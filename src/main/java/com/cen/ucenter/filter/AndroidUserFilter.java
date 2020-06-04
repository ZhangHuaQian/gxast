package com.cen.ucenter.filter;

import com.alibaba.fastjson.JSON;
import com.cen.common.cache.EHCacheUtil;
import com.cen.common.util.C;
import com.cen.common.util.ResData;
import com.cen.common.util.ReturnInfoType;
import com.cen.common.util.Status;
import com.cen.ucenter.controller.LoginController;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.util.JwtUtil;
import com.cen.ucenter.util.SysTokenUtil;
import org.apache.shiro.web.filter.authc.UserFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;


/**
 * Created by cenguocheng on 2018/7/19.
 * 137544496@qq.com
 * 手机端请求过滤器
 */
public class AndroidUserFilter extends UserFilter {

    private static final Logger logger = LoggerFactory.getLogger(AndroidUserFilter.class);

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
        if(logger.isErrorEnabled()) {
            logger.error("account need login for: {}",  ((HttpServletRequest)request).getServletPath());
        }
        HttpServletRequest requests = (HttpServletRequest)request;
        HttpServletResponse responses = (HttpServletResponse) response;
        String token = SysTokenUtil.getToken(requests);
        logger.info(token);
        JwtUtil jwtUtil = new JwtUtil();
        if(jwtUtil.verify(token)){
            resError(responses);
            return false;
        }else{
            User user = (User)EHCacheUtil.get(ReturnInfoType.cen_xczhapp_token,token); //从缓存获取
            if(user!=null){ // 没有过期,重新认证
                LoginController lc = new LoginController();
                ResData resData = lc.loginHandle(user,false,requests,responses);
                return resData.getStatus().equals(Status.SUCCESS.status)?true:false;
            }else{
                resError(responses);
                return false;
            }
        }

    }


    private void resError(HttpServletResponse responses) throws IOException {
        responses.setCharacterEncoding("UTF-8");
        responses.setContentType("application/json");
        PrintWriter write = responses.getWriter();
        write.write(JSON.toJSONString(new ResData(Status.Token_Expired.status,Status.Token_Expired.msg)));
        write.close();
    }

    /**
     * 是否放行
     */
    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        /*if (null != getSubject(request, response)
                && getSubject(request, response).isAuthenticated()) {
            return true;//已经认证过直接放行
        }*/
        return false;//转到拒绝访问处理逻辑
    }

}

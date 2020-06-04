package com.cen.ucenter.filter;

import com.alibaba.fastjson.JSON;
import com.cen.common.cache.EHCacheUtil;
import com.cen.common.controller.BaseController;
import com.cen.common.util.C;
import com.cen.common.util.ReturnInfoType;
import com.cen.ucenter.controller.LoginController;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.util.JwtUtil;
import com.cen.ucenter.util.SysTokenUtil;
import org.apache.shiro.web.filter.authc.UserFilter;
import org.apache.shiro.web.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
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
@Component
public class AppSiteFilter extends UserFilter {


    private static final Logger logger = LoggerFactory.getLogger(AppSiteFilter.class);

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
        if (!jwtUtil.verify(token)) {
            User user = (User) EHCacheUtil.get(ReturnInfoType.cen_xczhapp_token, token); //从缓存获取
            if (user != null) { // 没有过期,重新认证
//                LoginController lc = new LoginController();
//                lc.loginHandle(user, false, requests, responses);
            }
            else{
                if (isAjax((HttpServletRequest) request)) {
                    HttpServletResponse httpServletResponse = WebUtils.toHttp(response);
                    httpServletResponse.addHeader("REQUIRE_AUTH", "true");
                    httpServletResponse.setStatus(HttpStatus.UNAUTHORIZED.value());
                } else {
                    saveRequestAndRedirectToLogin(request, response);
                }
            }
        }

        return true;
    }

    private boolean isAjax(HttpServletRequest request) {
        String requestedWithHeader = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equals(requestedWithHeader);
    }

    /**
     * 是否放行
     */
    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
    	BaseController baseController = new BaseController();
		User user = baseController.getUser((HttpServletRequest)request);
		if (user==null) {
			try {
				((HttpServletResponse) response).sendRedirect(((HttpServletRequest) request).getContextPath()+"/userlogin.jsp");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        /*if (null != getSubject(request, response)
                && getSubject(request, response).isAuthenticated()) {
            return true;//已经认证过直接放行
        }*/
        return false;//转到拒绝访问处理逻辑
    }

}

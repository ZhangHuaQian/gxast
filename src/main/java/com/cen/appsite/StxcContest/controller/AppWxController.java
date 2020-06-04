package com.cen.appsite.StxcContest.controller;

import com.alibaba.fastjson.JSONObject;
import com.cen.StxcContestReconrd.service.StxcContestReconrdService;
import com.cen.StxcContestUser.entity.StxcContestUser;
import com.cen.StxcContestUser.service.StxcContestUserService;
import com.cen.appsite.wechat.util.ConfigUtil;
import com.cen.appsite.wechat.util.HttpRequestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 生态乡村知识竞赛
 */

@Controller
@RequestMapping("/appsite/wx")
public class AppWxController {

    @Autowired
    StxcContestUserService<StxcContestUser> stxcContestUserService;

    /**
     * 1 第一步：用户同意授权，获取code
     *
     * 2 第二步：通过code换取网页授权access_token
     *
     * 3 第三步：刷新access_token（如果需要）
     *
     * 4 第四步：拉取用户信息(需scope为 snsapi_userinfo)
     *
     * 5 附：检验授权凭证（access_token）是否有效
     *
     * code=CODE&state=STATE
     * https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
     */

    /**
     * 通过code换取网页授权access_token
     * @param request
     * @param response
     * @return  access_token    网页授权接口调用凭证,注意：此access_token与基础支持的access_token不同
     *          expires_in	access_token接口调用凭证超时时间，单位（秒）
     *          refresh_token	用户刷新access_token
     *          openid	用户唯一标识，请注意，在未关注公众号时，用户访问公众号的网页，也会产生一个用户和公众号唯一的OpenID
     *          scope	用户授权的作用域，使用逗号（,）分隔
     */
    @RequestMapping(value = "/getAccess_token",produces = "application/json; charset=utf-8")
    @ResponseBody
    public String getAccess_token(HttpServletRequest request, HttpServletResponse response,Map map){
        String code = request.getParameter("code");
        System.out.println("=====================================================================================code = "+code);
        String url = "https://api.weixin.qq.com/sns/oauth2/access_token";
        Map<String,String> params = new HashMap<String, String>();
        params.put("appid","wx59f75167d6d25ea4");
        params.put("secret","a0ff75cf900489be9b694dd5effe798d");
        params.put("grant_type","authorization_code");
        String result = HttpRequestUtil.getInfoByNet(url,params,"POST","https",null);
        System.out.println("=====================================================================================result = "+result);
        JSONObject json = JSONObject.parseObject(result);
        String openid = json.getString("openid");

        System.out.println("=====================================================================================11openId = "+openid);

        StxcContestUser stxcContestUser = stxcContestUserService.selectByOpenid(openid);
        if(stxcContestUser == null){
            stxcContestUser = new StxcContestUser();
            stxcContestUser.setOpenid(openid);
            stxcContestUser.setCreateTime(new Date());
            stxcContestUser.setIsLock(0);
            stxcContestUserService.insertSelective(stxcContestUser);
        }
        System.out.println("=====================================================================================22openId = "+openid);
        return openid;
    }

    /**
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/getcode",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String getCode(HttpServletRequest request,HttpServletResponse response){

        return "null";
    }
}

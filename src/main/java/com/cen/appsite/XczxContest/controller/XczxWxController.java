package com.cen.appsite.XczxContest.controller;

import com.alibaba.fastjson.JSONObject;
import com.cen.StxcContestUser.entity.StxcContestUser;
import com.cen.StxcContestUser.service.StxcContestUserService;
import com.cen.XczxContestUser.entity.XczxContestUser;
import com.cen.XczxContestUser.service.XczxContestUserService;
import com.cen.appsite.wechat.util.HttpRequestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 2019年“乡村振兴”知识竞答
 */

@Controller
@RequestMapping("/appsite/xczx/wx")
public class XczxWxController {

    @Autowired
    XczxContestUserService<XczxContestUser> xczxContestUserService;



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
        params.put("code",code);
        params.put("grant_type","authorization_code");
        String result = HttpRequestUtil.getInfoByNet(url,params,"POST","https",null);
        System.out.println("=====================================================================================result = "+result);
        JSONObject json = JSONObject.parseObject(result);
        String openid = json.getString("openid");
        String access_token = json.getString("access_token");

        System.out.println("=====================================================================================11openId = "+openid);

        XczxContestUser xczxContestUser = xczxContestUserService.selectByOpenid(openid);
        if(xczxContestUser == null){
            xczxContestUser = new XczxContestUser();
            xczxContestUser.setOpenid(openid);
            xczxContestUser.setCreateTime(new Date());
            xczxContestUser.setIsLock(0);
            xczxContestUserService.insertSelective(xczxContestUser);
        }
        System.out.println("=====================================================================================22openId = "+openid);

//        判断用户是否关注公众号
        boolean isFollow = judgeIsFollow(openid);
        System.out.println("=====================================================================================isFollow = "+isFollow);
        return isFollow?openid:"0";
//        return openid;
    }


    /**
     * 判断用户是否关注公众号
     * @param openid
     * @return
     */
    private  boolean judgeIsFollow(String openid){
        String access_token = getAccess_token();
        Integer subscribe = 0;
        String url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token="+access_token+"&openid="+openid+"&lang=zh_CN";
        try {
            URL urlGet = new URL(url);
            HttpURLConnection http = (HttpURLConnection) urlGet.openConnection();
            http.setRequestMethod("GET"); // 必须是get方式请求
            http.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
            http.setDoOutput(true);
            http.setDoInput(true);
            http.connect();
            InputStream is = http.getInputStream();
            int size = is.available();
            byte[] jsonBytes = new byte[size];
            is.read(jsonBytes);
            String message = new String(jsonBytes, "UTF-8");
            JSONObject demoJson = JSONObject.parseObject(message);
            System.out.println("JSON字符串："+demoJson);
            subscribe = demoJson.getIntValue("subscribe"); // 此字段为关注字段  关注为1 未关注为0
//            if (subscribe.equals(1)){
//                String nickname = demoJson.getString("demoJson");
//            }
            is.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 1==subscribe?true:false;
    }


    /**
     * 获取基础 access_token, 与网页授权取到的access_token不一样
     * @return
     */
    private String getAccess_token(){
            String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx59f75167d6d25ea4&secret=a0ff75cf900489be9b694dd5effe798d";
            String access_token = "";
        try {
            URL urlGet = new URL(url);
            HttpURLConnection http = (HttpURLConnection) urlGet.openConnection();
            http.setRequestMethod("GET"); // 必须是get方式请求
            http.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
            http.setDoOutput(true);
            http.setDoInput(true);
            http.connect();
            InputStream is = http.getInputStream();
            int size = is.available();
            byte[] jsonBytes = new byte[size];
            is.read(jsonBytes);
            String message = new String(jsonBytes, "UTF-8");
            JSONObject demoJson = JSONObject.parseObject(message);
            System.out.println("JSON字符串："+demoJson);
            access_token = demoJson.getString("access_token"); // 此字段为关注字段  关注为1 未关注为0
            is.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return access_token;
    }
}

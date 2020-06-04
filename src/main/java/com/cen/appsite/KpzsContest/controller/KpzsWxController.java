package com.cen.appsite.KpzsContest.controller;

import com.alibaba.fastjson.JSONObject;
import com.cen.KpzsContestUser.entity.KpzsContestUser;
import com.cen.KpzsContestUser.service.KpzsContestUserService;
import com.cen.StxcContestUser.entity.StxcContestUser;
import com.cen.StxcContestUser.service.StxcContestUserService;
import com.cen.appsite.wechat.util.HttpRequestUtil;
import org.aspectj.bridge.MessageUtil;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 2019年“乡村振兴”知识竞答
 */

@Controller
@RequestMapping("/appsite/kpzs/wx")
public class KpzsWxController {

    @Autowired
    KpzsContestUserService<KpzsContestUser> kpzsContestUserService;

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
        params.put("appid","wx2b2577b751d92b3a");
        params.put("secret","9aadd2d21c8b0c1978d86091393ecc13");
        params.put("code",code);
        params.put("grant_type","authorization_code");
        String result = HttpRequestUtil.getInfoByNet(url,params,"POST","https",null);
        System.out.println("=====================================================================================result = "+result);
        JSONObject json = JSONObject.parseObject(result);
        String openid = json.getString("openid");
        String access_token = json.getString("access_token");

        System.out.println("=====================================================================================11openId = "+openid);

        KpzsContestUser kpzsContestUser = kpzsContestUserService.selectByOpenid(openid);
        if(kpzsContestUser == null){
            kpzsContestUser = new KpzsContestUser();
            kpzsContestUser.setOpenid(openid);
            kpzsContestUser.setCreateTime(new Date());
            kpzsContestUser.setIsLock(0);
            kpzsContestUserService.insertSelective(kpzsContestUser);
        }
        System.out.println("=====================================================================================22openId = "+openid);
        boolean isFollow = judgeIsFollow(openid);
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
        String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx2b2577b751d92b3a&secret=9aadd2d21c8b0c1978d86091393ecc13";
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

    @RequestMapping(value = "/checkSignature", method = RequestMethod.POST)
//    public void checkSignature(@RequestParam("signature") String signature,
//                               @RequestParam("timestamp") String timestamp,
//                               @RequestParam("nonce") String nonce,
//                               @RequestParam("echostr") String echostr,
//                               HttpServletResponse response) {
        public void checkSignature(HttpServletRequest request, HttpServletResponse response) {

        // xml请求解析
        Map<String, String> requestMap = null;
        try {
            requestMap = parseXml(request);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 发送方帐号（open_id）
        String fromUserName = requestMap.get("FromUserName");
        // 公众帐号
        String toUserName = requestMap.get("ToUserName");
        // 消息类型
        String msgType = requestMap.get("MsgType");
        String Event = requestMap.get("Event");
        String EventKey = requestMap.get("EventKey");
        System.err.println("=================================== msgType = "+msgType);
        System.err.println("=================================== Event = "+Event);
        System.err.println("=================================== EventKey = "+EventKey);

        System.err.println("=================================== fromUserName = "+fromUserName);
        System.err.println("=================================== toUserName = "+toUserName);

        if(fromUserName != null && !fromUserName.equals("")){
            KpzsContestUser kpzsContestUser = kpzsContestUserService.selectByOpenid(fromUserName);
            if(kpzsContestUser == null){
                kpzsContestUser = new KpzsContestUser();
                kpzsContestUser.setOpenid(fromUserName);
                kpzsContestUser.setCreateTime(new Date());
                kpzsContestUser.setIsLock(0);
                kpzsContestUserService.insertSelective(kpzsContestUser);
            }
        }

        String img = "<xml>\n" +
                "<ToUserName><![CDATA["+fromUserName+"]]></ToUserName>\n" +
                "<FromUserName><![CDATA["+toUserName+"]]></FromUserName>\n" +
                "<CreateTime>"+new Date().getTime()+"</CreateTime>\n" +
                "<MsgType><![CDATA[news]]></MsgType>\n" +
                "<ArticleCount>1</ArticleCount>\n" +
                "<Articles>\n" +
                "<item>\n" +
                "<Title><![CDATA[2019“倡导绿色环保生活”科普知识挑战赛]]></Title>\n" +
                "<Description><![CDATA[快来参与吧!]]></Description>\n" +
                "<PicUrl><![CDATA[http://www.gxkpcb.com/resource/images/kpzs.png]]></PicUrl>\n" +
                "<Url><![CDATA[http://www.gxkpcb.com/web/answer/kpzs_index.jsp?openid="+fromUserName+"]]></Url>\n" +
                "</item>\n" +
                "</Articles>\n" +
                "</xml>\n";


        String text = "<xml>\n" +
                "  <ToUserName><![CDATA["+fromUserName+"]]></ToUserName>\n" +
                "  <FromUserName><![CDATA["+toUserName+"]]></FromUserName>\n" +
                "  <CreateTime>"+new Date().getTime()+"</CreateTime>\n" +
                "  <MsgType><![CDATA[text]]></MsgType>\n" +
                "  <Content><![CDATA[暂无法识别]]></Content>\n" +
                "  <MsgId>1234567890123456</MsgId>\n" +
                "</xml>";

        try {
            PrintWriter out = response.getWriter();
            // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
            if (SignUtil.checkSignature(request.getParameter("signature"), request.getParameter("timestamp"), request.getParameter("nonce"))) {
                if(Event != null && Event.equals("CLICK")){
                    out.print(img);
                }else{
                    out.print(text);
                }
            }
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public static Map<String, String> parseXml(HttpServletRequest request) throws Exception {
        // 将解析结果存储在HashMap中
        Map<String, String> map = new HashMap<String, String>();

        // 从request中取得输入流
        InputStream inputStream = request.getInputStream();
        // 读取输入流
        SAXReader reader = new SAXReader();
        Document document = reader.read(inputStream);
        // 得到xml根元素
        Element root = document.getRootElement();
        // 得到根元素的所有子节点
        List<Element> elementList = root.elements();

        // 遍历所有子节点
        for (Element e : elementList)
            map.put(e.getName(), e.getText());

        // 释放资源
        inputStream.close();
        inputStream = null;
        return map;
    }

}

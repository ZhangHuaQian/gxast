package com.cen.appsite.GzbdContest.controller;

import com.alibaba.fastjson.JSONObject;
import com.cen.GzbdContestUser.entity.GzbdContestUser;
import com.cen.GzbdContestUser.service.GzbdContestUserService;
import com.cen.KpzsContestUser.entity.KpzsContestUser;
import com.cen.KpzsContestUser.service.KpzsContestUserService;
import com.cen.appsite.wechat.util.HttpRequestUtil;
//import org.dom4j.Document;
//import org.dom4j.Element;
import org.apache.http.HttpResponse;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
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
 * 科学防控 共同战“疫”
 *  “大众科普”新型冠状病毒防控科普知识网络答题
 */

@Controller
@RequestMapping("/appsite/gzbd/wx")
public class GzbdWxController {

    @Autowired
    GzbdContestUserService<GzbdContestUser> gzbdContestUserService;


    @RequestMapping(value = "/checkSignature")

        public void checkSignature(HttpServletRequest request, HttpServletResponse response) {
//         xml请求解析
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
        String Content = requestMap.get("Content");
        System.err.println("=================================== msgType = "+msgType);
        System.err.println("=================================== Event = "+Event);
        System.err.println("=================================== EventKey = "+EventKey);
        System.err.println("=================================== Content = "+Content);

        System.err.println("=================================== fromUserName = "+fromUserName);
        System.err.println("=================================== toUserName = "+toUserName);

        if(fromUserName != null && !fromUserName.equals("")){
            GzbdContestUser gzbdContestUser = gzbdContestUserService.selectByOpenid(fromUserName);

            if(gzbdContestUser == null){
                gzbdContestUser = new GzbdContestUser();
                gzbdContestUser.setOpenid(fromUserName);
                gzbdContestUser.setCreateTime(new Date());
                gzbdContestUser.setIsLock(0);
                gzbdContestUserService.insertSelective(gzbdContestUser);
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
                "<Title><![CDATA[2020全国科技工作者日“挑战100问”科普达人挑战赛]]></Title>\n" +
                "<Description><![CDATA[科技为民  奋斗有我]]></Description>\n" +
                "<PicUrl><![CDATA[http://www.gxkpcb.com/resource/images/bjt.png]]></PicUrl>\n" +
                "<Url><![CDATA[http://www.gxkpcb.com/web/GXKX/gzbd_contest.jsp?openid="+fromUserName+"]]></Url>\n" +
                "</item>\n" +
                "</Articles>\n" +
                "</xml>\n";

        String text = "<xml>\n" +
                "  <ToUserName><![CDATA["+fromUserName+"]]></ToUserName>\n" +
                "  <FromUserName><![CDATA["+toUserName+"]]></FromUserName>\n" +
                "  <CreateTime>"+new Date().getTime()+"</CreateTime>\n" +
                "  <MsgType><![CDATA[text]]></MsgType>\n" +
                "  <Content><![CDATA[科学防控，共同战“疫”！]]></Content>\n" +
                "  <MsgId>1234567890123456</MsgId>\n" +
                "</xml>";


        try {
            PrintWriter out = response.getWriter();
            System.err.println("------------------------------------------------------------------------------------------------------- signature "+request.getParameter("signature"));
            System.err.println("------------------------------------------------------------------------------------------------------- timestamp "+request.getParameter("timestamp"));
            System.err.println("------------------------------------------------------------------------------------------------------- nonce "+request.getParameter("nonce"));
            // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
            if (SignUtil.checkSignature(request.getParameter("signature"), request.getParameter("timestamp"), request.getParameter("nonce"))) {
                System.err.println("------------------------------------------------------------------------------------------------------- echostr "+request.getParameter("echostr"));
                /*
                * 开发者通过检验signature对请求进行校验（下面有校验方式）。若确认此次GET请求来自微信服务器，请原样返回echostr参数内容，
                * 则接入生效，成为开发者成功，否则接入失败,提示token验证失败。加密/校验流程如下：
                * 1）将token、timestamp、nonce三个参数进行字典序排序
                * 2）将三个参数字符串拼接成一个字符串进行sha1加密 3）开发者获得加密后的字符串可与signature对比，标识该请求来源于微信
                * */
                out.print(request.getParameter("echostr"));
//                if(Event != null && Event.equals("CLICK")){
//                    out.print(img);
//                }else{
//                    out.print(text);
//                }
                /**当用户发送消息给公众号时（或某些特定的用户操作引发的事件推送时），会产生一个POST请求，开发者可以在响应包（Get）
                 *中返回特定XML结构，来对该消息进行响应（现支持回复文本、图片、图文、语音、视频、音乐）
                 * 假如服务器无法保证在五秒内处理并回复，必须做出下述回复，这样微信服务器才不会对此作任何处理，并且不会发起重试（这种情况下，可以使用客服消息接口进行异步回复），否则，将出现严重的错误提示。详见下面说明：
                 *
                 * 1、直接回复success（推荐方式） 2、直接回复空串（指字节长度为0的空字符串，而不是XML结构体中content字段的内容为空）
                 *
                 * 一旦遇到以下情况，微信都会在公众号会话中，向用户下发系统提示“该公众号暂时无法提供服务，请稍后再试”：
                 *
                 * 1、开发者在5秒内未回复任何内容 2、开发者回复了异常数据，比如JSON数据等
                 */
//                 if(Event != null && Event.equals("CLICK")){
//                    out.print(img);
//                }else{
//                     out.print(text);
//                }
                if(Content.equals("测试")){
                    out.print(img);
                }else{
                    out.print(text);
                }
            }
            out.close();
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
        org.dom4j.Document document = reader.read(inputStream);
        // 得到xml根元素
        org.dom4j.Element root = document.getRootElement();
        // 得到根元素的所有子节点
        List<org.dom4j.Element> elementList = root.elements();

        // 遍历所有子节点
        for (org.dom4j.Element e : elementList)
            map.put(e.getName(), e.getText());

        // 释放资源
        inputStream.close();
        inputStream = null;
        return map;
    }

}

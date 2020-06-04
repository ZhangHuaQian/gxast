package com.cen.appsite.wechat.util;

import com.alibaba.fastjson.JSON;
import com.cen.appsite.wechat.entity.ArticleVo;
import com.cen.appsite.wechat.entity.CustomerServiceNewsMessageVo;
import com.cen.appsite.wechat.entity.CustomerServiceTextMessageVo;
import com.cen.appsite.wechat.entity.NewsVo;
import com.cen.appsite.wechat.entity.TextContentVo;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 微信客服消息工具类
 */
public class WxCustomerServiceMessageUtil {
    private static final Logger logger = Logger.getLogger(WxCustomerServiceMessageUtil.class);
    private static final String REQUEST_URL = "https://api.weixin.qq.com/cgi-bin/message/custom/send";

    /**
     * 推送客服图文消息
     * @param touser 图文消息接受对象 opendId
     * @param title 图文消息标题
     * @param description 图文消息描述
     * @param url 图文消息跳转链接
     * @param picurl 图文消息封面图片
     * @return
     */
    public static String sendNewsMessage(String touser, String title, String description, String url, String picurl){
        try {
            if(StringUtils.isBlank(touser) || StringUtils.isBlank(title) || StringUtils.isBlank(description)){
                logger.error("推送客服图文消息异常，touser：" + touser + ",title:" + title  + ",description:" + description);
                return null;
            }else{
                WeChatUtil.getAccessToken();
                String accessToken = ConfigUtil.ACCESS_TOKEN;
                if(StringUtils.isBlank(accessToken)){
                    logger.error("accessToken：" + accessToken);
                    System.out.println(new String[]{"accessToken为空!"});
                    return "accessToken为空!";
                    //throw new BusinessException(ResGlobal.ERRORS_USER_DEFINED, new String[]{"accessToken为空!"});
                }else{
                    Map<String, String> paramMap = new HashMap<String, String>();
                    paramMap.put("access_token", accessToken);

                    ArticleVo articleVo = new ArticleVo();
                    articleVo.setDescription(description);
                    articleVo.setTitle(title);
                    if(StringUtils.isNotBlank(url)){
                        articleVo.setUrl(url);
                    }
                    if(StringUtils.isNotBlank(picurl)){
                        articleVo.setPicurl(picurl);
                    }
                    List<ArticleVo> articles = new ArrayList<ArticleVo>();
                    articles.add(articleVo);

                    NewsVo newsVo = new NewsVo();
                    newsVo.setArticles(articles);

                    CustomerServiceNewsMessageVo customerServiceNewsMessageVo = new CustomerServiceNewsMessageVo();
                    customerServiceNewsMessageVo.setNews(newsVo);
                    customerServiceNewsMessageVo.setMsgtype(MsgTypeEnum.NEWS.toName());
                    customerServiceNewsMessageVo.setTouser(touser);
                    String outputStr = JSON.toJSONString(customerServiceNewsMessageVo);
                    String resultStr = HttpRequestUtil.getInfoByNet(REQUEST_URL,paramMap,"POST","http",outputStr);
                    /*String jsonParam = JsonBinder.buildNonNullBinder().toJson(customerServiceNewsMessageVo);
                    String resultStr = WeixinWebUtil.doPost(REQUEST_URL, paramMap, jsonParam, "UTF-8", 3000, 3000);*/
                    System.out.println(resultStr);
                    logger.debug("推送客服图文消息结果：" + resultStr);
                    return resultStr;
                }
            }
        }catch (Exception e) {
            logger.error("推送客服图文消息失败");
            System.out.println(new String[]{e.getMessage()});
            return e.getMessage();
            //throw new BusinessException(ResGlobal.ERRORS_USER_DEFINED, new String[]{e.getMessage()});
        }
    }

    /**
     * 推送客服图文消息
     * @param touser 图文消息接受对象 opendId
     * @param title 图文消息标题
     * @param description 图文消息描述
     * @param url 图文消息跳转链接
     * @param picurl 图文消息封面图片
     * @return
     */
    public static ConcurrentLinkedQueue sendNewsMessageToArray(List<String> touser, String title, String description, String url, String picurl){
        Long starttime = System.currentTimeMillis();
        AtomicInteger ai = new AtomicInteger(0);//并发环境下线程安全的原子操作的Integer类，通过线程安全的方式操作加减
        ConcurrentLinkedQueue errorOpenid = new ConcurrentLinkedQueue();//ConcurrentLinkedQueue是“线程安全”的队列，而LinkedList是非线程安全的
        try {
            if(touser.size()<=0|| StringUtils.isBlank(title) || StringUtils.isBlank(description)){
                logger.error("推送客服图文消息异常，touser：" + touser + ",title:" + title  + ",description:" + description);
                return null;
            }else{
                WeChatUtil.getAccessToken();
                String accessToken = ConfigUtil.ACCESS_TOKEN;
                if(StringUtils.isBlank(accessToken)){
                    logger.error("accessToken：" + accessToken);
                    System.out.println(new String[]{"accessToken为空!"});
                    //return "accessToken为空!";
                    //throw new BusinessException(ResGlobal.ERRORS_USER_DEFINED, new String[]{"accessToken为空!"});
                }else{
                    Map<String, String> paramMap = new HashMap<String, String>();
                    paramMap.put("access_token", accessToken);

                    ArticleVo articleVo = new ArticleVo();//图文对象
                    List<ArticleVo> articles = new ArrayList<ArticleVo>();//图文集合
                    articleVo.setDescription(description);
                    articleVo.setTitle(title);
                    if(StringUtils.isNotBlank(url)){
                        articleVo.setUrl(url);
                    }
                    if(StringUtils.isNotBlank(picurl)){
                        articleVo.setPicurl(picurl);
                    }
                    articles.add(articleVo);

                    NewsVo newsVo = new NewsVo();//多图文对象
                    newsVo.setArticles(articles);
                    String resultStr = "";
                    CustomerServiceNewsMessageVo customerServiceNewsMessageVo = new CustomerServiceNewsMessageVo();//多图文客户端群发对象
                    customerServiceNewsMessageVo.setNews(newsVo);
                    customerServiceNewsMessageVo.setMsgtype(MsgTypeEnum.NEWS.toName());

                    BlockingQueue<Runnable> queue = new LinkedBlockingQueue<Runnable>(20000);
                    ThreadPoolExecutor executors = new ThreadPoolExecutor(5, 10, 60000, TimeUnit.SECONDS, queue);

                    // 要推送的用户总数
                    int count = touser.size();
                    logger.info("message all count=" + count);
                    // 初始每个线程处理的用户数量
                    final int eveLength = 50;
                    // 计算处理所有用户需要的线程数量
                    int eveBlocks = count / eveLength + (count % eveLength != 0 ? 1 : 0);
                    logger.info("need thread's count=" + eveBlocks);
                    // 线程计数器
                    CountDownLatch doneSignal = new CountDownLatch(eveBlocks);

                    // 开启线程处理
                    int doneCount = 0;
                    for (int page = 0; page < eveBlocks; page++) { /* blocks太大可以再细分重新调度 */
                        WachatMagSendThread ms = new WachatMagSendThread(customerServiceNewsMessageVo, paramMap, touser, page, eveLength, doneSignal,ai,errorOpenid);
                        executors.execute(ms);
                        // logger.info("start thread =>{}",page+1);
                        doneCount++;
                    }
                    doneSignal.await();// 等待所有计数器线程执行完

                    Long endtime = System.currentTimeMillis();
                    System.out.println("需发送"+count+"条数据,已执行"+ai+"条数据,耗时"+(endtime-starttime)+"毫秒");

                    /*for(String s:touser){
                        customerServiceNewsMessageVo.setTouser(s);
                        String outputStr = JSON.toJSONString(customerServiceNewsMessageVo);
                        resultStr = HttpRequestUtil.getInfoByNet(REQUEST_URL,paramMap,"POST","http",outputStr);
                    }*/
                    /*String jsonParam = JsonBinder.buildNonNullBinder().toJson(customerServiceNewsMessageVo);
                    String resultStr = WeixinWebUtil.doPost(REQUEST_URL, paramMap, jsonParam, "UTF-8", 3000, 3000);*/
                    //System.out.println(resultStr);
                    //logger.debug("推送客服图文消息结果：" + resultStr);
                    //return resultStr;
                }
            }
        }catch (Exception e) {
            logger.error("推送客服图文消息失败");
            System.out.println(new String[]{e.getMessage()});
            //return e.getMessage();
            //throw new BusinessException(ResGlobal.ERRORS_USER_DEFINED, new String[]{e.getMessage()});
        }finally {
            return errorOpenid;
        }
    }

    /**
     * 推送客服文本消息
     * @param msg 文本消息内容
     * @param touser 文本消息接受对象 opendId
     * @return
     */
    public static String sendTextMessage(String msg, String touser) {
        try {
            if(StringUtils.isBlank(msg) || StringUtils.isBlank(touser)){
                logger.error("推送客服文本消息异常，msg：" + msg + ",touser:" + touser);
                return null;
            }else{
                WeChatUtil.getAccessToken();
                String accessToken = ConfigUtil.ACCESS_TOKEN;
                if(StringUtils.isBlank(accessToken)){
                    logger.error("accessToken：" + accessToken);
                    System.out.println(new String[]{"accessToken为空!"});
                    return "accessToken为空!";
                    //throw new BusinessException(ResGlobal.ERRORS_USER_DEFINED, new String[]{"accessToken为空!"});
                }else{
                    Map<String, String> paramMap = new HashMap<String, String>();
                    paramMap.put("access_token", accessToken);

                    TextContentVo textContentVo = new TextContentVo();
                    textContentVo.setContent(msg);
                    CustomerServiceTextMessageVo customerServiceTextMessageVo = new CustomerServiceTextMessageVo();
                    customerServiceTextMessageVo.setMsgtype(MsgTypeEnum.TEXT.toName());
                    customerServiceTextMessageVo.setText(textContentVo);
                    customerServiceTextMessageVo.setTouser(touser);
                    String outputStr = JSON.toJSONString(customerServiceTextMessageVo);
                    String resultStr = HttpRequestUtil.getInfoByNet(REQUEST_URL,paramMap,"POST","http",outputStr);
                    //String jsonParam = JsonBinder.buildNonNullBinder().toJson(customerServiceTextMessageVo);
                    // resultStr = WeixinWebUtil.doPost(REQUEST_URL, paramMap, jsonParam, "UTF-8", 3000, 3000);
                    System.out.println(resultStr);
                    logger.debug("推送客服文本消息结果：" + resultStr);
                    return resultStr;
                }
            }
        }catch (Exception e) {
            logger.error("推送客服文本消息失败");
            System.out.println(new String[]{e.getMessage()});
            return e.getMessage();
            //throw new BusinessException(ResGlobal.ERRORS_USER_DEFINED, new String[]{e.getMessage()});
        }
    }
}

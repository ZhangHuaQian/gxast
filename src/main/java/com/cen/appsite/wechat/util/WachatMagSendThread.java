package com.cen.appsite.wechat.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cen.appsite.wechat.entity.CustomerServiceNewsMessageVo;

import org.apache.log4j.Logger;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.atomic.AtomicInteger;

public class WachatMagSendThread implements Runnable {

    private static Logger logger = Logger.getLogger(WachatMagSendThread.class);
    private static final String REQUEST_URL = "https://api.weixin.qq.com/cgi-bin/message/custom/send";
    private CustomerServiceNewsMessageVo newsMessageVo;//多图文客户端群发对象
    private Map<String, String> paramMap;//url参数Map，包含token
    //private String accessToken;//公众号token
    private List<String> openIdList;//微信OpenID列表
    //private String content;//消息内容
    private int currentIndex;//当前索引
    private int rows;//处理数据条数
    private CountDownLatch doneSignal;//处理线程条数
    private AtomicInteger ai;
    private ConcurrentLinkedQueue errorOpenid;

    public WachatMagSendThread(CustomerServiceNewsMessageVo newsMessageVo, Map<String, String> paramMap, List<String> openIdList, int currentIndex, int rows, CountDownLatch doneSignal,AtomicInteger ai,ConcurrentLinkedQueue errorOpenid) {
        this.newsMessageVo = newsMessageVo;
        this.paramMap = paramMap;
        this.openIdList = openIdList;
        this.currentIndex = currentIndex;
        this.rows = rows;
        this.doneSignal = doneSignal;
        this.ai = ai;
        this.errorOpenid = errorOpenid;
    }

    /**
     * When an object implementing interface <code>Runnable</code> is used
     * to create a thread, starting the thread causes the object's
     * <code>run</code> method to be called in that separately executing
     * thread.
     * <p>
     * The general contract of the method <code>run</code> is that it may
     * take any action whatsoever.
     *
     * @see Thread#run()
     */
    @Override
    public void run() {
        // 查询当前的block范围内的发送的OpenID---------
        List<String> openIdArray = filterOpenIds(openIdList, currentIndex, rows);
        try {
            // 设置发送消息的参数
            /*JSONObject msgJson = new JSONObject();
            msgJson.put("touser", openIdArray);
            msgJson.put("msgtype", "text");
            JSONObject contentJson = new JSONObject();
            contentJson.put("content", content);
            msgJson.put("text", contentJson);*/
            String resultStr = "";
            for(String s:openIdArray){
                newsMessageVo.setTouser(s);
                String outputStr = JSON.toJSONString(newsMessageVo);
                resultStr = HttpRequestUtil.getInfoByNet(REQUEST_URL,paramMap,"POST","http",outputStr);
                JSONObject jsonObject1 = JSONObject.parseObject(resultStr);
                if(!jsonObject1.get("errmsg").toString().equals("ok")){
                    errorOpenid.add(s);
                }
                ai.getAndIncrement();
                System.out.println(resultStr);
                logger.debug("推送客服图文消息结果：" + resultStr);
            }
                    /*String jsonParam = JsonBinder.buildNonNullBinder().toJson(customerServiceNewsMessageVo);
                    String resultStr = WeixinWebUtil.doPost(REQUEST_URL, paramMap, jsonParam, "UTF-8", 3000, 3000);*/
            //DSHWechatAPIHander.sendMessage(accessToken, msgJson.toString());发送
        } catch (Exception e) {
            logger.error("send message thread exception=>{" + openIdArray.toString() + "}{" + e.getMessage() + "}");
            e.printStackTrace();
        } finally {
            doneSignal.countDown();//工人完成工作，计数器减一
        }
    }

    /**
     * 筛选目标客户群OpenID
     * @param openIdList OpenID
     * @param currentIndex 当前索引
     * @param rows 处理数据条数
     * @return
     */
    private List<String> filterOpenIds(List<String> openIdList, int currentIndex, int rows) {
        int startIndex = currentIndex * rows;
        int endIndex = (currentIndex + 1) * rows;
        if (endIndex > openIdList.size()) {
            endIndex = openIdList.size();
        }
        List<String> openIdArray = new LinkedList<String>();
        for (int i = startIndex; i < endIndex; i++) {
            openIdArray.add(openIdList.get(i));
        }
        return openIdArray;
    }
}

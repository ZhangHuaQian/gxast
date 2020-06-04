package com.cen.common.util;

import cn.jpush.api.push.model.Message;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import cn.jiguang.common.ClientConfig;
import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.Options;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.AndroidNotification;
import cn.jpush.api.push.model.notification.IosNotification;
import cn.jpush.api.push.model.notification.Notification;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by cenguocheng on 2018/10/8.
 * 137544496@qq.com
 * 极光推送
 */
@SuppressWarnings({ "deprecation", "restriction" })
public class JiguangPush {

    private static final Logger log = LoggerFactory.getLogger(JiguangPush.class);
    private static String masterSecret = "e77721040e1da90d3619a61e";
    private static String appKey = "dcc476f6f07c27daf8fee007";

    /**
     * 极光推送测试
     */
    /*public void jiguangPush(){
        String alias = "123456";//声明别名
        log.info("对别名" + alias + "的用户推送信息");
        PushResult result = push(String.valueOf(alias),ALERT);
        if(result != null && result.isResultOK()){
            log.info("针对别名" + alias + "的信息推送成功！");
        }else{
            log.info("针对别名" + alias + "的信息推送失败！");
        }
    }*/

    /**
     * 生成极光推送对象PushPayload（采用java SDK）
     * @param registrationIds
     * @param alert
     * @return PushPayload
     */
    public static PushPayload buildPushObject_android_ios_alias_alert(List registrationIds,String alert,Map map){
        return PushPayload.newBuilder()
                .setPlatform(Platform.android_ios())
                //.setAudience(Audience.alias(alias))
                .setAudience(Audience.registrationId(registrationIds))
                .setNotification(Notification.newBuilder()
                        .addPlatformNotification(AndroidNotification.newBuilder()
                                .addExtra("type", "infomation")
                                //.addExtra("yjxx", "dahuang")
                                .addExtras(map)
                                .setAlert(alert)
                                .build())
                        .addPlatformNotification(IosNotification.newBuilder()
                                .addExtra("type", "infomation")
                                //.addExtra("yjxx", "dahuang")
                                .addExtras(map)
                                .setAlert(alert)
                                //.setCategory("music")
                                .setBadge(1)
                                .build())
                        .build())
                .setOptions(Options.newBuilder()
                        .setApnsProduction(true)//数据线安装=false 其他=true
                        .setTimeToLive(90)//消息在JPush服务器的失效时间（测试使用参数）
                        .build())
                .build();
    }

    /**
     * 极光推送方法(采用java SDK)
     * @param registrationIds
     * @param alert
     * @return PushResult
     */
    public static PushResult push(List registrationIds, String alert,Map map){
        ClientConfig clientConfig = ClientConfig.getInstance();
        JPushClient jpushClient = new JPushClient(masterSecret, appKey, null, clientConfig);
        PushPayload payload = buildPushObject_android_ios_alias_alert(registrationIds,alert,map);
        try {
            return jpushClient.sendPush(payload);
        } catch (APIConnectionException e) {
            log.error("Connection error. Should retry later. ", e);
            return null;
        } catch (APIRequestException e) {
            log.error("Error response from JPush server. Should review and fix it. ", e);
            log.info("HTTP Status: " + e.getStatus());
            log.info("Error Code: " + e.getErrorCode());
            log.info("Error Message: " + e.getErrorMessage());
            log.info("Msg ID: " + e.getMsgId());
            return null;
        }
    }

    /**
     * 广播推送
     * @param alert
     * @return
     */
    public static PushResult buildPushObject_all_alias_alert(String alert,String message){
        ClientConfig clientConfig = ClientConfig.getInstance();
        JPushClient jpushClient = new JPushClient(masterSecret, appKey, null, clientConfig);
        PushPayload payload = PushPayload.newBuilder()
                .setPlatform(Platform.all())//设置接受的平台  
                .setAudience(Audience.all())//Audience设置为all，说明采用广播方式推送，所有用户都可以接收到  
               .setNotification(Notification.alert(alert)).setMessage(Message.content(message))
                .setOptions(Options.newBuilder()
                        .setApnsProduction(true)//数据线安装=false 其他=true
                        .setTimeToLive(90)//消息在JPush服务器的失效时间（测试使用参数）
                        .build())
              .build();
        try {
            return jpushClient.sendPush(payload);
        } catch (APIConnectionException e) {
            log.error("Connection error. Should retry later. ", e);
            return null;
        } catch (APIRequestException e) {
            log.error("Error response from JPush server. Should review and fix it. ", e);
            log.info("HTTP Status: " + e.getStatus());
            log.info("Error Code: " + e.getErrorCode());
            log.info("Error Message: " + e.getErrorMessage());
            log.info("Msg ID: " + e.getMsgId());
            return null;
        }
    }

}

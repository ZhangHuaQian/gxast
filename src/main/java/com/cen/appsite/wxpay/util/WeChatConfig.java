package com.cen.appsite.wxpay.util;


/**
 * 微信支付配置文件
 * @author chenp
 *
 */
public class WeChatConfig {

    /**
     * 微信服务号APPID
     */
    public static String APPID="wx7200c9ff960a6b41";
    /**
     * 微信支付的商户号
     */
    public static String MCHID="1565043481";
    /**
     * 微信支付的API密钥
     */
    public static String APIKEY="adb01234841bc96a4bda898f8a44a734";
    /**
     * 微信支付成功之后的回调地址【注意：当前回调地址必须是公网能够访问的地址】
     */
    public static String WECHAT_NOTIFY_URL_PC="http://wxdev.sx-tech.net/gxast/wx/wechat_notify_url_pc";
    /**
     * 微信统一下单API地址
     */
    public static String UFDODER_URL="https://api.mch.weixin.qq.com/pay/unifiedorder";
    /**
     * true为使用真实金额支付，false为使用测试金额支付（1分）
     */
    public static String WXPAY="";

}
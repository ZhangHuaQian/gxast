package com.cen.appsite.wxpay.util;

import java.math.BigDecimal;

/**
 * 微信支付需要的一些参数
 *
 */
public class WeChatParams {

    public String total_fee;//订单金额【备注：以分为单位】
    public String body;//商品名称
    public String out_trade_no;//订单号
    public String attach;//订单额外描述
    public String time_expire;//二维码失效时间

    public String getTime_expire() {
        return time_expire;
    }

    public void setTime_expire(String time_expire) {
        this.time_expire = time_expire;
    }

    public String getAttach() {
        return attach;
    }

    public void setAttach(String attach) {
        this.attach = attach;
    }

    public String getTotal_fee() {
        return total_fee;
    }

    public void setTotal_fee(String total_fee) {
        this.total_fee = total_fee;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getOut_trade_no() {
        return out_trade_no;
    }

    public void setOut_trade_no(String out_trade_no) {
        this.out_trade_no = out_trade_no;
    }

}
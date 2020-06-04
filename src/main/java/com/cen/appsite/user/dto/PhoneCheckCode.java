package com.cen.appsite.user.dto;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by cenguocheng on 2018/8/20.
 * 137544496@qq.com
 */
public class PhoneCheckCode  implements Serializable{

    private String phone; // 手机号码
    private Date createDate; // 创建时间
    private String CheckCode; //验证码
    private String requestIP; // 客户端IP
    private String sendMsg; //发送消息
    private String returnMsg; // 结果信息
    private String status; // 状态
    private String type; // 验证码类型
    private int sendNum;// 发送计数

    public PhoneCheckCode(){}

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCheckCode() {
        return CheckCode;
    }

    public void setCheckCode(String checkCode) {
        CheckCode = checkCode;
    }

    public String getRequestIP() {
        return requestIP;
    }

    public void setRequestIP(String requestIP) {
        this.requestIP = requestIP;
    }

    public String getSendMsg() {
        return sendMsg;
    }

    public void setSendMsg(String sendMsg) {
        this.sendMsg = sendMsg;
    }

    public String getReturnMsg() {
        return returnMsg;
    }

    public void setReturnMsg(String returnMsg) {
        this.returnMsg = returnMsg;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getSendNum() {
        return sendNum;
    }

    public void setSendNum(int sendNum) {
        this.sendNum = sendNum;
    }

    public void setBath( String checkCode, String requestIP, String type) {
        this.createDate = new Date();
        CheckCode = checkCode;
        this.requestIP = requestIP;
        this.type = type;
    }
}

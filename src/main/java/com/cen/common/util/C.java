package com.cen.common.util;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by cenguocheng on 2018/7/25.
 * 137544496@qq.com
 * AJAX 统一格式对象
 */
public class C {

    private String msg; //提示信息
    private String Status; // 处理状态
    private String token; //token
    private Map data = new HashMap();// 返回结果

    public C() {}

    public C(String msg, String status) {
        this.msg = msg;
        Status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }

    public Map getData() {
        return data;
    }

    public void setData(Map data) {
        this.data = data;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}

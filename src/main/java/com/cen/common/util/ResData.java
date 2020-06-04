package com.cen.common.util;

import com.alibaba.fastjson.JSON;

/**
 * 响应数据结构封装
 * Created by cenguocheng on 2019-03-09.
 * 137544496@qq.com
 */
public class ResData<T> {
    private String status; // 状态码

    private String msg; // 提示语

    private T data;  // 数据集合

    public static <T> ResData<T> SUCCESS(T data) {
        return new ResData<T>(Status.SUCCESS.status, Status.SUCCESS.msg, data);
    }

    public static <T> ResData<T> SUCCESS() {
        return new ResData<T>(Status.SUCCESS.status, Status.SUCCESS.msg);
    }
    
    public static <T> ResData<T> SUCCESSMSG(String msg) {
        return new ResData<T>(Status.SUCCESS.status, msg);
    }

    public static <T> ResData<T> FAIL(String msg) {
        return new ResData<T>(Status.FAIL.status, msg);
    }

    public static <T> ResData<T> FAIL() {
        return new ResData<T>(Status.FAIL.status, Status.FAIL.msg);
    }

    public static <T> ResData<T> ERROR(String msg) {
        return new ResData<T>(Status.ERROR.status, msg);
    }

    public static <T> ResData<T> ERROR() {
        return new ResData<T>(Status.ERROR.status, Status.ERROR.msg);
    }


    public ResData(String status, String msg, T data) {
        this.status = status;
        this.msg = msg;
        this.data = data;
    }

    public ResData(String status, String msg) {
        this.status = status;
        this.msg = msg;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String toString() {
        return JSON.toJSONString(this);
    }
    
}

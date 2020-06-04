package com.cen.common.util;

/**
 * Created by cenguocheng on 2019-03-09.
 * 137544496@qq.com
 */
public enum Status {

    FAIL("0", "失败")
    ,SUCCESS("1", "成功")
    ,ERROR("2", "错误")
    ,USER_NOFOUND("3", "用户不存在")
    ,VALIDATECodeERROR("4", "验证码有误")
    ,USER_EXIST("5", "用户已存在")
    ,USER_LOCK("6", "用户被锁定，请联系管理员")
    ,IP_LOCK("7", "IP 被锁定，请联系管理员")
    ,LOGIN_FAIL("8", "账号或密码错误")
    ,PARAM_ERROR("400", "参数错误")

    ,Token_Expired("1044", "token Invalid expired") // token 失效
    ;

    public String status; // 状态码
    public String msg; // 提示语

    Status(String status, String msg) {
        this.status = status;
        this.msg = msg;
    }

}
